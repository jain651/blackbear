//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef COMPUTEMULTIPLEINELASTICDAMAGESTRESS_H
#define COMPUTEMULTIPLEINELASTICDAMAGESTRESS_H

#include "ComputeMultipleInelasticStress.h"

class ComputeMultipleInelasticDamageStress;

template <>
InputParameters validParams<ComputeMultipleInelasticDamageStress>();

/**
 * ComputeMultipleInelasticDamageStress is a specialized version of
 * ComputeMultipleInelasticStress for use only with the
 * PlasticDamageStressUpdate model.
 */

class ComputeMultipleInelasticDamageStress : public ComputeMultipleInelasticStress
{
public:
  ComputeMultipleInelasticDamageStress(const InputParameters & parameters);

protected:
  /// damage parameter for PlasticDamageStressUpdate model
  const MaterialProperty<Real> & _D;
  const MaterialProperty<Real> & _D_old;
  const MaterialProperty<Real> & _D_older;

  virtual void computeQpJacobianMult() override;

  virtual void computeAdmissibleState(unsigned model_number,
                                      RankTwoTensor & elastic_strain_increment,
                                      RankTwoTensor & inelastic_strain_increment,
                                      RankFourTensor & consistent_tangent_operator) override;

  virtual void updateQpStateSingleModel(unsigned model_number,
                                        RankTwoTensor & elastic_strain_increment,
                                        RankTwoTensor & combined_inelastic_strain_increment) override;
};

#endif // ComputeMultipleInelasticDamageStress_H
