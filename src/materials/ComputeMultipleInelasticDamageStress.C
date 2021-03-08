//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ComputeMultipleInelasticDamageStress.h"

#include "StressUpdateBase.h"

registerMooseObject("BlackBearApp", ComputeMultipleInelasticDamageStress);

template <>
InputParameters
validParams<ComputeMultipleInelasticDamageStress>()
{
  InputParameters params = validParams<ComputeMultipleInelasticStress>();
  return params;
}

ComputeMultipleInelasticDamageStress::ComputeMultipleInelasticDamageStress(const InputParameters & parameters)
  : ComputeMultipleInelasticStress(parameters),
    _D(getMaterialProperty<Real>("Damage_Variable")),
    _D_old(getMaterialPropertyOld<Real>("Damage_Variable")),
    _D_older(getMaterialPropertyOlder<Real>("Damage_Variable"))
{
}

void
ComputeMultipleInelasticDamageStress::computeQpJacobianMult()
{
  ComputeMultipleInelasticStress::computeQpJacobianMult();
  _Jacobian_mult[_qp] = (1.0 - _D_older[_qp]) * _Jacobian_mult[_qp];
  // _Jacobian_mult[_qp] = (1.0 - _D[_qp]) * _Jacobian_mult[_qp];
}

void
ComputeMultipleInelasticDamageStress::updateQpStateSingleModel(
    unsigned model_number,
    RankTwoTensor & elastic_strain_increment,
    RankTwoTensor & combined_inelastic_strain_increment)
{
  ComputeMultipleInelasticStress::updateQpStateSingleModel(model_number,
                                                           elastic_strain_increment,
                                                           combined_inelastic_strain_increment);
  _Jacobian_mult[_qp] = (1.0 - _D_older[_qp]) * _Jacobian_mult[_qp];
  // _Jacobian_mult[_qp] = (1.0 - _D[_qp]) * _Jacobian_mult[_qp];
}

void
ComputeMultipleInelasticDamageStress::computeAdmissibleState(unsigned model_number,
                                                       RankTwoTensor & elastic_strain_increment,
                                                       RankTwoTensor & inelastic_strain_increment,
                                                       RankFourTensor & consistent_tangent_operator)
{
  _models[model_number]->updateState(elastic_strain_increment,
                                     inelastic_strain_increment,
                                     _rotation_increment[_qp],
                                     _stress[_qp],
                                     _stress_old[_qp] / (1.0 - _D_older[_qp]),
                                     // _stress_old[_qp] / (1.0 - _D[_qp]),
                                     _elasticity_tensor[_qp],
                                     _elastic_strain_old[_qp],
                                     _tangent_operator_type == TangentOperatorEnum::nonlinear,
                                     consistent_tangent_operator);
  // _stress[_qp] *= (1.0 - _D[_qp]);
  _stress[_qp] *= (1.0 - _D_older[_qp]);
}
