# notes: convereges nicely without rebar and soil
[GlobalParams]
  displacements = 'disp_x disp_y'
  # volumetric_locking_correction = true
[]

# [Problem]
#   coord_type = RZ
# []

[Mesh]
  file = gold/containment_structure/FullContainment2D_XY_no_soil_contact.e
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz'
  [./concrete]
    block = '1'
    strain = FINITE
    add_variables = true
    eigenstrain_names = 'asr_expansion thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./soil]
    block = '12'
    strain = FINITE
    # add_variables = true
    # base_name = 'soil'
    # generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz'
    save_in = 'resid_x resid_y'
  [../]
[]

# [Modules/TensorMechanics/LineElementMaster]
#   [./Reinforcement_block]
#     block = '2'
#     truss = true
#     area = area
#     displacements = 'disp_x disp_y'
#     save_in = 'resid_x resid_y'
#   [../]
# []

# [Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
#   primary_block = '1'
#   secondary_block = '2'
#   primary_variable = 'disp_x disp_y'
#   displacements = 'disp_x disp_y'
#   penalty = 1e12
#   formulation = penalty
# []

[Variables]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 10.6
    # block = '1 2'
  [../]
  [./rh]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.8
    # block = '1 12'
  [../]
[]

[Kernels]
  [./T_td]
    type     = ConcreteThermalTimeIntegration
    variable = T
    block = 1
  [../]
  [./T_diff]
    type     = ConcreteThermalConduction
    variable = T
    block = 1
  [../]
  [./T_conv]
    type     = ConcreteThermalConvection
    variable = T
    relative_humidity = rh
    block = 1
  [../]
  [./T_adsorption]
    type     = ConcreteLatentHeat
    variable = T
    H = rh
    block = 1
  [../]

  [./rh_td]
    type     = ConcreteMoistureTimeIntegration
    variable = rh
    block = 1
  [../]
  [./rh_diff]
    type     = ConcreteMoistureDiffusion
    variable = rh
    temperature = T
    block = 1
  [../]
  # [./heat_dt]
  #   type = TimeDerivative
  #   variable = T
  #   block = '2'
  # [../]
  # [./heat_conduction]
  #   type = HeatConduction
  #   variable = T
  #   diffusion_coefficient = 53.0
  #   block = '2'
  # [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./ASR_ex]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_vstrain]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_xy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_yz]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./ASR_strain_zx]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./volumetric_strain]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./thermal_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./thermal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 1
  [../]
  [./thermal_strain_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 1
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

  # [./area]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./axial_stress]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  # [./axial_strain]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]

  # [./stress_xx_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./stress_xy_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./stress_xz_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./stress_yy_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./stress_yz_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./stress_zz_soil]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./mc_int]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
  # [./yield_fcn]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   block = '12'
  # [../]
[]

[AuxKernels]
  [./ASR_ex]
    type = MaterialRealAux
    variable = ASR_ex
    block = 1
    property = ASR_extent
    execute_on = 'timestep_end'
  [../]
  [./ASR_vstrain]
    type = MaterialRealAux
    block = 1
    variable = ASR_vstrain
    property = ASR_volumetric_strain
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_xx]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_yy]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_zz]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_zz
    index_i = 2
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_xy]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_xy
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  [../]

  [./ASR_strain_yz]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_yz
    index_i = 1
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./ASR_strain_zx]
    type = RankTwoAux
    block = 1
    rank_two_tensor = asr_expansion
    variable = ASR_strain_zx
    index_i = 0
    index_j = 2
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_xx]
    type = RankTwoAux
    block = 1
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_yy]
    type = RankTwoAux
    block = 1
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_zz]
    type = RankTwoAux
    block = 1
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
    block = 1
  [../]
  [./k]
    type = MaterialRealAux
    variable = thermal_conductivity
    property = thermal_conductivity
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./capacity]
    type = MaterialRealAux
    variable = thermal_capacity
    property = thermal_capacity
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./rh_capacity]
    type = MaterialRealAux
    variable = moisture_capacity
    property = moisture_capacity
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./rh_duff]
    type = MaterialRealAux
    variable = humidity_diffusivity
    property = humidity_diffusivity
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./wc_duff]
    type = MaterialRealAux
    variable = water_content
    property = moisture_content
    execute_on = 'timestep_end'
    block = 1
  [../]
  [./hydrw_duff]
    type = MaterialRealAux
    variable = water_hydrated
    property = hydrated_water
    execute_on = 'timestep_end'
    block = 1
  [../]
  [damage_index]
    type = MaterialRealAux
    block = 1
    variable = damage_index
    property = damage_index
    execute_on = timestep_end
  []

  # [./area]
  #   type = ConstantAux
  #   block = '2'
  #   variable = area
  #   value = 1.33e-4
  #   execute_on = 'initial timestep_begin'
  # [../]
  # [./axial_stress]
  #   type = MaterialRealAux
  #   block = '2'
  #   variable = axial_stress
  #   property = axial_stress
  # [../]

  # [./stress_xx]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_xx_soil
  #   block = '12'
  #   index_i = 0
  #   index_j = 0
  # [../]
  # [./stress_xy]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_xy_soil
  #   block = '12'
  #   index_i = 0
  #   index_j = 1
  # [../]
  # [./stress_xz]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_xz_soil
  #   block = '12'
  #   index_i = 0
  #   index_j = 2
  # [../]
  # [./stress_yy]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_yy_soil
  #   block = '12'
  #   index_i = 1
  #   index_j = 1
  # [../]
  # [./stress_yz]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_yz_soil
  #   block = '12'
  #   index_i = 1
  #   index_j = 2
  # [../]
  # [./stress_zz]
  #   type = RankTwoAux
  #   rank_two_tensor = stress
  #   variable = stress_zz_soil
  #   block = '12'
  #   index_i = 2
  #   index_j = 2
  # [../]
  # [./mc_int_auxk]
  #   type = MaterialStdVectorAux
  #   index = 0
  #   property = plastic_internal_parameter
  #   variable = mc_int
  #   block = '12'
  # [../]
  # [./yield_fcn_auxk]
  #   type = MaterialStdVectorAux
  #   index = 0
  #   property = plastic_yield_function
  #   variable = yield_fcn
  #   block = '12'
  # [../]
