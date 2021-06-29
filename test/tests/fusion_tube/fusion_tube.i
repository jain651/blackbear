[Mesh]
  construct_side_list_from_node_list=true
  file = gold/fusion_tube.e
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  # [./disp_x]
  #   order = FIRST
  #   family = LAGRANGE
  # [../]
  # [./disp_y]
  #   order = FIRST
  #   family = LAGRANGE
  # [../]
  [./rot_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temperature]
    order = FIRST
    family = LAGRANGE
    initial_condition = 25.0
    block = '1 2'
  [../]
[]

[Kernels]
  [./T_td]
    type     = ConcreteThermalTimeIntegration
    variable = temperature
    block = '1 2'
  [../]
  [./T_diff]
    type     = ConcreteThermalConduction
    variable = temperature
    block = '1 2'
  [../]
  [./heat_dt]
    type = TimeDerivative
    variable = temperature
    block = '1 2'
  [../]
  [./heat_conduction1]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 10.0
    block = '1'
  [../]
  [./heat_conduction2]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 100.0
    block = '2'
  [../]
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./concrete]
    strain = FINITE
    block = '1 2'
    add_variables = true
    eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./concrete3]
    strain = FINITE
    block = '3'
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
    block = '1 2'
  [../]
  [./axial_stress]
    order = CONSTANT
    family = MONOMIAL
    block = '3'
  [../]
  [./e_over_l]
    order = CONSTANT
    family = MONOMIAL
    block = '3'
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
    block = '1 2'
  [../]
  [./thermal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1 2'
  [../]
  [./thermal_conductivity]
    order = CONSTANT
    family = Monomial
    block = '1 2'
  [../]
  [./thermal_capacity]
    order = CONSTANT
    family = Monomial
    block = '1 2'
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
    block = '1 2'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_yy]
    type = RankTwoAux
    block = '1 2'
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
    block = '1 2'
  [../]
  [./capacity]
    type = MaterialRealAux
    variable = thermal_capacity
    property = thermal_capacity
    execute_on = 'timestep_end'
    block = '1 2'
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
  [./rot_accel_z]
    type = NewmarkAccelAux
    variable = rot_accel_z
    displacement = rot_z
    velocity = rot_vel_z
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./rot_vel_z]
    type = NewmarkVelAux
    variable = rot_vel_z
    acceleration = rot_accel_z
    gamma = 0.5
    execute_on = timestep_end
  [../]
[]

[NodalKernels]
  [./x_inertial]
    type = NodalTranslationalInertia
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    boundary = '1'
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
    boundary = '1'
    beta = 0.25
    gamma = 0.5
    mass = 0.01899772
    eta = 0.1
  [../]
  [./rot_z_inertial]
    type = NodalRotationalInertia
    variable = rot_z
    rotations = 'rot_z'
    rotational_velocities = 'rot_vel_z'
    rotational_accelerations= 'rot_accel_z'
    boundary = '1'
    beta = 0.25
    gamma = 0.5
    Ixx = 2e-1
    Iyy = 1e-1
    Izz = 1e-1
    eta = 0.1
    component = 2
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
    primary = '1'
    secondary = '4'
    penalty = 1e6
    model = glued
    formulation = kinematic
  [../]
  [./bet_circles]
    primary = '1'
    secondary = '1'
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
  [./contact_slip2]
    type = ContactSlipDamper
    primary = '1'
    secondary = '1'
  [../]
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = '2 3'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = '2 3'
    value    = 0.0
  [../]
  [./temperature]
    type = FunctionDirichletBC
    variable = temperature
    boundary = '1'
    function = T
  [../]
[]

[Materials]
  [./concrete]
    type                                 = ConcreteThermalMoisture
    block                                = '1 2'
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
    aggregate_vol_fraction               = 0.7       # used in Xi's moisture diffusivity model

    coupled_moisture_diffusivity_factor  = 1.0e-2    # factor for mositure diffusivity due to heat

    # coupled nonlinear variables
    relative_humidity                    = rh
    temperature                          = temperature
  [../]
  [thermal_strain_concrete]
    type = ComputeThermalExpansionEigenstrain
    block = '1 2'
    temperature = temperature
    thermal_expansion_coeff = 8.0e-5
    stress_free_temperature = 23.0
    eigenstrain_name = thermal_expansion
  []
  [./elasticity_tensor]
    type = ComputeElasticityTensor
    block = '1 2 3'
    fill_method = symmetric_isotropic
    C_ijkl = '0 5E9'
  [../]
  [./stress]
    type = ComputeFiniteStrainElasticStress
    block = '1 2 3'
  [../]
  [./density1]
    type = GenericConstantMaterial
    block = '1'
    prop_names = 'density'
    prop_values = '100'
  [../]
  [./density2]
    type = GenericConstantMaterial
    block = '2'
    prop_names = 'density'
    prop_values = '50'
  [../]
  [./density3]
    type = GenericConstantMaterial
    block = '3'
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
 # csv = true
 # [./Console]
 #   type = Console
 # [../]
 [./Exo]
   type = Exodus
   elemental_as_nodal = true
 [../]
[]

[Debug]
  show_var_residual_norms = true
[]
