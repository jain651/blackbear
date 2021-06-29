[Mesh]
  construct_side_list_from_node_list=true
  file = gold/fusion_tube_v1.e
  block_id = '1 2 3'
  block_name = 'sml_circles big_circles boundary'

  boundary_id = '1 2 4 10 11 12'
  boundary_name = 'cir_peri top_circles inner_surface circle1 circle2 circle3'
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  # [./rot_z]
  #   order = FIRST
  #   family = LAGRANGE
  # [../]
  [./temperature]
    order = FIRST
    family = LAGRANGE
    initial_condition = 25.0
    block = 'sml_circles big_circles'
  [../]
[]

[Kernels]
  [./T_td]
    type     = ConcreteThermalTimeIntegration
    variable = temperature
    block = 'sml_circles big_circles'
  [../]
  [./T_diff]
    type     = ConcreteThermalConduction
    variable = temperature
    block = 'sml_circles big_circles'
  [../]
  [./heat_dt]
    type = TimeDerivative
    variable = temperature
    block = 'sml_circles big_circles'
  [../]
  [./heat_conduction1]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 10.0
    block = 'sml_circles'
  [../]
  [./heat_conduction2]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 100.0
    block = 'big_circles'
  [../]
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./concrete]
    strain = FINITE
    block = 'sml_circles big_circles'
    add_variables = true
    eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./concrete3]
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
  [./rh]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.6
    block = 'sml_circles big_circles'
  [../]
  [./axial_stress]
    order = CONSTANT
    family = MONOMIAL
    block = 'boundary'
  [../]
  [./e_over_l]
    order = CONSTANT
    family = MONOMIAL
    block = 'boundary'
  [../]
  [./react_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./react_y]
    order = FIRST
    family = LAGRANGE
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
  [./thermal_conductivity]
    order = CONSTANT
    family = Monomial
    block = 'sml_circles big_circles'
  [../]
  [./thermal_capacity]
    order = CONSTANT
    family = Monomial
    block = 'sml_circles big_circles'
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./accel_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_vel_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./rot_accel_z]
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
  [./k]
    type = MaterialRealAux
    variable = thermal_conductivity
    property = thermal_conductivity
    execute_on = 'timestep_end'
    block = 'sml_circles big_circles'
  [../]
  [./capacity]
    type = MaterialRealAux
    variable = thermal_capacity
    property = thermal_capacity
    execute_on = 'timestep_end'
    block = 'sml_circles big_circles'
  [../]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = timestep_end
  [../]
  # [./rot_accel_z]
  #   type = NewmarkAccelAux
  #   variable = rot_accel_z
  #   displacement = rot_z
  #   velocity = rot_vel_z
  #   beta = 0.25
  #   execute_on = timestep_end
  # [../]
  # [./rot_vel_z]
  #   type = NewmarkVelAux
  #   variable = rot_vel_z
  #   acceleration = rot_accel_z
  #   gamma = 0.5
  #   execute_on = timestep_end
  # [../]
[]

[NodalKernels]
  [./x_inertial]
    type = NodalTranslationalInertia
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    boundary = 'cir_peri'
    beta = 0.25
    gamma = 0.5
    mass = 0.01899772
    eta = 0.1
  [../]
  [./y_inertial]
    type = NodalTranslationalInertia
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    boundary = 'cir_peri'
    beta = 0.25
    gamma = 0.5
    mass = 0.01899772
    eta = 0.1
  [../]
  # [./rot_z_inertial]
  #   type = NodalRotationalInertia
  #   variable = rot_z
  #   rotations = 'rot_z'
  #   rotational_velocities = 'rot_vel_z'
  #   rotational_accelerations= 'rot_accel_z'
  #   boundary = 'cir_peri'
  #   beta = 0.25
  #   gamma = 0.5
  #   Ixx = 2e-1
  #   Iyy = 1e-1
  #   Izz = 1e-1
  #   eta = 0.1
  #   component = 2
  # [../]
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
    primary = 'cir_peri'
    secondary = 'inner_surface'
    penalty = 1e6
    model = glued
    formulation = kinematic
  [../]
  [./bet_circles1]
    primary = 'circle1'
    secondary = 'circle2'
    penalty = 1e6
    model = glued
    formulation = kinematic
  [../]
  [./bet_circles2]
    primary = 'circle1'
    secondary = 'circle3'
    penalty = 1e6
    model = glued
    formulation = kinematic
  [../]
  [./bet_circles3]
    primary = 'circle2'
    secondary = 'circle3'
    penalty = 1e6
    model = glued
    formulation = kinematic
  [../]
