/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "PlasticDamageStressUpdateOne_v3.h"
#include "libmesh/utility.h"

registerMooseObject("BlackBearApp", PlasticDamageStressUpdateOne_v3);

template <>
InputParameters
validParams<PlasticDamageStressUpdateOne_v3>()
{
  InputParameters params = validParams<MultiParameterPlasticityStressUpdate>();
  params.addParam<Real>("yield_function_tolerance", "If the yield function is less than this amount, the (stress, internal parameters) are deemed admissible.  A std::vector of tolerances must be entered for the multi-surface case");

  params.addRangeCheckedParam<Real>("factor_relating_biaxial_unixial_cmp_str",
                                   0.1,
                                   "factor_relating_biaxial_unixial_cmp_str < 0.5 & factor_relating_biaxial_unixial_cmp_str >= 0",
                                   "Material parameter that relate biaxial and uniaxial compressive  strength, i.e., \alfa = (fb0-fc0)/(2*fb0-fc0)");
  params.addRequiredParam<Real>("factor_controlling_dilatancy",
                                "parameter for the dilation");
  params.addRangeCheckedParam<Real>("stiff_recovery_factor",
                                  0.,
                                  "stiff_recovery_factor <= 1. & stiff_recovery_factor >= 0",
                                  "stiffness recovery parameter");

  params.addRangeCheckedParam<Real>("ft_ep_slope_factor_at_zero_ep",
                                   "ft_ep_slope_factor_at_zero_ep <= 1 & ft_ep_slope_factor_at_zero_ep >= 0",
                                   "slope of ft vs plastic strain curve at zero plastic strain");
  params.addRequiredParam<Real>("damage_half_ten_str",
                               "Fraction of the elastic recovery slope in tension at 0.5*ft0 after yielding");
  params.addRangeCheckedParam<Real>("yield_ten_str",
                                   "yield_ten_str >= 0",
                                   "Tensile yield strength of concrete");
  params.addRangeCheckedParam<Real>("frac_energy_ten",
                                   "frac_energy_ten >= 0",
                                   "Fracture energy of concrete in uniaxial tension");

  params.addRangeCheckedParam<Real>("yield_cmp_str",
                                   "yield_cmp_str >= 0",
                                   "Absolute yield compressice strength");
  params.addRequiredParam<Real>("damage_max_cmp_str",
                               "damage at maximum compressive strength");
  params.addRequiredParam<Real>("max_cmp_str",
                               "Absolute maximum compressive strength");
  params.addRangeCheckedParam<Real>("frac_energy_cmp",
                                   "frac_energy_cmp >= 0",
                                   "Fracture energy of concrete in uniaxial compression");


  params.addRequiredRangeCheckedParam<Real>("tip_smoother",
                                           "tip_smoother>=0",
                                           "Smoothing parameter: the cone vertex at mean = cohesion*cot(friction_angle), will be smoothed by the given amount. Typical value is 0.1*cohesion");
  params.addParam<bool>("perfect_guess",
                       true,
                       "Provide a guess to the Newton-Raphson proceedure "
                       "that is the result from perfect plasticity.  With "
                       "severe hardening/softening this may be "
                       "suboptimal.");
  params.addClassDescription(
     "Plastic damage model for concrete");
  return params;
}

