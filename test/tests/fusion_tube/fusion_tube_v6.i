[Mesh]
  file = gold/fusion_tube_v6.e
  block_id = '1 2 3'
  block_name = 'boundary sml_circles big_circles '

  boundary_id = '1 2'
  boundary_name = 'fix_surfaces floating_circles'

  # patch_update_strategy = iteration
  construct_side_list_from_node_list=true
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

[Contact]
  [./circle_w_boundary]
    secondary = 'floating_circles'
    primary = 'fix_surfaces'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
  [./bet_circles]
    penalty = 1e12
    secondary =  '10001  10002  10003  10004  10005  10006  10007  10008  10009  10010  10011  10012  10013  10014  10015  10016  10017  10018  10019'
    primary =  '1001  1002  1003  1004  1005  1006  1007  1008  1009  1010  1011  1012  1013  1014  1015  1016  1017  1018  1019'
    model = glued
    formulation = penalty
  [../]
[]

[ThermalContact]
  [./thermal]
    type = GapHeatTransfer
    variable = temperature
    secondary =  '10001  10002  10003  10004  10005  10006  10007  10008  10009  10010  10011  10012    10014  10015  10016  10017  10018  10019'
    primary =  '1001  1002  1003  1004  1005  1006  1007  1008  1009  1010  1011  1012    1014  1015  1016  1017  1018  1019'
    emissivity_primary = 0
    emissivity_secondary = 0
    gap_conductivity = 1e4
    quadrature = true
  [../]
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
    boundary = 'fix_surfaces'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = 'fix_surfaces'
    value    = 0.0
  [../]
  [./temperature]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'floating_circles'
    function = '(100-2*y)*t'
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
  dt = 0.1
  automatic_scaling = true
  end_time = 50

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount -ksp_gmres_restart'
  petsc_options_value = 'lu NONZERO   1e-5 50'

  nl_max_its = 50
  l_max_its = 30
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
