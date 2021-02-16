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
  params.addRequiredParam<VariableName>("strain", "a component of strain tensor");
  params.addRequiredParam<Real>("yield_strength", "Yield strength of the rebar");
  params.addRequiredParam<Real>("elastic_modulus", "Elastic modulus of the rebar");
  params.addRequiredParam<Real>("area", "Area of the rebar");
  params.addRequiredParam<std::vector<Point>>("points", "The x,y,z coordinates of the point");
  // params.addRequiredParam<std::vector<Real>>("point", "The x,y,z coordinates of the point");
  return params;
}

HoopReinforcement::HoopReinforcement(const InputParameters & parameters)
  : DiracKernel(parameters),
    _eps_number(_subproblem
                    .getVariable(_tid,
                                 parameters.get<VariableName>("strain"),
                                 Moose::VarKindType::VAR_ANY,
                                 Moose::VarFieldType::VAR_FIELD_STANDARD)
                    .number()),
    _system(_subproblem.getSystem(getParam<VariableName>("strain"))),
    _fy(getParam<Real>("yield_strength")),
    _E(getParam<Real>("elastic_modulus")),
    _A(getParam<Real>("area")),
    _point_param(getParam<std::vector<Point>>("points"))
{
}

void
HoopReinforcement::addPoints()
{
  for (size_t num_pts = 0; num_pts < _point_param.size(); num_pts++)
    addPoint(_point_param[num_pts]);
}

void
HoopReinforcement::computeResidual()
{
  prepareVectorTag(_assembly, _var.number());

  const std::vector<unsigned int> * multiplicities =
      _drop_duplicate_points ? NULL : &_local_dirac_kernel_info.getPoints()[_current_elem].second;
  unsigned int local_qp = 0;
  Real multiplicity = 1.0;
  Real strain, force;

  for (size_t num_pts = 0; num_pts < _point_param.size(); num_pts++)
  {
    strain = _system.point_value(_eps_number, _point_param[num_pts], false);
    if(strain>0.)
      force = fmin(_E*strain, _fy) * _A;
    else
      force = fmax(_E*strain, _fy) * _A;
    out <<" force " << force << " pt "<< _point_param[num_pts](0) << " " << _point_param[num_pts](1) << " " << _point_param[num_pts](2) << std::endl;

    for (_qp = 0; _qp < _qrule->n_points(); _qp++)
    {
      _current_point = _point_param[num_pts];
      if (isActiveAtPoint(_current_elem, _current_point))
      {
        if (!_drop_duplicate_points)
          multiplicity = (*multiplicities)[local_qp++];
        for (_i = 0; _i < _test.size(); _i++)
          _local_re(_i) += multiplicity * (-_test[_i][_qp] * force);
      }
    }
  }
}


Real
HoopReinforcement::computeQpResidual()
{
  return 0.;
}