PlasticDamageStressUpdateOne_v3::PlasticDamageStressUpdateOne_v3(const InputParameters & parameters)
  : MultiParameterPlasticityStressUpdate(parameters, 3, 1, 2),
    _f_tol(getParam<Real>("yield_function_tol")),

    _alfa(getParam<Real>("factor_relating_biaxial_unixial_cmp_str")),
    _alfa_p(getParam<Real>("factor_controlling_dilatancy")),
    _s0(getParam<Real>("stiff_recovery_factor")),

    _Chi(getParam<Real>("ft_ep_slope_factor_at_zero_ep")),
    _Dt(getParam<Real>("damage_half_ten_str")),
    _ft(getParam<Real>("yield_ten_str")),
    _FEt(getParam<Real>("frac_energy_ten")),

    _fyc(getParam<Real>("yield_cmp_str")),
    _Dc(getParam<Real>("damage_max_cmp_str")),
    _fc(getParam<Real>("max_cmp_str")),
    _FEc(getParam<Real>("frac_energy_cmp")),

    _at(1.5*std::sqrt(1-_Chi) - 0.5),
    _ac((2.*(_fc/_fyc)-1.+2.*std::sqrt(std::pow((_fc/_fyc),2.)-_fc/_fyc))),

    _zt((1.+_at)/_at),
    _zc((1.+_ac)/_ac),
    _dPhit(_at*(2.+_at)),
    _dPhic(_ac*(2.+_ac)),
    _sqrtPhit_max((1.+_at+sqrt(1.+_at*_at))/2.),
    _sqrtPhic_max((1.+_ac                 )/2.),
    _dt_bt(log(1.-_Dt)/log((1.+_at-sqrt(1.+_at*_at))/(2.*_at))),
    _dc_bc(log(1.-_Dc)/log((1.+_ac                 )/(2.*_ac))),
    _ft0(0.5*_ft/((1.-_Dt)*pow((_zt-_sqrtPhit_max/_at),(1.-_dt_bt))*_sqrtPhit_max)),
    _fc0(_fc/((1.-_Dc)*pow((_zc-_sqrtPhic_max/_ac),(1.-_dc_bc))*_sqrtPhic_max)),
    _small_smoother2(std::pow(getParam<Real>("tip_smoother"), 2)),

    _c(2.2523),
    _eps(1.E-6),
    _nGpt(12),
    _tol(1.E-3),

    _sqrt3(sqrt(3.)),
    _perfect_guess(getParam<bool>("perfect_guess")),
    _eigvecs(RankTwoTensor()),
    _max_principal(declareProperty<Real>("max_principal_stress")),
    _min_principal(declareProperty<Real>("min_principal_stress")),
    _intnl0(declareProperty<Real>("damage_parameter_for_tension")),
    _intnl1(declareProperty<Real>("damage_parameter_for_compression")),
    _ele_len (declareProperty<Real>("element_length")),
    _gt(declareProperty<Real>("fracture energy in tension for the element")),
    _gc(declareProperty<Real>("fracture energy in compression for the element")),
    _tD(declareProperty<Real>("tensile_damage")),
    _cD(declareProperty<Real>("compression_damage")),
    _D(declareProperty<Real>("Damage_Variable")),
    _min_ep(declareProperty<Real>("min_ep")),
    _mid_ep(declareProperty<Real>("mid_ep")),
    _max_ep(declareProperty<Real>("max_ep")),
    _sigma0(declareProperty<Real>("damaged_min_principal_stress")),
    _sigma1(declareProperty<Real>("damaged_mid_principal_stress")),
    _sigma2(declareProperty<Real>("damaged_max_principal_stress"))
{
}

void
PlasticDamageStressUpdateOne_v3::initQpStatefulProperties()
{
  if (_current_elem->n_vertices() < 3)
    _ele_len[_qp] = _current_elem -> length (0,1);
  else if (_current_elem->n_vertices() < 5)
    _ele_len[_qp] = (_current_elem -> length (0,1) +
                     _current_elem -> length (1,2))/2.;
  else
    _ele_len[_qp] = (_current_elem -> length (0,1) +
                     _current_elem -> length (1,2) +
                     _current_elem -> length (0,4))/3.;

  _gt[_qp] = _FEt/_ele_len[_qp];
  _gc[_qp] = _FEc/_ele_len[_qp];

  _min_ep[_qp] = 0.;
  _mid_ep[_qp] = 0.;
  _max_ep[_qp] = 0.;
  _sigma0[_qp] = 0.;
  _sigma1[_qp] = 0.;
  _sigma2[_qp] = 0.;
  _intnl0[_qp] = 0.;
  _intnl1[_qp] = 0.;
  _tD[_qp] = 0.;
  _cD[_qp] = 0.;
  _D[_qp] = 0.;
  MultiParameterPlasticityStressUpdate::initQpStatefulProperties();
}

