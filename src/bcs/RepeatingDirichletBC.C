//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "RepeatingDirichletBC.h"
#include "Function.h"
<<<<<<< HEAD
#include <cmath>
=======

>>>>>>> before scaling to 1:1 scale
registerMooseObject("BlackBearApp", RepeatingDirichletBC);

defineLegacyParams(RepeatingDirichletBC);

InputParameters
RepeatingDirichletBC::validParams()
{
  InputParameters params = DirichletBCBase::validParams();
  params.addRequiredParam<FunctionName>("function", "The forcing function.");
  params.addParam<FunctionName>("scaling_function", 1.0, "The scaling function.");
  params.addRequiredParam<Real>("repetition_period",
                             "period after which boundary condition is repeated");
  params.addClassDescription(
      "Imposes the essential boundary condition $u=g(t,\\vec{x})$, where $g$ "
      "is a (possibly) time and space-dependent MOOSE Function.");
  return params;
}

RepeatingDirichletBC::RepeatingDirichletBC(const InputParameters & parameters)
  : DirichletBCBase(parameters),
  _func(getFunction("function")),
  _scaling_function(getFunction("scaling_function")),
  _repetition_period (getParam<Real>("repetition_period"))
{
}

Real
RepeatingDirichletBC::computeQpValue()
{
<<<<<<< HEAD
  const Real time_in_the_period = (_t/_repetition_period - (int) (_t/_repetition_period)) * _repetition_period + 1.;
  return _scaling_function.value(time_in_the_period, *_current_node) * _func.value(time_in_the_period, *_current_node);
=======
  const Real time_of_the_period = (_t/_repetition_period - (int) (_t/_repetition_period)) * _repetition_period + 1.;
  return _scaling_function.value(time_of_the_period, *_current_node) * _func.value(time_of_the_period, *_current_node);
>>>>>>> before scaling to 1:1 scale
}
