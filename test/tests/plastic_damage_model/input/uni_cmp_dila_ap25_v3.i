[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 1
  ny = 1
  nz = 1
  xmin = -0.5
  xmax = 0.5
  ymin = -0.5
  ymax = 0.5
  zmin = -0.5
  zmax = 0.5
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[Kernels]
  [./TensorMechanics]
    displacements = 'disp_x disp_y disp_z'
    save_in = 'resid_x resid_y resid_z'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./resid_z]
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./min_ep]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mid_ep]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./max_ep]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./sigma0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./sigma1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./sigma2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./f0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./D]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./intnl0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./intnl1]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_xy
    index_i = 0
    index_j = 1
  [../]
  [./strain_xz]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_xz
    index_i = 0
    index_j = 2
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_yz]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_yz
    index_i = 1
    index_j = 2
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
  [./f0_auxk]
    type = MaterialStdVectorAux
    property = plastic_yield_function
    index = 0
    variable = f0
  [../]
  [./D_auxk]
    type = MaterialRealAux
    property = Damage_Variable
    variable = D
  [../]
  [./min_ep]
    type = MaterialRealAux
    property = min_ep
    variable = min_ep
  [../]
  [./mid_ep]
    type = MaterialRealAux
    property = mid_ep
    variable = mid_ep
  [../]
  [./max_ep]
    type = MaterialRealAux
    property = max_ep
    variable = max_ep
  [../]
  [./sigma0]
    type = MaterialRealAux
    property = damaged_min_principal_stress
    variable = sigma0
  [../]
  [./sigma1]
    type = MaterialRealAux
    property = damaged_mid_principal_stress
    variable = sigma1
  [../]
  [./sigma2]
    type = MaterialRealAux
    property = damaged_max_principal_stress
    variable = sigma2
  [../]
  [./intnl0_auxk]
    type = MaterialRealAux
    property = damage_parameter_for_tension
    variable = intnl0
  [../]
  [./intnl1_auxk]
    type = MaterialRealAux
    property = damage_parameter_for_compression
    variable = intnl1
  [../]
[]

[Postprocessors]
  # active ='react_x react_y react_z displacement_x'
  [./react_x]
    type = NodalSum
    variable = resid_x
    boundary = 'left'
  [../]
  [./react_y]
    type = NodalSum
    variable = resid_y
    boundary = 'left'
  [../]
  [./react_z]
    type = NodalSum
    variable = resid_z
    boundary = 'left'
  [../]
  [./displacement_x]
    type = AverageNodalVariableValue
    variable = disp_x
    boundary = 'right'
  [../]
  [./s_xx]
    type = PointValue
    point = '0 0 0'
    variable = stress_xx
  [../]
  [./s_xy]
    type = PointValue
    point = '0 0 0'
    variable = stress_xy
  [../]
  [./s_xz]
    type = PointValue
    point = '0 0 0'
    variable = stress_xz
  [../]
  [./s_yy]
    type = PointValue
    point = '0 0 0'
    variable = stress_yy
  [../]
  [./s_yz]
    type = PointValue
    point = '0 0 0'
    variable = stress_yz
  [../]
  [./s_zz]
    type = PointValue
    point = '0 0 0'
    variable = stress_zz
  [../]
  [./e_xx]
    type = PointValue
    point = '0 0 0'
    variable = strain_xx
  [../]
  [./e_xy]
    type = PointValue
    point = '0 0 0'
    variable = strain_xy
  [../]
  [./e_xz]
    type = PointValue
    point = '0 0 0'
    variable = strain_xz
  [../]
  [./e_yy]
    type = PointValue
    point = '0 0 0'
    variable = strain_yy
  [../]
  [./e_yz]
    type = PointValue
    point = '0 0 0'
    variable = strain_yz
  [../]
  [./e_zz]
    type = PointValue
    point = '0 0 0'
    variable = strain_zz
  [../]
  [./max_ep]
    type = PointValue
    point = '0 0 0'
    variable = max_ep
  [../]
  [./mid_ep]
    type = PointValue
    point = '0 0 0'
    variable = mid_ep
  [../]
  [./min_ep]
    type = PointValue
    point = '0 0 0'
    variable = min_ep
  [../]
  [./sigma0]
    type = PointValue
    point = '0 0 0'
    variable = sigma0
  [../]
  [./sigma1]
    type = PointValue
    point = '0 0 0'
    variable = sigma1
  [../]
  [./sigma2]
    type = PointValue
    point = '0 0 0'
    variable = sigma2
  [../]
  [./f0]
    type = PointValue
    point = '0 0 0'
    variable = f0
  [../]
  [./D]
    type = PointValue
    point = '0 0 0'
    variable = D
  [../]
  [./intnl0]
    type = PointValue
    point = '0 0 0'
    variable = intnl0
  [../]
  [./intnl1]
    type = PointValue
    point = '0 0 0'
    variable = intnl1
  [../]
[]

[BCs]
  [./x_r]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'right'
    function = '-2E-5*x*t'
  [../]
  [./x_l]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'left'
    function = '0'
  [../]
  [./y_l]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'bottom'
    function = '0'
  [../]
  [./z_l]
    type = FunctionPresetBC
    variable = disp_z
    boundary = 'back'
    function = '0'
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 3.17E4
    poissons_ratio = 0.18
  [../]
  [./strain]
    type = ComputeIncrementalSmallStrain
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./pdm]
    # type = PlasticDamageStressUpdateOne
    # yield_function_tol = 1.E-5
    # alpha = 0.109   # fb0 = -19.47
    # alpha_p = 0.23
    # s0 = 0.001
    #
    # at = 0.0001 # parameter to adjust yield strength
    # Dt = 0.51 # degradation at half of maximum tensile strength
    # ft = 3.48 # maximum yield strength
    # gt = 4.8E-4
    #
    # ac = 3.77 # parameter to adjust yield strength
    # Dc = 0.40 # degradation at maximum compressive strength
    # fc = 27.6 # maximum compressive strength of concrete
    # gc = 6.889E-2 #
    #
    # tip_smoother = 1.E-6
    # smoothing_tol = 1.E-3

    type = PlasticDamageStressUpdateOne_v3
    factor_relating_biaxial_unixial_cmp_str = 0.109   # fb0 = -20.862
    factor_controlling_dilatancy            = 0.155
    stiff_recovery_factor                   = 0.001

    yield_ten_str                           = 3.48
    ft_ep_slope_factor_at_zero_ep           = 0.88
    damage_half_ten_str                     = 0.51
    frac_energy_ten                         = 4.8E-4

    yield_cmp_str                           = 18.30
    max_cmp_str                             = 27.60
    damage_max_cmp_str                      = 0.40
    frac_energy_cmp                         = 6.889E-2

    yield_function_tol                      = 1.E-5
    tip_smoother                            = 1.E-6
    smoothing_tol                           = 1.E-3
  [../]
  [./stress]
    type = ComputeMultipleInelasticDamageStress
    inelastic_models = pdm
    perform_finite_strain_rotations = false
  [../]
[]

[Executioner]
#   nl_abs_tol=1E-6
#   petsc_options_iname = '-pc_type'
#   petsc_options_value = 'lu'

  end_time = 4000
  dt = 5
  type = Transient
[]

[Outputs]
  file_base = ./test/tests/plastic_damage_model/output/uni_cmp_dila_ap_025_v3
  exodus = true
  [./csv]
    type = CSV
  [../]
[]
