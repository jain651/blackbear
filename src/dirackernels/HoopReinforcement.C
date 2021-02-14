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
  params.addRequiredParam<std::vector<Real>>("point", "The x,y,z coordinates of the point");
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
    _point_param(getParam<std::vector<Real>>("point"))
{
  _p(0) = _point_param[0];

  if (_point_param.size() > 1)
  {
    _p(1) = _point_param[1];

    if (_point_param.size() > 2)
      _p(2) = _point_param[2];
  }
}

void
HoopReinforcement::addPoints()
{
  addPoint(_p);
}

Real
HoopReinforcement::computeQpResidual()
{
  Real strain = _system.point_value(_eps_number, _point_param[0], false);
  Real force;
  if(strain>0.)
    force = fmin(_E*strain, _fy) * _A;
  else
    force = fmax(_E*strain, _fy) * _A;

  //  This is negative because it's a forcing function that has been brought over to the left side

  return -_test[_i][_qp] * force;
}