void
PlasticDamageStressUpdateOne_v3::finalizeReturnProcess(
    const RankTwoTensor & /*rotation_increment*/)
{
  std::vector<Real> eigstrain;
  _plastic_strain[_qp].symmetricEigenvalues(eigstrain);
  _min_ep[_qp] = eigstrain[0];
  _mid_ep[_qp] = eigstrain[1];
  _max_ep[_qp] = eigstrain[2];
}

void
PlasticDamageStressUpdateOne_v3::computeStressParams(const RankTwoTensor & stress,
                                         std::vector<Real> & stress_params) const
{
  stress.symmetricEigenvalues(stress_params);
}

std::vector<RankTwoTensor>
PlasticDamageStressUpdateOne_v3::dstress_param_dstress(const RankTwoTensor & stress) const
{
  std::vector<Real> sp;
  std::vector<RankTwoTensor> dsp;
  stress.dsymmetricEigenvalues(sp, dsp);
  return dsp;
}

std::vector<RankFourTensor>
PlasticDamageStressUpdateOne_v3::d2stress_param_dstress(const RankTwoTensor & stress) const
{
  std::vector<RankFourTensor> d2;
  stress.d2symmetricEigenvalues(d2);
  return d2;
}

void
PlasticDamageStressUpdateOne_v3::setEffectiveElasticity(const RankFourTensor & Eijkl)
{
  // Eijkl is required to be isotropic, so we can use the
  // frame where stress is diagonal
  for (unsigned a = 0; a < _num_sp; ++a)
    for (unsigned b = 0; b < _num_sp; ++b)
      _Eij[a][b] = Eijkl(a, a, b, b);
  _En = _Eij[2][2];
  const Real denom = _Eij[0][0] * (_Eij[0][0] + _Eij[0][1]) - 2 * Utility::pow<2>(_Eij[0][1]);
  for (unsigned a = 0; a < _num_sp; ++a)
  {
    _Cij[a][a] = (_Eij[0][0] + _Eij[0][1]) / denom;
    for (unsigned b = 0; b < a; ++b)
      _Cij[a][b] = _Cij[b][a] = -_Eij[0][1] / denom;
  }
}

void
PlasticDamageStressUpdateOne_v3::preReturnMapV(const std::vector<Real> & /*trial_stress_params*/,
                                   const RankTwoTensor & stress_trial,
                                   const std::vector<Real> & /*intnl_old*/,
                                   const std::vector<Real> & /*yf*/,
                                   const RankFourTensor & /*Eijkl*/)
{
  std::vector<Real> eigvals;
  stress_trial.symmetricEigenvaluesEigenvectors(eigvals, _eigvecs);
}

void
PlasticDamageStressUpdateOne_v3::setStressAfterReturnV(const RankTwoTensor & /*stress_trial*/,
                                           const std::vector<Real> & stress_params,
                                           Real /*gaE*/,
                                           const std::vector<Real> & intnl,
                                           const yieldAndFlow & /*smoothed_q*/,
                                           const RankFourTensor & /*Eijkl*/,
                                           RankTwoTensor & stress) const
{
  // form the diagonal stress
  stress = RankTwoTensor(stress_params[0], stress_params[1], stress_params[2], 0.0, 0.0, 0.0);
  // rotate to the original frame
  stress = _eigvecs * stress * (_eigvecs.transpose());
//   _dir[_qp] = _eigvecs;
  Real D = damageVar(stress_params, intnl);
  _sigma0[_qp] = (1.-D)*stress_params[0];
  _sigma1[_qp] = (1.-D)*stress_params[1];
  _sigma2[_qp] = (1.-D)*stress_params[2];
  _intnl0[_qp] = intnl[0];
  _intnl1[_qp] = intnl[1];
  _D[_qp] = D;
}

