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
  params.addRequiredParam<VariableName>("disp_component", "a component of strain tensor");
  params.addRequiredParam<Real>("yield_strength", "Yield strength of the rebar");
  params.addRequiredParam<Real>("youngs_modulus", "Elastic modulus of the rebar");
  params.addRequiredParam<Real>("area", "Area of the rebar");
  params.addParam<std::vector<Point>>("points", "The x,y,z coordinates of the point");
  return params;
}

HoopReinforcement::HoopReinforcement(const InputParameters & parameters)
  : DiracKernel(parameters),
    _system(_subproblem.getSystem(getParam<VariableName>("disp_component"))),
    _fy(getParam<Real>("yield_strength")),
    _E(getParam<Real>("youngs_modulus")),
    _A(getParam<Real>("area")),
    _point_param(getParam<std::vector<Point>>("points"))
{}

void
HoopReinforcement::addPoints()
{
  for (size_t num_pts = 0; num_pts < _point_param.size(); num_pts++)
    addPoint(_point_param[num_pts]);
}

Real
HoopReinforcement::computeQpResidual()
{
  Real strain = _system.point_value(_var.number(), _current_point, false)/_current_point(0);
  Real force;
  if(strain>0.)
    force = - fmin(_E*strain, _fy) * _A;
  else
    force = - fmax(_E*strain, _fy) * _A;
  // out <<" out force " << force << " pt "<< _current_point(0) << " " << _current_point(1) << " " << _current_point(2) << std::endl;
  return -force;
}

Real
HoopReinforcement::computeQpJacobian()
{
  Real strain = _system.point_value(_var.number(), _current_point, false)/_current_point(0);
  Real dstrain = 1./_current_point(0);
  Real dforce;
  if(strain>0.)
    dforce = - fmin(_E*dstrain, _fy) * _A;
  else
    dforce = - fmax(_E*dstrain, _fy) * _A;

  return -dforce;
}
