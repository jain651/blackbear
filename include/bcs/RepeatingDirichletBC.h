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
class RepeatingDirichletBC;
class Function;

template <>
InputParameters validParams<RepeatingDirichletBC>();

/**
 * Defines a boundary condition that forces the value to be a user specified
 * function at the boundary.
 */
class RepeatingDirichletBC : public DirichletBCBase
{
public:
  static InputParameters validParams();

  RepeatingDirichletBC(const InputParameters & parameters);

protected:
  virtual Real computeQpValue() override;

  /// The function being used for evaluation
  const Function & _func;
  const Function & _scaling_function;
  const Real _repetition_period;
};
