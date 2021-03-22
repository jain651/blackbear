[GlobalParams]
  displacements = 'disp_x disp_z'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
[]

[Mesh]
  # file = gold/AxiSymm_trial_model.e
  file = gold/containment_structure/FullScale2DContainmentVessel.e
  # file = gold/containment_structure/Trial_2DContainmentVessel.e
  construct_side_list_from_node_list = true
  # block 1 surface 1
  # block 2 curve 5 to 8
  #
  # nodeset 1 add curve 1    # top
  # nodeset 2 add curve 2    # left
  # nodeset 3 add curve 3    # bot
  # nodeset 4 add curve 4    # right
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

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_z]
  [../]
  [./ASR_ex]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_vstrain]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_xy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_yz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./ASR_strain_zx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./volumetric_strain]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./thermal_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./thermal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./thermal_strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./thermal_conductivity]
    order = CONSTANT
    family = Monomial
  [../]
  [./thermal_capacity]
    order = CONSTANT
    family = Monomial
  [../]
  [./moisture_capacity]
    order = CONSTANT
    family = Monomial
  [../]
  [./humidity_diffusivity]
    order = CONSTANT
    family = Monomial
  [../]
  [./water_content]
    order = CONSTANT
    family = Monomial
  [../]
  [./water_hydrated]
    order = CONSTANT
    family = Monomial
  [../]
  [damage_index]
    order = CONSTANT
    family = MONOMIAL
  []

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
  [./temperature]
    initial_condition = 298.0
  [../]
  [./axial_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./area_no6]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz'

  [./concrete]
    block = '1'
    strain = FINITE
    add_variables = true
    eigenstrain_names = 'asr_expansion thermal_expansion'
    save_in = 'resid_x resid_z'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./rebar]
    block = '2'
    truss = true
    area = area_no6
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
[]

[Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
  primary_block = '1'
  secondary_block = '2'
  primary_variable = 'disp_x disp_z'
  displacements = 'disp_x disp_z'
  penalty = 1e12
  formulation = penalty
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

[AuxKernels]
  [./ASR_ex]
    type = MaterialRealAux
    variable = ASR_ex
    block = '1'
    property = ASR_extent
    execute_on = 'timestep_end'
  [../]
  [./ASR_vstrain]
    type = MaterialRealAux
    block = '1'
    variable = ASR_vstrain
    property = ASR_volumetric_strain
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_xx]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_yy]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_zz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_zz
    index_i = 2
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_xy]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_xy
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_yz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_yz
    index_i = 1
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_zx]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = asr_expansion
    variable = ASR_strain_zx
    index_i = 0
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_xx]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_yy]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_zz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_zz
    index_i = 2
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./volumetric_strain]
    type = RankTwoScalarAux
    scalar_type = VolumetricStrain
    rank_two_tensor = total_strain
    variable = volumetric_strain
    block = '1'
  [../]
  [./k]
    type = MaterialRealAux
    variable = thermal_conductivity
    property = thermal_conductivity
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [./capacity]
    type = MaterialRealAux
    variable = thermal_capacity
    property = thermal_capacity
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [./rh_capacity]
    type = MaterialRealAux
    variable = moisture_capacity
    property = moisture_capacity
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [./rh_duff]
    type = MaterialRealAux
    variable = humidity_diffusivity
    property = humidity_diffusivity
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [./wc_duff]
    type = MaterialRealAux
    variable = water_content
    property = moisture_content
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [./hydrw_duff]
    type = MaterialRealAux
    variable = water_hydrated
    property = hydrated_water
    execute_on = 'timestep_end'
    block = '1'
  [../]
  [damage_index]
    type = MaterialRealAux
    block = '1'
    variable = damage_index
    property = damage_index
    execute_on = timestep_end
  []
  # [./stress_xx]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_xx
  #   index_i = 0
  #   index_j = 0
  # [../]
  # [./stress_xy]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_xy
  #   index_i = 0
  #   index_j = 1
  # [../]
  # [./stress_xz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_xz
  #   index_i = 0
  #   index_j = 2
  # [../]
  # [./stress_yy]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_yy
  #   index_i = 1
  #   index_j = 1
  # [../]
  # [./stress_yz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_yz
  #   index_i = 1
  #   index_j = 2
  # [../]
  # [./stress_zz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = stress
  #   variable = stress_zz
  #   index_i = 2
  #   index_j = 2
  # [../]
  # [./strain_xx]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_xx
  #   index_i = 0
  #   index_j = 0
  # [../]
  # [./strain_xy]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_xy
  #   index_i = 0
  #   index_j = 1
  # [../]
  # [./strain_xz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_xz
  #   index_i = 0
  #   index_j = 2
  # [../]
  # [./strain_yy]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_yy
  #   index_i = 1
  #   index_j = 1
  # [../]
  # [./strain_yz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_yz
  #   index_i = 1
  #   index_j = 2
  # [../]
  # [./strain_zz]
  #   type = RankTwoAux
  #   block = '1'
  #   rank_two_tensor = elastic_strain
  #   variable = strain_zz
  #   index_i = 2
  #   index_j = 2
  # [../]
  [./area_no6]
    type = ConstantAux
    block = '2'
    variable = area_no6
    value = 284
    execute_on = 'initial timestep_begin'
  [../]
  [./axial_stress]
    type = MaterialRealAux
    block = '2'
    variable = axial_stress
    property = axial_stress
  [../]
