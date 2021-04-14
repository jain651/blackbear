//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "RepeatingAngularTemperatureBC.h"
#include "Function.h"
#include <cmath>
registerMooseObject("BlackBearApp", RepeatingAngularTemperatureBC);

defineLegacyParams(RepeatingAngularTemperatureBC);

InputParameters
RepeatingAngularTemperatureBC::validParams()
{
  InputParameters params = DirichletBCBase::validParams();
  params.addRequiredParam<FunctionName>("T_air", "The forcing function.");
  params.addRequiredParam<Real>("dT_sun_shade",
                             "difference between temperature on concrete surface in sun and shade");
  params.addParam<FunctionName>("scaling_function", 1.0, "The scaling function.");
  params.addRequiredParam<Real>("repetition_period",
                             "period after which boundary condition is repeated");
  params.addClassDescription(
      "Imposes the essential boundary condition $u=g(t,\\vec{x})$, where $g$ "
      "is a (possibly) time and space-dependent MOOSE Function.");
  return params;
}

RepeatingAngularTemperatureBC::RepeatingAngularTemperatureBC(const InputParameters & parameters)
  : DirichletBCBase(parameters),
  _T_air(getFunction("T_air")),
  _dT_sun_shade (getParam<Real>("dT_sun_shade")),
  _scaling_function(getFunction("scaling_function")),
  _repetition_period (getParam<Real>("repetition_period"))
{
}

Real
RepeatingAngularTemperatureBC::computeQpValue()
{
  const Real time_of_the_period = (_t/_repetition_period - (int) (_t/_repetition_period)) * _repetition_period + 1.;
  // return _scaling_function.value(time_of_the_period, *_current_node) * _T_air.value(time_of_the_period, *_current_node);
  Real value =  _scaling_function.value(time_of_the_period, *_current_node) * _T_air.value(time_of_the_period, *_current_node);

  Real angle = 180/3.14;
  // Real angle = atan(_q_point[_qp](0)/_q_point[_qp](1))*180/3.14;
  Real factor;
  if (angle >= 90 && angle <= 270)
    factor = 1/3.;
  else
    factor = 1/6.;

  return value + factor * _dT_sun_shade;
}