void
PlasticDamageStressUpdateOne_v3::yieldFunctionValuesV(const std::vector<Real> & stress_params,
                                          const std::vector<Real> & intnl,
                                          std::vector<Real> & yf) const
{
  Real I1 = stress_params[0] + stress_params[1] + stress_params[2];
  Real J2 = (pow(stress_params[0]-stress_params[1],2.) +
             pow(stress_params[1]-stress_params[2],2.) +
             pow(stress_params[2]-stress_params[0],2.))/6.+_small_smoother2;
  Real sqrtJ2 = sqrt(J2);
  yf[0] = 1./(1.-_alfa)*(_alfa*I1 + _sqrt3*sqrtJ2 +
                          beta(intnl)*(stress_params[2]<0.?0.:stress_params[2])) - fc(intnl);
}

void
PlasticDamageStressUpdateOne_v3::computeAllQV(const std::vector<Real> & stress_params,
                                  const std::vector<Real> & intnl,
                                  std::vector<yieldAndFlow> & all_q) const
{
  Real I1 = stress_params[0] + stress_params[1] + stress_params[2];
  Real J2 = (pow(stress_params[0]-stress_params[1],2.) +
             pow(stress_params[1]-stress_params[2],2.) +
             pow(stress_params[2]-stress_params[0],2.))/6.+_small_smoother2;
  Real sqrtJ2 = sqrt(J2);
  std::vector<Real> DevSt(3); // vector of principal deviatoric stress
  for (unsigned i = 0; i < 3; ++i)
    DevSt[i] = stress_params[i]-I1/3.;

//   yieldFunctionValuesV(stress_params, intnl, all_q[0].f);
  all_q[0].f = 1./(1.-_alfa)*(_alfa*I1 + _sqrt3*sqrtJ2 +
                               beta(intnl)*(stress_params[2]<0.?0.:stress_params[2])) - fc(intnl);

  for (unsigned i = 0; i < _num_sp; ++i)
    all_q[0].df[i] = 1./(1.-_alfa)*(_alfa + _sqrt3*DevSt[i]/(2.*sqrtJ2) + beta(intnl)*(stress_params[2]<0.?0.:(i==2)));
  all_q[0].df_di[0] = 1./(1.-_alfa)*(dbeta0(intnl)*(stress_params[2]<0.?0.:stress_params[2]));
  all_q[0].df_di[1] = 1./(1.-_alfa)*(dbeta1(intnl)*(stress_params[2]<0.?0.:stress_params[2])) - dfc(intnl);

  flowPotential(stress_params, intnl, all_q[0].dg);
  dflowPotential_dstress(stress_params, intnl, all_q[0].d2g);
  dflowPotential_dintnl(stress_params, intnl, all_q[0].d2g_di);
}

void
PlasticDamageStressUpdateOne_v3::flowPotential(const std::vector<Real> & stress_params,
                                         const std::vector<Real> & intnl,
                                         std::vector<Real> & r) const
{
  Real J2 = (pow(stress_params[0]-stress_params[1],2.) +
             pow(stress_params[1]-stress_params[2],2.) +
             pow(stress_params[2]-stress_params[0],2.))/6.+_small_smoother2;
  Real invsqrt2J2 = 1./sqrt(2.*J2);
  std::vector<Real> DevSt(3);
  DevSt[0] = (2.*stress_params[0]-stress_params[1]-stress_params[2])/3.; // dJ2/dsig0
  DevSt[1] = (2.*stress_params[1]-stress_params[2]-stress_params[0])/3.; // dJ2/dsig1
  DevSt[2] = (2.*stress_params[2]-stress_params[0]-stress_params[1])/3.; // dJ2/dsig2

  Real D = damageVar(stress_params, intnl);

  for (unsigned int i = 0; i < _num_sp; ++i)
    r[i] = (_alfa_p + (J2<_f_tol ? 0. : DevSt[i]*invsqrt2J2))*pow((1.-D),1);
}