[]

[Functions]
  [./ramp_temp]
    type = PiecewiseLinear
    data_file = analysis/containment_str/T_air.csv
    format = columns
  [../]

  [./ramp_humidity]
    type = PiecewiseLinear
    data_file = analysis/containment_str/RH_air.csv
    format = columns
  [../]
[]

[Materials]
  [./concrete]
    type = PorousMediaBase
    block = '1'
    # setup thermal property models and parameters
    # options available: CONSTANT ASCE-1992 KODUR-2004 EUROCODE-2004 KIM-2003
    thermal_conductivity_model =  KODUR-2004
    thermal_capacity_model     =  KODUR-2004
    aggregate_type = Siliceous               #options: Siliceous Carbonate

    ref_density_of_concrete = 2231.0         # in kg/m^3
    ref_specific_heat_of_concrete = 1100.0   # in J/(Kg.0C)
    ref_thermal_conductivity_of_concrete = 3 # in W/(m.0C)


    # setup moisture capacity and humidity diffusivity models
    aggregate_pore_type = dense              #options: dense porous
    aggregate_mass = 1877.0                  #mass of aggregate (kg) per m^3 of concrete
    cement_type = 1                          #options: 1 2 3 4
    cement_mass = 354.0                      #mass of cement (kg) per m^3 of concrete
    water_to_cement_ratio       = 0.5
    concrete_cure_time          = 28.0       #curing time in (days)

    # options available for humidity diffusivity:
    moisture_diffusivity_model = Bazant      #options: Bazant Xi Mensi
    D1 = 3.0e-8
    aggregate_vol_fraction = 0.7             #used in Xi's moisture diffusivity model

    coupled_moisture_diffusivity_factor = 1.0e-2  # factor for mositure diffusivity due to heat

    # coupled nonlinear variables
    relative_humidity = rh
    temperature = T
  [../]

  [./creep]
    type = LinearViscoelasticStressUpdate
    block = 1
  [../]
  [./logcreep]
    type = ConcreteLogarithmicCreepModel
    block = 1
    poissons_ratio = 0.22
    youngs_modulus = 37.3e9
    recoverable_youngs_modulus = 37.3e9
    recoverable_viscosity = 1
    long_term_viscosity = 1
    long_term_characteristic_time = 1
    humidity = rh
    temperature = T
    activation_temperature = 23.0
  [../]


  [ASR_expansion]
    type = ConcreteASREigenstrain
    block = 1
    expansion_type = Anisotropic

    reference_temperature  = 35.0
    temperature_unit = Celsius
    max_volumetric_expansion = 2.2e-2

    characteristic_time = 18.9
    latency_time = 18.0
    characteristic_activation_energy = 5400.0
    latency_activation_energy = 9400.0
    stress_latency_factor = 1.0

    compressive_strength = 31.0e6
    compressive_stress_exponent = 0.0
    expansion_stress_limit = 8.0e6

    tensile_strength = 3.2e6
    tensile_retention_factor = 1.0
    tensile_absorption_factor = 1.0

    ASR_dependent_tensile_strength = false
    residual_tensile_strength_fraction = 1.0

    temperature = T
    relative_humidity = rh
    rh_exponent = 1.0
    eigenstrain_name = asr_expansion
    absolute_tolerance = 1e-10
    output_iteration_info_on_error = true
  []

  [thermal_strain_concrete]
    type = ComputeThermalExpansionEigenstrain
    block = 1
    temperature = T
    thermal_expansion_coeff = 8.0e-6
    stress_free_temperature = 10.6
    eigenstrain_name = thermal_expansion
  []

  [ASR_damage_concrete]
    type = ConcreteASRMicrocrackingDamage
    residual_youngs_modulus_fraction = 0.1
    block = 1
  []
  [./stress]
    type = ComputeMultipleInelasticStress
    block = 1
    inelastic_models = 'creep'
    damage_model = ASR_damage_concrete
  [../]

  # [truss]
  #   type = LinearElasticTruss
  #   block = '2'
  #   youngs_modulus = 2e11
  #   temperature = T
  #   thermal_expansion_coeff = 11.3e-6
  #   temperature_ref = 10.6
  # []

  # [./elastic_stress]
  #   type = ComputeFiniteStrainElasticStress
  #   block = '12'
  # [../]
  # [./elasticity_tensor]
  #   type = ComputeIsotropicElasticityTensor
  #   poissons_ratio = 0.3
  #   youngs_modulus = 1e6
  #   block = '12'
  # [../]

  [elastic_soil]
    type = ComputeElasticityTensor
    fill_method = symmetric_isotropic
    C_ijkl = '0 1E7'
    block = '12'
  []
  [./mc_soil_stress]
    type = ComputeMultiPlasticityStress
    block = '12'
    ep_plastic_tolerance = 1E-11
    plastic_models = mc
    max_NR_iterations = 1000
    debug_fspb = crash
  [../]
