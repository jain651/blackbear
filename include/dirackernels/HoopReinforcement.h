//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

// Moose Includes
#include "DiracKernel.h"

// Forward Declarations
class HoopReinforcement;

template <>
InputParameters validParams<HoopReinforcement>();

/**
 * TOOD
 */
class HoopReinforcement : public DiracKernel
{
public:
  static InputParameters validParams();

  HoopReinforcement(const InputParameters & parameters);

  virtual void addPoints() override;

protected:
  virtual Real computeQpResidual() override;
<<<<<<< HEAD
  virtual Real computeQpJacobian() override;

  /// A reference to the system containing the variable
  const System & _system;

  const Real & _fy;
  const Real & _E;
  const Real & _A;
  std::vector<Point> _point_param;
=======

  const Real & _eps;
  const Real & _fy;
  const Real & _E;
  const Real & _A;
  std::vector<Real> _point_param;
  Point _p;
>>>>>>> in process of scaling to 1:1 scale
};
