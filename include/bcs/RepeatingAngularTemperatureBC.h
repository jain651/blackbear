//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "DirichletBCBase.h"

// Forward Declarations
class RepeatingAngularTemperatureBC;
class Function;

template <>
InputParameters validParams<RepeatingAngularTemperatureBC>();

/**
 * Defines a boundary condition that forces the value to be a user specified
 * function at the boundary.
 */
class RepeatingAngularTemperatureBC : public DirichletBCBase
{
public:
  static InputParameters validParams();

  RepeatingAngularTemperatureBC(const InputParameters & parameters);

protected:
  virtual Real computeQpValue() override;

  /// The function being used for evaluation
  const Function & _T_air;
  const Real _dT_sun_shade;
  const Function & _scaling_function;
  const Real _repetition_period;
};
