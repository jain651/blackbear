//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "HoopReinforcement.h"

registerMooseObject("BlackBearApp", HoopReinforcement);

defineLegacyParams(HoopReinforcement);

InputParameters
HoopReinforcement::validParams()
{
  InputParameters params = DiracKernel::validParams();
  params.addRequiredParam<VariableName>("hoop_strain", "a component of strain tensor");
  params.addRequiredParam<Real>("yield_strength", "Yield strength of the rebar");
  params.addRequiredParam<Real>("youngs_modulus", "Elastic modulus of the rebar");
  params.addRequiredParam<Real>("area", "Area of the rebar");
  // params.addParam<FileName>("points_in_file", "The x,y,z coordinates of the point in a file");
  // params.addParam<MooseEnum>(
        // "format", format, "Format of csv data file that is in either in columns or rows");
  params.addParam<std::vector<Point>>("points", "The x,y,z coordinates of the point");
  return params;
}

HoopReinforcement::HoopReinforcement(const InputParameters & parameters)
  : DiracKernel(parameters),
    _number(_subproblem
                    .getVariable(_tid,
                                 parameters.get<VariableName>("hoop_strain"),
                                 Moose::VarKindType::VAR_ANY,
                                 Moose::VarFieldType::VAR_FIELD_STANDARD)
                    .number()),
    _system(_subproblem.getSystem(getParam<VariableName>("hoop_strain"))),
    _fy(getParam<Real>("yield_strength")),
    _E(getParam<Real>("youngs_modulus")),
    _A(getParam<Real>("area")),
    _point_param(getParam<std::vector<Point>>("points"))

{
  // if (!parameters.isParamValid("points") && !parameters.isParamValid("points_in_file"))
  //   mooseError("Point location is not provided.");
  // if(isParamValid("points"))
  //   _point_param(getParam<std::vector<Point>>("points"));
  // else(isParamValid("points_in_file"))
  //   getPointFromFile();
}

// void
// HoopReinforcement::getPointFromFile()
// {
//   // copied from PiecewiseTabularBase
//   // Input parameters
//   const FileName & data_file_name = getParam<FileName>("points_in_file");
//   const MooseEnum & format = getParam<MooseEnum>("format");
//
// }

void
HoopReinforcement::addPoints()
{
  for (size_t num_pts = 0; num_pts < _point_param.size(); num_pts++)
    addPoint(_point_param[num_pts]);
}

Real
HoopReinforcement::computeQpResidual()
{
  Real strain = _system.point_value(_number, _current_point, false);
  Real force;
  if(strain>0.)
    force = - fmin(_E*strain, _fy) * _A;
  else
    force = - fmax(_E*strain, _fy) * _A;
  out <<" out force " << force << " pt "<< _current_point(0) << " " << _current_point(1) << " " << _current_point(2) << std::endl;

  return -force;
}