void
PlasticDamageStressUpdateOne_v3::dflowPotential_dstress(const std::vector<Real> & stress_params,
                                                  const std::vector<Real> & intnl,
                                                  std::vector< std::vector<Real> > & dr_dstress) const
{
  Real J2 = (pow(stress_params[0]-stress_params[1],2.) +
             pow(stress_params[1]-stress_params[2],2.) +
             pow(stress_params[2]-stress_params[0],2.))/6.+_small_smoother2;
  Real invsqrt2J2 = 1./sqrt(2.*J2);
  std::vector<Real> DevSt(3);
  DevSt[0] = (2.*stress_params[0]-stress_params[1]-stress_params[2])/3.; // dJ2/dsig0
  DevSt[1] = (2.*stress_params[1]-stress_params[2]-stress_params[0])/3.; // dJ2/dsig1
  DevSt[2] = (2.*stress_params[2]-stress_params[0]-stress_params[1])/3.; // dJ2/dsig2

  Real D = damageVar(stress_params, intnl);

  for (unsigned i = 0; i < _num_sp; ++i)
    for (unsigned j = 0; j < (i+1); ++j)
    {
      if (i!=j)
      {
         dr_dstress[i][j] = J2<_f_tol ? 0. : invsqrt2J2*(-1./3.-DevSt[i]*DevSt[j]/(2.*J2))*pow((1.-D),2);
        dr_dstress[j][i] = dr_dstress[i][j];
      }
      else
        dr_dstress[i][i] = J2<_f_tol ? 0. : invsqrt2J2*(2./3.-DevSt[i]*DevSt[j]/(2.*J2))*pow((1.-D),2);
    }
}

void
PlasticDamageStressUpdateOne_v3::dflowPotential_dintnl(const std::vector<Real> & /* stress_params */,
                                                 const std::vector<Real> & /* intnl */,
                                                 std::vector<std::vector<Real> > & dr_dintnl) const
{
  for (unsigned i = 0; i < _num_sp; ++i)
    for (unsigned j = 0; j < _num_intnl; ++j)
      dr_dintnl[i][j] = 0.;
}

void
PlasticDamageStressUpdateOne_v3::hardPotential(const std::vector<Real> & stress_params,
                                         const std::vector<Real> & intnl,
                                         std::vector<Real> & h) const
{
  Real wf;
  weighfac(stress_params, wf);
  std::vector<Real> r(3);
  flowPotential(stress_params, intnl, r);
  h[0] = wf*ft(intnl)/_gt[_qp]*r[2];
  h[1] = -(1.-wf)*fc(intnl)/_gc[_qp]*r[0];
}

void
PlasticDamageStressUpdateOne_v3::dhardPotential_dstress(const std::vector<Real> & stress_params,
                                                  const std::vector<Real> & intnl,
                                                  std::vector<std::vector<Real> > & dh_dsig) const
{
  Real wf;
  std::vector<Real> dwf(3);
  dweighfac(stress_params, wf, dwf);

  std::vector<Real> r(3);
  flowPotential(stress_params, intnl, r);
  std::vector<std::vector<Real> > dr_dsig(3, std::vector<Real>(3));
  dflowPotential_dstress(stress_params, intnl, dr_dsig);

  for (unsigned i = 0; i < _num_sp; ++i)
  {
    dh_dsig[0][i] = (wf*dr_dsig[2][i]     + dwf[i]*r[2])*ft(intnl)/_gt[_qp];
    dh_dsig[1][i] = -((1.-wf)*dr_dsig[0][i] - dwf[i]*r[0])*fc(intnl)/_gc[_qp];
  }
}