[]

[Functions]
  [./T_air]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_air.csv
    format = columns
  [../]
  [./T_bet_grnd_2in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_bet_grnd_2in.csv
    format = columns
  [../]
  [./T_bet_2in_4in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_bet_2in_4in.csv
    format = columns
  [../]
  [./T_bet_4in_8in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_bet_4in_8in.csv
    format = columns
  [../]
  [./T_bet_8in_20in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_bet_8in_20in.csv
    format = columns
  [../]
  [./T_below_20in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/T_below_20in.csv
    format = columns
  [../]
  [./rh_air]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_air.csv
    format = columns
  [../]
  [./rh_bet_grnd_2in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_bet_grnd_2in.csv
    format = columns
  [../]
  [./rh_bet_2in_4in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_bet_2in_4in.csv
    format = columns
  [../]
  [./rh_bet_4in_8in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_bet_4in_8in.csv
    format = columns
  [../]
  [./rh_bet_8in_20in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_bet_8in_20in.csv
    format = columns
  [../]
  [./rh_below_20in]
    type = PiecewiseLinear
    data_file =  analysis/containment_str/rh_below_20in.csv
    format = columns
  [../]
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_z
    boundary = '1'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_x
    boundary = '1'
    value    = 0.0
  [../]
  # [./symmetry_x]
  #   type = DirichletBC
  #   variable = disp_x
  #   value = 0
  #   boundary = '4' # right
  # [../]
  # [./roller_z]
  #   type = DirichletBC
  #   variable = disp_z
  #   value = 0
  #   boundary = '3' # bottom
  # [../]
  [./top_load]
    type = FunctionDirichletBC
    variable = disp_z
    function = -0.001*t
    boundary = '1' # top
  [../]
  [./left_load]
    type = FunctionDirichletBC
    variable = disp_x
    function = -0.001*t
    boundary = '1' # top
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
  [./creep]
    type                                 = LinearViscoelasticStressUpdate
    block                                = '1'
  [../]
  [burgers]
    type                                = GeneralizedKelvinVoigtModel
    creep_modulus                       = '1.52e12
                                           5.32e18
                                           6.15e10
                                           6.86e10
                                           4.48e10
                                           1.05e128' # data from TAMU
    creep_viscosity                     = '1
                                           10
                                           100
                                           1000
                                           10000
                                           100000'  # data from TAMU
    poisson_ratio                       = 0.2
    young_modulus                       = 27.8e9 #33.03e9 Lower value from ACI eqn
    block                               = 1
  []
  [ASR_expansion]
    type                                 = ConcreteASREigenstrain
    block                                = '1'
    expansion_type                       = Anisotropic

    reference_temperature                = 23.0      # parameter to play
    temperature_unit                     = Celsius
    max_volumetric_expansion             = 1.125e-2  # parameter to play

    characteristic_time                  = 100       # parameter to play
    latency_time                         = 50        # parameter to play
    characteristic_activation_energy     = 5400.0
    latency_activation_energy            = 9400.0
    stress_latency_factor                = 1.0

    compressive_strength                 = 46.9e6
    compressive_stress_exponent          = 0.0
    expansion_stress_limit               = 8.0e6

    tensile_strength                     = 3.45e6
    tensile_retention_factor             = 1.0
    tensile_absorption_factor            = 1.0

    ASR_dependent_tensile_strength       = false
    residual_tensile_strength_fraction   = 1.0

    temperature                          = T
    relative_humidity                    = rh
    rh_exponent                          = 1.0
    eigenstrain_name                     = asr_expansion
    absolute_tolerance                   = 1e-10
    output_iteration_info_on_error       = true
  []
  [thermal_strain_concrete]
    type                                 = ComputeThermalExpansionEigenstrain
    block                                = '1'
    temperature                          = T
    thermal_expansion_coeff              = 8.0e-6
    stress_free_temperature              = 23.0
    eigenstrain_name                     = thermal_expansion
  []
  [ASR_damage_concrete]
    type                                 = ConcreteASRMicrocrackingDamage
    residual_youngs_modulus_fraction     = 0.1
    block                                = '1'
  []
  [./stress_concrete]
    type                                 = ComputeMultipleInelasticStress
    block                                = '1'
    inelastic_models                     = 'creep'
    damage_model                         = ASR_damage_concrete
  [../]

  # [./elasticity_tensor]
  #   type = ComputeIsotropicElasticityTensor
  #   youngs_modulus = 1e10
  #   poissons_ratio = 0.3
  #   block = '1'
  # [../]
  # [./_elastic_strain]
  #   type = ComputeFiniteStrainElasticStress
  #   block = '1'
  # [../]
  [truss]
    type                                 = LinearElasticTruss
    block                                = '2'
    youngs_modulus                       = 2.14e11
    temperature                          = temperature
    thermal_expansion_coeff              = 11.3e-6
    temperature_ref                      = 23.0
  []
[]

[UserObjects]
  [./visco_update]
    type = LinearViscoelasticityManager
    block = '1'
    # viscoelastic_model = logcreep
    viscoelastic_model = burgers
  [../]

  # [./mc_coh]
  #   type = TensorMechanicsHardeningConstant
  #   value = 10E6
  # [../]
  # [./mc_phi]
  #   type = TensorMechanicsHardeningConstant
  #   value = 40
  #   convert_to_radians = true
  # [../]
  # [./mc_psi]
  #   type = TensorMechanicsHardeningConstant
  #   value = 40
  #   convert_to_radians = true
  # [../]
  # [./mc]
  #   type = TensorMechanicsPlasticMohrCoulomb
  #   cohesion = mc_coh
  #   friction_angle = mc_phi
  #   dilation_angle = mc_psi
  #   mc_tip_smoother = 0.01E6
  #   mc_edge_smoother = 29
  #   yield_function_tolerance = 1E-5
  #   internal_constraint_tolerance = 1E-11
  # [../]

[]


[Postprocessors]
  [./ASR_strain]
    type = ElementAverageValue
    variable = ASR_vstrain
    block = '1'
  [../]
  [./ASR_strain_xx]
    type = ElementAverageValue
    variable = ASR_strain_xx
    block = '1'
  [../]
  [./ASR_strain_yy]
    type = ElementAverageValue
    variable = ASR_strain_yy
    block = '1'
  [../]
  [./ASR_strain_zz]
    type = ElementAverageValue
    variable = ASR_strain_zz
    block = '1'
  [../]
  [ASR_ext]
    type = ElementAverageValue
    variable = ASR_ex
    block = '1'
  []

  [./vonmises]
    type = ElementAverageValue
    variable = vonmises_stress
    block = '1'
  [../]

  [./vstrain]
    type = ElementAverageValue
    variable = volumetric_strain
    block = '1'
  [../]

  [./strain_xx]
    type = ElementAverageValue
    variable = strain_xx
    block = '1'
  [../]
  [./strain_yy]
    type = ElementAverageValue
    variable = strain_yy
    block = '1'
  [../]
  [./strain_zz]
    type = ElementAverageValue
    variable = strain_zz
    block = '1'
  [../]

  [./temp]
    type = ElementAverageValue
    variable = T
    block = '1'
  [../]
  [./humidity]
    type = ElementAverageValue
    variable = rh
    block = '1'
  [../]

  [./thermal_strain_xx]
    type = ElementAverageValue
    variable = thermal_strain_xx
    block = '1'
  [../]
  [./thermal_strain_yy]
    type = ElementAverageValue
    variable = thermal_strain_yy
    block = '1'
  [../]
  [./thermal_strain_zz]
    type = ElementAverageValue
    variable = thermal_strain_zz
    block = '1'
  [../]

  [./surfaceAvg_cyl_x]
    type = SideAverageValue
    variable = disp_x
    boundary = '32'
  [../]
  [./surfaceAvg_cyl_y]
    type = SideAverageValue
    variable = disp_z
    boundary = '32'
  [../]
  [./surfaceAvg_dome_x]
    type = SideAverageValue
    variable = disp_x
    boundary = '31'
  [../]
  [./surfaceAvg_dome_y]
    type = SideAverageValue
    variable = disp_z
    boundary = '31'
  [../]
  [./cyl_tang_x] # 500 mm gauge length (not the arc length)
    type = AveragePointSeparation
    displacements = 'disp_x'
    first_point = '2.59     2.43     4.470935'
    last_point = '2.26     2.743     4.470935'
  [../]
  [./cyl_tang_y] # 500 mm gauge length (not the arc length)
    type = AveragePointSeparation
    displacements = 'disp_z'
    first_point = '2.59     2.43     4.470935'
    last_point = '2.26     2.743     4.470935'
  [../]
  [./dome_tang_x]# 500 mm gauge length (not the arc length)
    type = AveragePointSeparation
    displacements = 'disp_x'
    first_point = '2.374 1.924 9.0805'# basesd on hand calculation
    last_point = '1.924 2.374 9.0805'
  [../]
  [./dome_tang_y]# 500 mm gauge length (not the arc length)
    type = AveragePointSeparation
    displacements = 'disp_z'
    first_point = '2.374 1.924 9.0805'# basesd on hand calculation
    last_point = '1.924 2.374 9.0805'
  [../]
[]

[Executioner]
  type       = Transient
  start_time = 1209600 # 28 days
  dt = 604800 # 259200 # 3 day
  automatic_scaling = true
  end_time = 630720000 # 7300 days

  # working solver conditions
  solve_type = 'NEWTON'
  nl_max_its = 100
  l_max_its = 100
  nl_abs_tol = 1.E-5
  nl_rel_tol = 1E-3
  line_search = none
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
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
[]

[Debug]
  show_var_residual_norms = true
[]
