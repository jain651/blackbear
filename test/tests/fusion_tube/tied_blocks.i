[GlobalParams]
  displacements = 'disp_x disp_y'
  # volumetric_locking_correction = true
[]

[Mesh]
  file = gold/tied_blocks.e
  construct_side_list_from_node_list = true
  patch_update_strategy=iteration
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./concrete1]
    strain = FINITE
    block = '1'
    add_variables = true
    save_in = 'resid_x resid_y'
  [../]
  [./concrete2]
    strain = FINITE
    block = '2'
    add_variables = true
    # eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./rod]
    block = '3'
    truss = true
    area = area
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
[]

[Constraints]
  [./rebar_x1]
    type = EqualValueEmbeddedConstraint
    primary = 2
    secondary = 3
    primary_variable = 'disp_x'
    variable = 'disp_x'
    formulation = penalty
    penalty = 1e12
  [../]
  [./rebar_y1]
    type = EqualValueEmbeddedConstraint
    primary = 2
    secondary = 3
    primary_variable = 'disp_y'
    variable = 'disp_y'
    formulation = penalty
    penalty = 1e12
  [../]
  [./rebar_x2]
    type = EqualValueEmbeddedConstraint
    primary = 1
    secondary = 3
    primary_variable = 'disp_x'
    variable = 'disp_x'
    formulation = penalty
    penalty = 1e12
  [../]
  [./rebar_y2]
    type = EqualValueEmbeddedConstraint
    primary = 1
    secondary = 3
    primary_variable = 'disp_y'
    variable = 'disp_y'
    formulation = penalty
    penalty = 1e12
  [../]
[]

# [Variables]
#   [./T]
#     order = FIRST
#     family = LAGRANGE
#     initial_condition = 5.0
#     block = '2'
#   [../]
#   [./rh]
#     order = FIRST
#     family = LAGRANGE
#     initial_condition = 0.6
#     block = '2'
#   [../]
# []

# [Kernels]
#   [./T_td]
#     type     = ConcreteThermalTimeIntegration
#     variable = T
#     block = '2'
#   [../]
#   [./T_diff]
#     type     = ConcreteThermalConduction
#     variable = T
#     block = '2'
#   [../]
#   [./T_conv]
#     type     = ConcreteThermalConvection
#     variable = T
#     relative_humidity = rh
#     block = '2'
#   [../]
#   [./T_adsorption]
#     type     = ConcreteLatentHeat
#     variable = T
#     H = rh
#     block = '2'
#   [../]
#   [./rh_td]
#     type     = ConcreteMoistureTimeIntegration
#     variable = rh
#     block = '2'
#   [../]
#   [./rh_diff]
#     type     = ConcreteMoistureDiffusion
#     variable = rh
#     temperature = T
#     block = '2'
#   [../]
#   [./heat_dt]
#     type = TimeDerivative
#     variable = T
#     # block = '2'
#     block = '2'
#   [../]
#   [./heat_conduction]
#     type = HeatConduction
#     variable = T
#     diffusion_coefficient = 53.0
#     # block = '2'
#     block = '2'
#   [../]
# []

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  # [./thermal_strain_xx]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '2'
  # [../]
  # [./thermal_strain_yy]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '2'
  # [../]
  # [./thermal_conductivity]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  # [./thermal_capacity]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  # [./moisture_capacity]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  # [./humidity_diffusivity]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  # [./water_content]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  # [./water_hydrated]
  #   order = CONSTANT
  #   family = Monomial
  #   block = '2'
  # [../]
  [./area]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  # [./thermal_strain_xx]
  #   type = RankTwoAux
  #   block = '2'
  #   rank_two_tensor = thermal_expansion
  #   variable = thermal_strain_xx
  #   index_i = 0
  #   index_j = 0
  #   execute_on = 'timestep_end'
  # [../]
  # [./thermal_strain_yy]
  #   type = RankTwoAux
  #   block = '2'
  #   rank_two_tensor = thermal_expansion
  #   variable = thermal_strain_yy
  #   index_i = 1
  #   index_j = 1
  #   execute_on = 'timestep_end'
  # [../]
  # [./k]
  #   type = MaterialRealAux
  #   variable = thermal_conductivity
  #   property = thermal_conductivity
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  # [./capacity]
  #   type = MaterialRealAux
  #   variable = thermal_capacity
  #   property = thermal_capacity
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  # [./rh_capacity]
  #   type = MaterialRealAux
  #   variable = moisture_capacity
  #   property = moisture_capacity
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  # [./rh_duff]
  #   type = MaterialRealAux
  #   variable = humidity_diffusivity
  #   property = humidity_diffusivity
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  # [./wc_duff]
  #   type = MaterialRealAux
  #   variable = water_content
  #   property = moisture_content
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  # [./hydrw_duff]
  #   type = MaterialRealAux
  #   variable = water_hydrated
  #   property = hydrated_water
  #   execute_on = 'timestep_end'
  #   block = '2'
  # [../]
  [./area]
    type = ConstantAux
    block = '3'
    variable = area
    value = 284e-6
    execute_on = 'initial timestep_begin'
  [../]