void
PlasticDamageStressUpdateOne_v3::dhardPotential_dintnl(const std::vector<Real> & stress_params,
                                                 const std::vector<Real> & intnl,
                                                 std::vector<std::vector<Real> > & dh_dintnl) const
{
  Real wf;
  weighfac(stress_params, wf);
  std::vector<Real> r(3);
  flowPotential(stress_params, intnl, r);

  dh_dintnl[0][0] = wf*dft(intnl)/_gt[_qp]*r[2];
  dh_dintnl[0][1] = 0.;
  dh_dintnl[1][0] = 0.;
  dh_dintnl[1][1] = -(1-wf)*dfc(intnl)/_gc[_qp]*r[0];
}

void
PlasticDamageStressUpdateOne_v3::initialiseVarsV(const std::vector<Real> & trial_stress_params,
                                     const std::vector<Real> & intnl_old,
                                     std::vector<Real> & stress_params,
                                     Real & /* gaE */,
                                     std::vector<Real> & intnl) const
{
  setIntnlValuesV(trial_stress_params, stress_params, intnl_old, intnl);
}

void
PlasticDamageStressUpdateOne_v3::setIntnlValuesV(const std::vector<Real> & trial_stress_params,
                                     const std::vector<Real> & current_stress_params,
                                     const std::vector<Real> & intnl_old,
                                     std::vector<Real> & intnl) const
{
  Real I1_trial = trial_stress_params[0] + trial_stress_params[1] + trial_stress_params[2];
  Real J2_trial = (pow(trial_stress_params[0]-trial_stress_params[1],2.) +
                   pow(trial_stress_params[1]-trial_stress_params[2],2.) +
                   pow(trial_stress_params[2]-trial_stress_params[0],2.))/6.+_small_smoother2;
  Real invsqrt2J2_trial = 1./sqrt(2.*J2_trial);
  Real G = 0.5*(_Eij[0][0]-_Eij[0][1]); // Lame's mu
  Real K = _Eij[0][1]+2.*G/3.; // Bulk modulus
  Real C1= (2.*G*invsqrt2J2_trial);
  Real C2 = -(I1_trial/3.*G*invsqrt2J2_trial - 3.*K*_alfa_p);
  Real C3 = 3.*K*_alfa_p;

  RankTwoTensor dsig = RankTwoTensor(trial_stress_params[0]-current_stress_params[0],
                                     trial_stress_params[1]-current_stress_params[1],
                                     trial_stress_params[2]-current_stress_params[2],0.,0.,0.);
  RankTwoTensor fac = J2_trial< _f_tol ?
                      C3*RankTwoTensor(1.,1.,1.,0.,0.,0.) :
                      RankTwoTensor(C1*trial_stress_params[0]-C2,
                                    C1*trial_stress_params[1]-C2,
                                    C1*trial_stress_params[2]-C2,0.,0.,0.);

  Real lam = dsig.L2norm() / fac.L2norm();
  std::vector<Real> h(2);
  hardPotential(current_stress_params, intnl_old, h);

  intnl[0] = intnl_old[0] + lam*h[0];
  intnl[1] = intnl_old[1] + lam*h[1];
}

