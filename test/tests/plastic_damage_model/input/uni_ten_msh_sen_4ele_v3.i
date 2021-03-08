# [MeshGenerators]
[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 4
    ny = 1

    xmin = -25.4
    xmax = 25.4

    ymin = -12.7
    ymax = 12.7
  []
  [./subdomains]
    type = SubdomainBoundingBoxGenerator
    input = gmg
    bottom_left = '12.7 12.7 0'
    top_right = '25.4 -12.7 0'
    block_id = '1'
    location = INSIDE
  []
  [./extra_nodeset1]
    type = ExtraNodesetGenerator
    input = subdomains
    new_boundary = 'bottom_left'
    coord = '-25.4 -12.7'
  []
  [./extra_nodeset2]
    type = ExtraNodesetGenerator
    input = extra_nodeset1
    new_boundary = 'top_left'
    coord = '-25.4 12.7'
  []
[]

# [Mesh]
#   type = MeshGeneratorMesh
# []

[GlobalParams]
  displacements = 'disp_x disp_y'
  volumetric_locking_correction = true
  out_of_plane_strain = strain_zz
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./TensorMechanics]
    use_displaced_mesh = true
    save_in = 'resid_x resid_y'
  [../]

  [./solid_z]
    type = WeakPlaneStress
    variable = strain_zz
    use_displaced_mesh = true
  [../]
[]

#[Modules/TensorMechanics/Master]
#  [./all]
#    add_variables = true
#    incremental = false #true
#    strain = small
#    generate_output = 'stress_xx stress_xy stress_xz stress_yy stress_yz stress_zz
#               strain_xx strain_xy strain_xz strain_yy strain_yz strain_zz
#               max_principal_stress mid_principal_stress min_principal_stress
#               secondinv_stress thirdinv_stress vonmises_stress
#               secondinv_strain thirdinv_strain
#               elastic_strain_xx elastic_strain_xy elastic_strain_xz elastic_strain_yy elastic_strain_yz elastic_strain_zz'
##               plastic_strain_xx plastic_strain_xy plastic_strain_xz plastic_strain_yy plastic_strain_yz plastic_strain_zz'
#    save_in = 'resid_x resid_y'
#    planar_formulation = plane_strain
#  [../]
#[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
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

  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
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
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./material_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./D_auxk]
    type = MaterialRealAux
    property = Damage_Variable
    variable = D
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
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
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
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy
    index_i = 0
    index_j = 1
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = material_strain_zz
    index_i = 2
    index_j = 2
  [../]
[]

[BCs]
  [./left_x]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'left'
    function = '0.'
  [../]
  [./y1]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'bottom_left'
    function = '0.'
  [../]
  [./right_surface]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'right'
    function = '1E-4*t'
  [../]
[]

[Postprocessors]
  [./displacement_x]
    type = AverageNodalVariableValue
    variable = disp_x
    boundary = 'right'
  [../]
  [./react_x]
    type = NodalSum
    variable = resid_x
    boundary = 'left'
  [../]
[]

[Materials]
  [./elasticity_tensor_left]
    type = ComputeIsotropicElasticityTensor
    block = '0'
    youngs_modulus = 3.17E4
    poissons_ratio = 0.18
  [../]
  [./stress_left]
    type = ComputeMultipleInelasticDamageStress
    block = '0'
    inelastic_models = pdm_left
    perform_finite_strain_rotations = false
    tangent_operator = nonlinear
  [../]
  [./strain_left]
    type = ComputePlaneIncrementalStrain
    block = '0'
  [../]
  [./pdm_left]
    type                                    = PlasticDamageStressUpdateOne_v3
    block                                   = '0'
    factor_relating_biaxial_unixial_cmp_str = 0.109   # fb0 = -20.862
    factor_controlling_dilatancy            = 0.23
    stiff_recovery_factor                   = 0.001

    yield_ten_str                           = 3.48
    ft_ep_slope_factor_at_zero_ep           = 0.90
    damage_half_ten_str                     = 0.27
    frac_energy_ten                         = 25E-3 #4.8E-4

    yield_cmp_str                           = 18.30
    max_cmp_str                             = 27.60
    damage_max_cmp_str                      = 0.40
    frac_energy_cmp                         = 6.889E-2

    yield_function_tol                      = 1.E-5
    tip_smoother                            = 1.E-6
    smoothing_tol                           = 1.E-3
  [../]
  [./elasticity_tensor_right]
    type = ComputeIsotropicElasticityTensor
    block = '1'
    youngs_modulus = 3.17E4
    poissons_ratio = 0.18
  [../]
  [./stress_right]
    type = ComputeMultipleInelasticDamageStress
    block = '1'
    inelastic_models = pdm_right
    perform_finite_strain_rotations = false
    tangent_operator = nonlinear
  [../]
  [./strain_right]
    type = ComputePlaneIncrementalStrain
    block = '1'
  [../]
  [./pdm_right]
    type                                    = PlasticDamageStressUpdateOne_v3
    block                                   = '1'
    factor_relating_biaxial_unixial_cmp_str = 0.109   # fb0 = -20.862
    factor_controlling_dilatancy            = 0.23
    stiff_recovery_factor                   = 0.001

    yield_ten_str                           = 3.40
    ft_ep_slope_factor_at_zero_ep           = 0.90
    damage_half_ten_str                     = 0.27
    frac_energy_ten                         = 25E-3 #4.8E-4

    yield_cmp_str                           = 18.30
    max_cmp_str                             = 27.60
    damage_max_cmp_str                      = 0.40
    frac_energy_cmp                         = 6.889E-2

    yield_function_tol                      = 1.E-5
    tip_smoother                            = 1.E-6
    smoothing_tol                           = 1.E-3
  [../]
[]

[Preconditioning]
  active = SMP
  [./SMP]
    type = SMP
    full = true
  [../]
  [./FDP]
    type = FDP
    full = true
  [../]
[]

[Executioner]
  solve_type = 'NEWTON'
  nl_max_its = 100
  nl_abs_tol = 1.E-5
  nl_rel_tol = 1E-3

  line_search = none

  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'

  petsc_options = '-snes_converged_reason'

  type = Transient
  end_time = 200
  dt = 1
[]


[Outputs]
  file_base = ./test/tests/plastic_damage_model/output/uni_ten_msh_sen_4ele_v3
  exodus = true
  [./csv]
    type = CSV
  [../]
[]