[]

[Dampers]
  [limitx]
    type = MaxIncrement
    max_increment = 1e-2
    variable = disp_x
  []
  [limity]
    type = MaxIncrement
    max_increment = 1e-2
    variable = disp_y
  []
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = '1'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = '2'
    value    = 0.0
  [../]
  # [./T_air]
  #   type = FunctionDirichletBC
  #   variable = T
  #   boundary = '3'
  #   function = '100'
  # [../]
  # [./rh_air]
  #   type = FunctionDirichletBC
  #   variable = rh
  #   boundary = '3'
  #   function = '0.9'
  # [../]
  [./disp_x]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = '3'
    function = '1e-1*t'
  [../]
[]

[Materials]
  # [./concrete]
  #   type                                 = ConcreteThermalMoisture
  #   block                                = '2'
  #   # setup thermal property models and parameters
  #   # options available: CONSTANT ASCE-1992 KODUR-2004 EUROCODE-2004 KIM-2003
  #   thermal_conductivity_model           = KODUR-2004
  #   thermal_capacity_model               = KODUR-2004
  #   aggregate_type                       = Siliceous # options: Siliceous Carbonate
  #
  #   ref_density_of_concrete              = 2231.0    # in kg/m^3
  #   ref_specific_heat_of_concrete        = 1100.0    # in J/(Kg.0C)
  #   ref_thermal_conductivity_of_concrete = 3         # in W/(m.0C)
  #
  #   # setup moisture capacity and humidity diffusivity models
  #   aggregate_pore_type                  = dense     # options: dense porous
  #   aggregate_mass                       = 1877.0    # mass of aggregate (kg) per m^3 of concrete
  #   cement_type                          = 2         # options: 1 2 3 4
  #   cement_mass                          = 354.0     # mass of cement (kg) per m^3 of concrete
  #   water_to_cement_ratio                = 0.53
  #   concrete_cure_time                   = 14.0      # curing time in (days)
  #
  #   # options available for humidity diffusivity:
  #   moisture_diffusivity_model           = Bazant    # options: Bazant Xi Mensi
  #   D1                                   = 3.0e-8
  #   aggregate_vol_fraction               = 0.7       # used in Xi's moisture diffusivity model
  #
  #   coupled_moisture_diffusivity_factor  = 1.0e-2    # factor for mositure diffusivity due to heat
  #
  #   # coupled nonlinear variables
  #   relative_humidity                    = rh
  #   temperature                          = T
  # [../]
  # [thermal_strain_concrete]
  #   type                                 = ComputeThermalExpansionEigenstrain
  #   block                                = '2'
  #   temperature                          = T
  #   thermal_expansion_coeff              = 8.0e-6
  #   stress_free_temperature              = 23.0
  #   eigenstrain_name                     = thermal_expansion
  # []
  [./elasticity_tensor]
    type = ComputeElasticityTensor
    block = '1 2'
    fill_method = symmetric_isotropic
    C_ijkl = '0 5E9'
  [../]
  [./stress]
    type = ComputeFiniteStrainElasticStress
    block = '1 2'
  [../]
  [truss]
    type = LinearElasticTruss
    block = '3'
    youngs_modulus = 2.14e11
  []
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type       = Transient
  dt = 1
  automatic_scaling = true
  end_time = 1

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  nl_max_its = 20
  l_max_its = 30
  nl_abs_tol = 1e-5
  nl_rel_tol = 1e-5
  line_search = none
  petsc_options = '-snes_converged_reason'
[]

[Outputs]
  perf_graph     = true
  csv = true
  [./Exo]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]
