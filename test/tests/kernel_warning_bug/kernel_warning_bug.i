[GlobalParams]
  displacements = 'disp_x disp_y'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
[]

[Mesh]
  file = gold/TwoD_Model_w_line.e
[]

[Modules/TensorMechanics/Master]
  [./concrete]
    strain = FINITE
    block = '1'
    add_variables = true
    eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./rebar]
    block = '2'
    truss = true
    area = area_no6
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
[]

[Constraints]
  [./rebar_x]
    type = EqualValueEmbeddedConstraint
    secondary = 2
    primary = 1
    variable = 'disp_x'
    primary_variable = 'disp_x'
    formulation = penalty
    penalty = 1e12
  [../]
  [./rebar_y]
    type = EqualValueEmbeddedConstraint
    secondary = 2
    primary = 1
    variable = 'disp_y'
    primary_variable = 'disp_y'
    formulation = penalty
    penalty = 1e12
  [../]
[]

[Variables]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.0
  [../]
  [./rh]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.6
  [../]
[]

[Kernels]
  [./T_td]
    type     = ConcreteThermalTimeIntegration
    variable = T
    block = '1'
  [../]
  [./T_diff]
    type     = ConcreteThermalConduction
    variable = T
    block = '1'
  [../]
  [./T_conv]
    type     = ConcreteThermalConvection
    variable = T
    relative_humidity = rh
    block = '1'
  [../]
  [./T_adsorption]
    type     = ConcreteLatentHeat
    variable = T
    H = rh
    block = '1'
  [../]
  [./rh_td]
    type     = ConcreteMoistureTimeIntegration
    variable = rh
    block = '1'
  [../]
  [./rh_diff]
    type     = ConcreteMoistureDiffusion
    variable = rh
    temperature = T
    block = '1'
  [../]
  [./heat_dt]
    type = TimeDerivative
    variable = T
    block = '2'
  [../]
  [./heat_conduction]
    type = HeatConduction
    variable = T
    diffusion_coefficient = 53.0
    block = '2'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./area_no6]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./area_no6]
    type = ConstantAux
    block = '2'
    variable = area_no6
    value = 284e-6
    execute_on = 'initial timestep_begin'
  [../]
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = '2'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = '3'
    value    = 0.0
  [../]
  [./y_disp_loading]
    type = FunctionDirichletBC
    variable = disp_y
    boundary = '1'
    function = -1e-1*y*t
  [../]
  [./T]
    type = DirichletBC
    variable = T
    boundary = '4'
    value    = 23.0
  [../]
  [./RH]
    type = DirichletBC
    variable = rh
    boundary = '4'
    value    = 0.7
  [../]
[]

[Materials]
  [./concrete]
    type                                 = PorousMediaBase
    block                                = '1'
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
    temperature                          = T
  [../]
  [thermal_strain_concrete]
    type                                 = ComputeThermalExpansionEigenstrain
    block                                = '1'
    temperature                          = T
    thermal_expansion_coeff              = 8.0e-6
    stress_free_temperature              = 23.0
    eigenstrain_name                     = thermal_expansion
  []
  [./elastic_stress]
    type = ComputeFiniteStrainElasticStress
    block = '1'
  [../]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 1e6
    block = '1'
  [../]

  [truss]
    type                                 = LinearElasticTruss
    block                                = '2'
    youngs_modulus                       = 2.14e11
    temperature                          = T
    thermal_expansion_coeff              = 11.3e-6
    temperature_ref                      = 23.0
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
  start_time = 1209600
  dt = 604800
  automatic_scaling = true
  end_time = 630720000

  solve_type = 'PJFNK'
  nl_max_its = 20
  l_max_its = 100
  nl_abs_tol = 1e-5
  nl_rel_tol = 1e-3
  line_search = none
  petsc_options = '-snes_converged_reason'
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  # petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  # petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
[]

[Outputs]
  perf_graph     = true
  csv = true
  [./Console]
    type = Console
  [../]
  [./Exo]
    type = Exodus
    elemental_as_nodal = true
  [../]
  dofmap = true
[]

[Debug]
  show_var_residual_norms = true
[]