[]

[Dampers]
  [./contact_slip]
    type = ContactSlipDamper
    primary = '1'
    secondary = '4'
  [../]
  [./contact_slip1]
    type = ContactSlipDamper
    primary = '10'
    secondary = '11'
  [../]
  [./contact_slip2]
    type = ContactSlipDamper
    primary = '10'
    secondary = '12'
  [../]
  [./contact_slip3]
    type = ContactSlipDamper
    primary = '11'
    secondary = '12'
  [../]
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = 'inner_surface top_circles'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = 'inner_surface top_circles'
    value    = 0.0
  [../]
  [./temperature]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'cir_peri'
    function = T
  [../]
[]

[Materials]
  [./concrete]
    type                                 = ConcreteThermalMoisture
    block                                = 'sml_circles big_circles'
    # setup thermal property models and parameters
    # options available: CONSTANT ASCE-1992 KODUR-2004 EUROCODE-2004 KIM-2003
    thermal_conductivity_model           = KODUR-2004
    thermal_capacity_model               = KODUR-2004
    aggregate_type                       = Siliceous # options: Siliceous Carbonate

    ref_density_of_concrete              = 2231.0    # in kg/m^3
    ref_specific_heat_of_concrete        = 1100.0    # in J/(Kg.0C)
    ref_thermal_conductivity_of_concrete = 3         # in W/(m.0C)

    # setup moisture capacity and humidity diffusivity models
    aggregate_pore_type                  = dense     # options: dense porous
    aggregate_mass                       = 1877.0    # mass of aggregate (kg) per m^3 of concrete
    cement_type                          = 2         # options: 1 2 3 4
    cement_mass                          = 354.0     # mass of cement (kg) per m^3 of concrete
    water_to_cement_ratio                = 0.53
    concrete_cure_time                   = 14.0      # curing time in (days)

    # options available for humidity diffusivity:
    moisture_diffusivity_model           = Bazant    # options: Bazant Xi Mensi
    D1                                   = 3.0e-8
    # aggregate_vol_fraction               = 0.7       # used in Xi's moisture diffusivity model

    coupled_moisture_diffusivity_factor  = 1.0e-2    # factor for mositure diffusivity due to heat

    # coupled nonlinear variables
    relative_humidity                    = rh
    temperature                          = temperature
  [../]
  [thermal_strain_concrete]
    type = ComputeThermalExpansionEigenstrain
    block = 'sml_circles big_circles'
    temperature = temperature
    thermal_expansion_coeff = 8.0e-5
    stress_free_temperature = 23.0
    eigenstrain_name = thermal_expansion
  []
  [./elasticity_tensor]
    type = ComputeElasticityTensor
    block = 'sml_circles big_circles boundary'
    fill_method = symmetric_isotropic
    C_ijkl = '0 5E9'
  [../]
  [./stress]
    type = ComputeFiniteStrainElasticStress
    block = 'sml_circles big_circles boundary'
  [../]
  [./density1]
    type = GenericConstantMaterial
    block = 'sml_circles'
    prop_names = 'density'
    prop_values = '100'
  [../]
  [./density2]
    type = GenericConstantMaterial
    block = 'big_circles'
    prop_names = 'density'
    prop_values = '50'
  [../]
  [./density3]
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
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  # petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount'
  # petsc_options_value = 'lu NONZERO   1e-15'

  nl_max_its = 20
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
