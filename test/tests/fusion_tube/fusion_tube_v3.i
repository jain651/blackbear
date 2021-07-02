[Mesh]
  construct_side_list_from_node_list=true
  file = gold/fusion_tube_v3.e
  block_id = '1 2 3'
  block_name = 'sml_circles big_circles boundary'

  boundary_id = '1 2 4 10 11 12'
  boundary_name = 'all_cir_peri top_circles_peri inner_surface circle1 circle2 circle3'
  patch_update_strategy = iteration
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./temperature]
    order = FIRST
    family = LAGRANGE
    initial_condition = 25.0
    block = 'sml_circles big_circles'
  [../]
[]

[Kernels]
  [./Tdot_sml_circles]
    type     = HeatConductionTimeDerivative
    specific_heat = 1
    variable = temperature
    block = 'sml_circles'
  [../]
  [./heat_conduction_sml_circles]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 1e-5
    block = 'sml_circles'
  [../]
  [./Tdot_big_circles]
    type     = HeatConductionTimeDerivative
    specific_heat = 1
    variable = temperature
    block = 'big_circles'
  [../]
  [./heat_conduction_big_circles]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 1e-4
    block = 'big_circles'
  [../]
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./circles]
    strain = FINITE
    block = 'sml_circles big_circles'
    add_variables = true
    eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./boundary]
    strain = FINITE
    block = 'boundary'
    add_variables = true
    save_in = 'resid_x resid_y'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./thermal_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 'sml_circles big_circles'
  [../]
  [./thermal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 'sml_circles big_circles'
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxKernels]
  [./thermal_strain_xx]
    type = RankTwoAux
    block = 'sml_circles big_circles'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_yy]
    type = RankTwoAux
    block = 'sml_circles big_circles'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
[]

[Functions]
  [T]
    type = PiecewiseLinear
    xy_data = '0 50
               635 635'
  []
[]

[Contact]
  [./circle_w_boundary]
    secondary = 'all_cir_peri'
    primary = 'inner_surface'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
  [./bet_circles1]
    secondary = 'all_cir_peri'
    primary = 'all_cir_peri'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
  [./bet_circles2]
    secondary = 'all_cir_peri'
    primary = 'all_cir_peri'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
  # [./circle_w_boundary]
  #   secondary = 'circle1'
  #   primary = 'inner_surface'
  #   penalty = 1e12
  #   model = glued
  #   formulation = penalty
  # [../]
  # [./bet_circles1]
  #   secondary = 'circle1'
  #   primary = 'circle2'
  #   penalty = 1e12
  #   model = glued
  #   formulation = penalty
  # [../]
  # [./bet_circles2]
  #   secondary = 'circle1'
  #   primary = 'circle3'
  #   penalty = 1e12
  #   model = glued
  #   formulation = penalty
  # [../]
[]

[Dampers]
  [limitx] #nonlinear iteration
    type = MaxIncrement
    max_increment = 1
    variable = disp_x
  []
  [limity]
    type = MaxIncrement
    max_increment = 1
    variable = disp_y
  []
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = 'inner_surface top_circles_peri '
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = 'inner_surface top_circles_peri '
    value    = 0.0
  [../]
  [./temperature]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'all_cir_peri'
    function = T
  [../]
[]

[Materials]
  [thermal_strain_circles]
    type = ComputeThermalExpansionEigenstrain
    block = 'sml_circles big_circles'
    temperature = temperature
    thermal_expansion_coeff = 8.0e-5
    stress_free_temperature = 23.0
    eigenstrain_name = thermal_expansion
  []
  [./elasticity_tensor_all]
    type = ComputeElasticityTensor
    block = 'sml_circles big_circles boundary'
    fill_method = symmetric_isotropic
    C_ijkl = '0 5E9'
  [../]
  [./stress_all]
    type = ComputeFiniteStrainElasticStress
    block = 'sml_circles big_circles boundary'
  [../]
  [./density_sml_circles]
    type = GenericConstantMaterial
    block = 'sml_circles'
    prop_names = 'density'
    prop_values = '100'
  [../]
  [./density_big_circles]
    type = GenericConstantMaterial
    block = 'big_circles'
    prop_names = 'density'
    prop_values = '50'
  [../]
  [./density_boundary]
    type = GenericConstantMaterial
    block = 'boundary'
    prop_names = 'density'
    prop_values = '1000'
  [../]
[]

[Executioner]
  type = Transient
  dt = 10
  automatic_scaling = true
  end_time = 635

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount -ksp_gmres_restart'
  petsc_options_value = 'lu NONZERO   1e-5 50'

  nl_max_its = 50
  l_max_its = 50
  nl_abs_tol = 5e-3
  nl_rel_tol = 1e-5
  line_search = none
  petsc_options = '-snes_converged_reason'
[]

[Outputs]
  perf_graph = true
  [./Exo]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]