[]

[UserObjects]
  [./visco_update]
    type = LinearViscoelasticityManager
    block = 1
    viscoelastic_model = logcreep
  [../]
  [./mc_coh]
    type = TensorMechanicsHardeningConstant
    value = 10E6
  [../]
  [./mc_phi]
    type = TensorMechanicsHardeningConstant
    value = 40
    convert_to_radians = true
  [../]
  [./mc_psi]
    type = TensorMechanicsHardeningConstant
    value = 40
    convert_to_radians = true
  [../]
  [./mc]
    type = TensorMechanicsPlasticMohrCoulomb
    cohesion = mc_coh
    friction_angle = mc_phi
    dilation_angle = mc_psi
    mc_tip_smoother = 0.01E6
    mc_edge_smoother = 29
    yield_function_tolerance = 1E-5
    internal_constraint_tolerance = 1E-11
  [../]
[]

[BCs]
  [./disp_x]
    type = DirichletBC
    variable = disp_x
    boundary = '1'
    value = 0.0
  [../]
  [./disp_y]
    type = DirichletBC
    variable = disp_y
    boundary = '2 3'
    value = 0.0
  [../]
  # [./z]
  #   type = DirichletBC
  #   variable = disp_z
  #   boundary = '3'
  #   value = 0.0
  # [../]
  [./T]
    type = FunctionDirichletBC
    variable = T
    boundary = '30'
    function = ramp_temp
  [../]
  [./rh]
    type = FunctionDirichletBC
    variable = rh
    boundary = '30'
    function = ramp_humidity
  [../]