void
PlasticDamageStressUpdateOne_v3::setIntnlDerivativesV(const std::vector<Real> & trial_stress_params,
                                          const std::vector<Real> & current_stress_params,
                                          const std::vector<Real> & intnl,
                                          std::vector<std::vector<Real>> & dintnl) const
{
  Real I1_trial = trial_stress_params[0] + trial_stress_params[1] + trial_stress_params[2];
  Real J2_trial = (pow(trial_stress_params[0]-trial_stress_params[1],2.) +
                   pow(trial_stress_params[1]-trial_stress_params[2],2.) +
                   pow(trial_stress_params[2]-trial_stress_params[0],2.))/6.;
  Real invsqrt2J2_trial = 1./sqrt(2.*J2_trial);
  Real G = 0.5*(_Eij[0][0]-_Eij[0][1]); // Lame's mu
  Real K = _Eij[0][1]+2.*G/3.; // Bulk modulus
  Real C1= (2.*G*invsqrt2J2_trial);
  Real C2 = -(I1_trial/3.*G*invsqrt2J2_trial - 3.*K*_alfa_p);
  Real C3 = 3.*K*_alfa_p;

  RankTwoTensor dsig = RankTwoTensor(trial_stress_params[0]-current_stress_params[0],
                                     trial_stress_params[1]-current_stress_params[1],
                                     trial_stress_params[2]-current_stress_params[2],0.,0.,0.);
  RankTwoTensor fac = J2_trial< _f_tol ?
                      C3*RankTwoTensor(1.,1.,1.,0.,0.,0.) :
                      RankTwoTensor(C1*trial_stress_params[0]-C2,
                                    C1*trial_stress_params[1]-C2,
                                    C1*trial_stress_params[2]-C2,0.,0.,0.);

  Real lam = dsig.L2norm() / fac.L2norm();

	std::vector<Real> dlam_dsig(3);
  for (unsigned i = 0; i < _num_sp; ++i)
    dlam_dsig[i] = dsig.L2norm() == 0.? 0. :
                   -(trial_stress_params[i]-current_stress_params[i])/(dsig.L2norm() * fac.L2norm());

  std::vector<Real> h(2);
  hardPotential(current_stress_params, intnl, h);
  std::vector<std::vector<Real> > dh_dsig(2, std::vector<Real>(3));
  dhardPotential_dstress(current_stress_params, intnl, dh_dsig);
  std::vector<std::vector<Real> > dh_dintnl(2, std::vector<Real>(2));
  dhardPotential_dintnl(current_stress_params, intnl, dh_dintnl);

  for (unsigned i = 0; i < _num_intnl; ++i)
    for (unsigned j = 0; j < _num_sp; ++j)
      dintnl[i][j] = dlam_dsig[j]*h[i] + lam*dh_dsig[i][j];
}

Real
PlasticDamageStressUpdateOne_v3::ft(const std::vector<Real> & intnl) const
{
  Real sqrtPhi_t = sqrt(1.+_at*(2.+_at)*intnl[0]);
  if (_zt > sqrtPhi_t/_at)
    return _ft0 * pow(_zt-sqrtPhi_t/_at,(1.-_dt_bt))*sqrtPhi_t;
  else
    return _ft0 * 1.E-6;
}

Real
PlasticDamageStressUpdateOne_v3::dft(const std::vector<Real> & intnl) const
{
  Real sqrtPhi_t = sqrt(1.+_at*(2.+_at)*intnl[0]);
  if (_zt > sqrtPhi_t/_at)
    return _ft0*_dPhit/(2*sqrtPhi_t)*pow(_zt-sqrtPhi_t/_at,-_dt_bt)*(_zt-(2.-_dt_bt)*sqrtPhi_t/_at);
  else
    return 0.;

}

Real
PlasticDamageStressUpdateOne_v3::fc(const std::vector<Real> & intnl) const
{
  Real sqrtPhi_c;
  if(intnl[1]<1.0)
    sqrtPhi_c = sqrt(1.+_ac*(2.+_ac)*intnl[1]);
  else
    sqrtPhi_c = sqrt(1.+_ac*(2.+_ac)*0.99);
  return _fc0*pow((_zc-sqrtPhi_c/_ac),(1.-_dc_bc))*sqrtPhi_c;
}

Real
PlasticDamageStressUpdateOne_v3::dfc(const std::vector<Real> & intnl) const
{
  if(intnl[1]<1.0)
  {
    Real sqrtPhi_c = sqrt(1.+_ac*(2.+_ac)*intnl[1]);
    return _fc0*_dPhic/(2.*sqrtPhi_c)*pow(_zc-sqrtPhi_c/_ac,-_dc_bc)*(_zc-(2.-_dc_bc)*sqrtPhi_c/_ac);
  }
  else
    return 0.;
}