[]

# [Postprocessors]
#   [./nelem]
#     type = NumElems
#   [../]
#   [./ndof]
#     type = NumDOFs
#   [../]
#   [./ASR_strain]
#     type = ElementAverageValue
#     variable = ASR_vstrain
#     block = 1
#   [../]
#   [./ASR_strain_xx]
#     type = ElementAverageValue
#     variable = ASR_strain_xx
#     block = 1
#   [../]
#   [./ASR_strain_yy]
#     type = ElementAverageValue
#     variable = ASR_strain_yy
#     block = 1
#   [../]
#   [./ASR_strain_zz]
#     type = ElementAverageValue
#     variable = ASR_strain_zz
#     block = 1
#   [../]
#   [ASR_ext]
#     type = ElementAverageValue
#     variable = ASR_ex
#     block = 1
#   []
#   [./vonmises]
#     type = ElementAverageValue
#     variable = vonmises_stress
#     block = 1
#   [../]
#   [./vstrain]
#     type = ElementAverageValue
#     variable = volumetric_strain
#     block = 1
#   [../]
#   [./strain_xx]
#     type = ElementAverageValue
#     variable = strain_xx
#     block = 1
#   [../]
#   [./strain_yy]
#     type = ElementAverageValue
#     variable = strain_yy
#     block = 1
#   [../]
#   [./strain_zz]
#     type = ElementAverageValue
#     variable = strain_zz
#     block = 1
#   [../]
#   [./temp]
#     type = ElementAverageValue
#     variable = T
#     block = 1
#   [../]
#   [./humidity]
#     type = ElementAverageValue
#     variable = rh
#     block = 1
#   [../]
#   [./thermal_strain_xx]
#     type = ElementAverageValue
#     variable = thermal_strain_xx
#     block = 1
#   [../]
#   [./thermal_strain_yy]
#     type = ElementAverageValue
#     variable = thermal_strain_yy
#     block = 1
#   [../]
#   [./thermal_strain_zz]
#     type = ElementAverageValue
#     variable = thermal_strain_zz
#     block = 1
#   [../]
#   [./disp_x_101]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 101
#   [../]
#   [./disp_x_102]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 102
#   [../]
#   [./disp_x_103]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 103
#   [../]
#   [./disp_x_104]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 104
#   [../]
#   [./disp_x_105]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 105
#   [../]
#   [./disp_x_106]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = 106
#   [../]
#   [./disp_y_101]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 101
#   [../]
#   [./disp_y_102]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 102
#   [../]
#   [./disp_y_103]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 103
#   [../]
#   [./disp_y_104]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 104
#   [../]
#   [./disp_y_105]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 105
#   [../]
#   [./disp_y_106]
#     type = SideAverageValue
#     variable = disp_y
#     boundary = 106
#   [../]
#   [./disp_z_101]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 101
#   [../]
#   [./disp_z_102]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 102
#   [../]
#   [./disp_z_103]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 103
#   [../]
#   [./disp_z_104]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 104
#   [../]
#   [./disp_z_105]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 105
#   [../]
#   [./disp_z_106]
#     type = SideAverageValue
#     variable = disp_z
#     boundary = 106
#   [../]
#
#   [disp_x_p1_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 -0.08 -0.08'
#   [../]
#   [disp_x_p1_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 -0.08 -0.08'
#   [../]
#   [disp_x_p2_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 -0.08 0.08'
#   [../]
#   [disp_x_p2_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 -0.08 0.08'
#   [../]
#   [disp_x_p3_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 0.08 -0.08'
#   [../]
#   [disp_x_p3_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 0.08 -0.08'
#   [../]
#   [disp_x_p4_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 0.08 0.08'
#   [../]
#   [disp_x_p4_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 0.08 0.08'
#   [../]
#   [disp_x_p5_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 0.08 -0.235'
#   [../]
#   [disp_x_p5_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 0.08 -0.235'
#   [../]
#   [disp_x_p6_pos]
#     type = PointValue
#     variable = disp_x
#     point = '0.24 0.08 0.235'
#   [../]
#   [disp_x_p6_neg]
#     type = PointValue
#     variable = disp_x
#     point = '-0.24 0.08 0.235'
#   [../]
#
#   [disp_y_p1_pos]
#     type = PointValue
#     variable = disp_y
#     point = '-0.08 0.24 -0.08'
#   [../]
#   [disp_y_p1_neg]
#     type = PointValue
#     variable = disp_y
#     point = '-0.08 -0.24 -0.08'
#   [../]
#   [disp_y_p2_pos]
#     type = PointValue
#     variable = disp_y
#     point = '-0.08 0.24 0.08'
#   [../]
#   [disp_y_p2_neg]
#     type = PointValue
#     variable = disp_y
#     point = '-0.08 -0.24 0.08'
#   [../]
#   [disp_y_p3_pos]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 0.24 -0.08'
#   [../]
#   [disp_y_p3_neg]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 -0.24 -0.08'
#   [../]
#   [disp_y_p4_pos]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 0.24 0.08'
#   [../]
#   [disp_y_p4_neg]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 -0.24 0.08'
#   [../]
#   [disp_y_p5_pos]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 0.24 -0.235'
#   [../]
#   [disp_y_p5_neg]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 -0.24 -0.235'
#   [../]
#   [disp_y_p6_pos]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 0.24 0.235'
#   [../]
#   [disp_y_p6_neg]
#     type = PointValue
#     variable = disp_y
#     point = '0.08 -0.24 0.235'
#   [../]
#   [disp_y_p7_pos]
#     type = PointValue
#     variable = disp_y
#     point = '-0.235 0.24 0.08'
#   [../]
#   [disp_y_p7_neg]
#     type = PointValue
#     variable = disp_y
#     point = '-0.235 -0.24 0.08'
#   [../]
#   [disp_y_p8_pos]
#     type = PointValue
#     variable = disp_y
#     point = '0.235 0.24 0.08'
#   [../]
#   [disp_y_p8_neg]
#     type = PointValue
#     variable = disp_y
#     point = '0.235 -0.24 0.08'
#   [../]
#
#   [disp_z_p1_pos]
#     type = PointValue
#     variable = disp_z
#     point = '-0.08 -0.08 0.24'
#   [../]
#   [disp_z_p1_neg]
#     type = PointValue
#     variable = disp_z
#     point = '-0.08 -0.08 -0.24'
#   [../]
#   [disp_z_p2_pos]
#     type = PointValue
#     variable = disp_z
#     point = '-0.08 0.08 0.24'
#   [../]
#   [disp_z_p2_neg]
#     type = PointValue
#     variable = disp_z
#     point = '-0.08 0.08 -0.24'
#   [../]
#   [disp_z_p3_pos]
#     type = PointValue
#     variable = disp_z
#     point = '0.08 -0.08 0.24'
#   [../]
#   [disp_z_p3_neg]
#     type = PointValue
#     variable = disp_z
#     point = '0.08 -0.08 -0.24'
#   [../]
#   [disp_z_p4_pos]
#     type = PointValue
#     variable = disp_z
#     point = '0.08 0.08 0.24'
#   [../]
#   [disp_z_p4_neg]
#     type = PointValue
#     variable = disp_z
#     point = '0.08 0.08 -0.24'
#   [../]
#   [disp_z_p5_pos]
#     type = PointValue
#     variable = disp_z
#     point = '0.235 0.08 0.24'
#   [../]
#   [disp_z_p5_neg]
#     type = PointValue
#     variable = disp_z
#     point = '0.235 0.08 -0.24'
#   [../]
#   [disp_z_p6_pos]
#     type = PointValue
#     variable = disp_z
#     point = '-0.235 0.08 0.24'
#   [../]
#   [disp_z_p6_neg]
#     type = PointValue
#     variable = disp_z
#     point = '-0.235 0.08 -0.24'
#   [../]
# []

[Executioner]
  type       = Transient
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  # petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  # petsc_options_value = 'lu boomeramg 201 cubic 0.7'
  # solve_type = 'PJFNK'
  # petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  # petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
  line_search = none
  start_time = 2419200
  dt = 1000000
  automatic_scaling = true
  end_time = 38880000
  l_max_its  = 50
  l_tol      = 1e-4
  nl_max_its = 10
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10
[]

[Outputs]
  perf_graph = true
  csv = true
  #exodus = true #Turned off to save space
[]

[Debug]
  show_var_residual_norms = true
[]