Real
PlasticDamageStressUpdateOne_v3::beta(const std::vector<Real> & intnl) const
{
   return (1.-_alfa)*fc(intnl)/ft(intnl) - (1.+_alfa);
}

Real
PlasticDamageStressUpdateOne_v3::dbeta0(const std::vector<Real> & intnl) const
{
   return -(1.-_alfa)*fc(intnl)*dft(intnl)/pow(ft(intnl),2.);
}

Real
PlasticDamageStressUpdateOne_v3::dbeta1(const std::vector<Real> & intnl) const
{
   return dfc(intnl)/ft(intnl)*(1.-_alfa);
}

void
PlasticDamageStressUpdateOne_v3::weighfac(const std::vector<Real> & stress_params, Real & wf) const
{
  Real Dr = 0.;
  Real Nr = 0.;
  for (unsigned i = 0; i < _num_sp; ++i)
  {
    if (stress_params[i]>0.)
    {
      Nr += stress_params[i];
      Dr += stress_params[i];
    }
    else
      Dr += -stress_params[i];
  }
  wf = Nr/Dr;
}

void
PlasticDamageStressUpdateOne_v3::dweighfac(const std::vector<Real> & stress_params, Real & wf, std::vector<Real> & dwf) const
{
  std::vector<Real> dNr(3, 0.), dDr(3, 0.);
  Real Dr = 0.;
  Real Nr = 0.;
  for (unsigned i = 0; i < _num_sp; ++i)
  {
    if (stress_params[i]>0.)
    {
      Nr += stress_params[i];
      dNr[i] = 1.;
      Dr += stress_params[i];
      dDr[i] = 1.;
    }
    else
    {
      Dr += -stress_params[i];
      dDr[i] = -1.;
    }
  }
  wf = Nr/Dr;

  for (unsigned i = 0; i < _num_sp; ++i)
    dwf[i] = (dNr[i]-wf*dDr[i])/Dr;
}

Real
PlasticDamageStressUpdateOne_v3::damageVar(const std::vector<Real> &stress_params, const std::vector<Real> & intnl) const
{
  Real sqrtPhi_t = sqrt(1.+_at*(2.+_at)*intnl[0]);
  if (_zt > sqrtPhi_t/_at)
    _tD[_qp] = 1. - pow(_zt-sqrtPhi_t/_at,_dt_bt);
  else
    _tD[_qp] = 1. - 1.E-6;

  Real wf;
  weighfac(stress_params,wf);
  Real s = _s0 + (1.-_s0)*wf;

  Real sqrtPhi_c;
  if(intnl[1]<1.0)
    sqrtPhi_c = sqrt(1.+_ac*(2.+_ac)*intnl[1]);
  else
    sqrtPhi_c = sqrt(1.+_ac*(2.+_ac)*0.99);

  _cD[_qp] = 1. - pow((_zc-sqrtPhi_c/_ac),_dc_bc);
  return 1. - (1.-s*_tD[_qp])*(1.-_cD[_qp]);
}

void
PlasticDamageStressUpdateOne_v3::consistentTangentOperatorV(const RankTwoTensor & /* stress_trial */,
                                                const std::vector<Real> & /* trial_stress_params */,
                                                const RankTwoTensor & /*stress*/,
                                                const std::vector<Real> & /* stress_params */,
                                                Real /*gaE*/,
                                                const yieldAndFlow & /*smoothed_q*/,
                                                const RankFourTensor & elasticity_tensor,
                                                bool /* compute_full_tangent_operator */,
                                                const std::vector<std::vector<Real>> & /* dvar_dtrial */,
                                                RankFourTensor & cto)
{
  cto = elasticity_tensor;
	return;
}
