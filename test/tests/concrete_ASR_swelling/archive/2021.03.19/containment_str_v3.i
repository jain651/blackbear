# Concrete properties
# Elastic Constants
# Young's modulus - 4800 ksi (33100 MPa)
# Poisson's ratio - 0.2
# Ultimate Tensile Strength - 500 psi (3.45 MPa)
# agg size = 3/8" (9.5 mm)
# HRWR was used
# w/c = 0.53
#
# Liner properties
# Basemat and Cylinder liner
# Elastic Constants:
# Modulus - 30000 ksi (207000 MPa)
# Poisson's ratio - 0.3
# Yield stress - 50.2 ksi (346 MPa)
#
# Elastic Constants:
# Modulus - 30000 ksi (207000 MPa)
# Poisson's ratio  - 0.3
# Yield stress - 51.4 ksi (354 MPa)
#
# Rebar Properties
# Elastic Constants:
# Modulus - 31000 ksi (207000 MPa)
# Poisson's ratio  - 0.3
# Yield stress - 66.6 ksi (459 MPa)

[GlobalParams]
 displacements = 'disp_x disp_y disp_z'
 volumetric_locking_correction = true
[]

[Mesh]
 file = gold/containment_structure/quarter_containment_wo_baseMat_liner_grade.e
 construct_side_list_from_node_list = true
# block 1 volume 8 to 12             # concrete structure
# block 3 curve 40 to 115           # #6 mat: bottom grid
# block 4 curve 143 to 194          # #5 mat: top grid
# block 5 curve 195 to 243           # #5 mat: top radial bars
# block 6 curve 244 to 258           # #6 mat: top circumfrential bars
# block 7 curve 259 to 271 525 to 1100        # #3 mat: shear stirrups
# block 8 curve 272 to 276 1101 to 1340      # #4 cylinear-mat connection bars
# block 9 curve 277 to 516           # #4 cylinear: long bars (layer 1 3 4 6)
# block 10 curve 517 to 522 1341 to 1436 1603 to 1698    # #4 cylinear-dome: meridional bars (layer 2 5)
# block 11 curve 1712 to 1782 1966 to 2430      # #4 cylinear-dome: seismic bars (layer 7 8)
#
# nodeset 1 add surface 114 74 104 42 94   # disp_y zero
# nodeset 1 add curve 1939 1843 1924
# nodeset 2 add surface 111 71 101 81 91   # disp_x zero
# nodeset 2 add curve 1934 1904 1920
# nodeset 3 add vertex 3653 3655 3618     # disp_z zero
# nodeset 4 add surface 113 72 83 93 73 112  # outer surface
# nodeset 5 add surface 93      # dome outer surface
# nodeset 6 add surface 83      # cylinder outer surface
# nodeset 7 add surface 72      # base outer surface
[]

[Variables]
 [./T]
   order = FIRST
   family = LAGRANGE
   initial_condition = 23.0
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
 [./resid_y]
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
 [./area_long_no8]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./area_no3]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./area_no4]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./area_no5]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./area_no6]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./axial_stress]
   order = CONSTANT
   family = MONOMIAL
 [../]
 [./axial_strain]
   order = CONSTANT
   family = MONOMIAL
 [../]
[]

[Modules/TensorMechanics/Master]
 [./concrete]
   block = '1'
   strain = FINITE
   add_variables = true
   eigenstrain_names = 'asr_expansion thermal_expansion'
   generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz'
   save_in = 'resid_x resid_y resid_z'
 [../]
[]

[Modules/TensorMechanics/LineElementMaster]
 [./btm_grid]
   block = '3'
   truss = true
   area = area_no6
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./top_grid]
   block = '4'
   truss = true
   area = area_no5
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./top_radial]
   block = '5'
   truss = true
   area = area_no5
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./top_circum]
   block = '6'
   truss = true
   area = area_no6
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./shear_stirrups]
   block = '7'
   truss = true
   area = area_no3
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./cyl_mat_connection]
   block = '8'
   truss = true
   area = area_no4
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./cyl_long]
   block = '9'
   truss = true
   area = area_no4
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./cyl_dome_meridional]
   block = '10'
   truss = true
   area = area_no4
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
 [./cyl_mat_seismic]
   block = '11'
   truss = true
   area = area_no4
   displacements = 'disp_x disp_y disp_z'
   save_in = 'resid_x resid_y resid_z'
 [../]
[]

[Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
  primary_block = '1'
  secondary_block = '3 4 5 6 7 8 9 10 11'
  primary_variable = 'disp_x disp_y disp_z'
  displacements = 'disp_x disp_y disp_z'
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
   block = '3 4 5 6 7 8 9 10 11'
 [../]
 [./heat_conduction]
   type = HeatConduction
   variable = T
   diffusion_coefficient = 53.0
   block = '3 4 5 6 7 8 9 10 11'
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
 [./area_no3]
   type = ConstantAux
   block = '7'
   variable = area_no3
   value = 71e-6
   execute_on = 'initial timestep_begin'
 [../]
 [./area_no4]
   type = ConstantAux
   block = '8 9 10 11'
   variable = area_no4
   value = 129e-6
   execute_on = 'initial timestep_begin'
 [../]
 [./area_no5]
   type = ConstantAux
   block = '4 5'
   variable = area_no5
   value = 200e-6
   execute_on = 'initial timestep_begin'
 [../]
 [./area_no6]
   type = ConstantAux
   block = '3 6'
   variable = area_no6
   value = 284e-6
   execute_on = 'initial timestep_begin'
 [../]
 [./axial_stress]
   type = MaterialRealAux
   block = '3 4 5 6 7 8 9 10 11'
   variable = axial_stress
   property = axial_stress
 [../]
[]

[Functions]
 [./ramp_temp]
   type = PiecewiseLinear
   data_file =  analysis/containment_str/TempProfile.csv
   format = columns
 [../]
 [./ramp_humidity]
   type = PiecewiseLinear
   data_file =  analysis/containment_str/RHProfile.csv
   format = columns
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
 [./logcreep]
   type                                 = ConcreteLogarithmicCreepModel
   block                                = '1'
   poissons_ratio                       = 0.2
   youngs_modulus                       = 33.1e9
   recoverable_youngs_modulus           = 33.1e9
   recoverable_viscosity                = 1
   long_term_viscosity                  = 1
   long_term_characteristic_time        = 1
   humidity                             = rh
   temperature                          = T
   activation_temperature               = 23.0
 [../]

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

 [./stress]
   type                                 = ComputeMultipleInelasticStress
   block                                = '1'
   inelastic_models                     = 'creep'
   damage_model                         = ASR_damage_concrete
 [../]

 [truss]
   type                                 = LinearElasticTruss
   block                                = '3 4 5 6 7 8 9 10 11'
   youngs_modulus                       = 2.14e11
   temperature                          = T
   thermal_expansion_coeff              = 11.3e-6
   temperature_ref                      = 23.0
 []
[]

[UserObjects]
 [./visco_update]
   type = LinearViscoelasticityManager
   block = '1'
   viscoelastic_model = logcreep
 [../]
[]

[BCs]
 [./x_disp]
   type = DirichletBC
   variable = disp_y
   boundary = 1
   value    = 0.0
 [../]
 [./y_disp]
   type = DirichletBC
   variable = disp_x
   boundary = 2
   value    = 0.0
 [../]
 [./z_disp]
   type = DirichletBC
   variable = disp_z
   boundary = 3
   value    = 0.0
 [../]
 [./T]
   type = FunctionDirichletBC
   variable = T
   boundary = '5 6 7'
   function = ramp_temp
 [../]
 [./rh]
   type = FunctionDirichletBC
   variable = rh
   boundary = '5 6 7'
   function = ramp_humidity
 [../]
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
   boundary = '6'
 [../]
 [./surfaceAvg_cyl_y]
   type = SideAverageValue
   variable = disp_y
   boundary = '6'
 [../]
 [./surfaceAvg_cyl_z]
   type = SideAverageValue
   variable = disp_z
   boundary = '5'
 [../]
 [./surfaceAvg_dome_x]
   type = SideAverageValue
   variable = disp_x
   boundary = '5'
 [../]
 [./surfaceAvg_dome_y]
   type = SideAverageValue
   variable = disp_y
   boundary = '5'
 [../]
 [./surfaceAvg_dome_z]
   type = SideAverageValue
   variable = disp_z
   boundary = '5'
 [../]
 [./cyl_z] # 500 mm gauge length
  type = AveragePointSeparation
  displacements = 'disp_z'
  first_point = '2.438776     2.597033     4.252161'
  last_point = '2.435685     2.593741     4.689710'
 [../]
 [./cyl_tang_x] # 500 mm gauge length (not the arc length)
  type = AveragePointSeparation
  displacements = 'disp_x'
  first_point = '2.59     2.43     4.470935'
  last_point = '2.26     2.743     4.470935'
 [../]
 [./cyl_tang_y] # 500 mm gauge length (not the arc length)
  type = AveragePointSeparation
  displacements = 'disp_y'
  first_point = '2.59     2.43     4.470935'
  last_point = '2.26     2.743     4.470935'
 [../]
 [./dome_z_arc]# 500 mm gauge length (not the arc length)
  type = AveragePointSeparation
  displacements = 'disp_z'
  first_point = '2.149293     2.303640     8.909285'
  last_point = '1.876000     2.020725     9.520732'
 [../]
 [./dome_tang_x]# 500 mm gauge length (not the arc length)
  type = AveragePointSeparation
  displacements = 'disp_x'
  first_point = '2.374 1.924 9.0805'# basesd on hand calculation
  last_point = '1.924 2.374 9.0805'
 [../]
 [./dome_tang_y]# 500 mm gauge length (not the arc length)
  type = AveragePointSeparation
  displacements = 'disp_y'
  first_point = '2.374 1.924 9.0805'# basesd on hand calculation
  last_point = '1.924 2.374 9.0805'
 [../]
[]

[Executioner]
  type       = Transient
  start_time = 1209600 # 28 days
  dt = 604800 # 7 day
  automatic_scaling = true
  end_time = 630720000 # 7300 days

  # working solver conditions
  solve_type = 'NEWTON'
  nl_max_its = 100
  nl_abs_tol = 1.E-5
  nl_rel_tol = 1E-3
  line_search = none
  petsc_options = '-ksp_snes_ew'
  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  petsc_options_value = 'hypre boomeramg 201 cubic 0.7'


  # other solver conditions
  # solve_type = 'NEWTON'
  # nl_max_its = 100
  # nl_abs_tol = 1.E-5
  # nl_rel_tol = 1E-3
  #
  # line_search = none
  # petsc_options_iname = '-pc_type'
  # petsc_options_value = 'lu'
  # petsc_options = '-snes_converged_reason'
  #
  # solve_type = 'PJFNK'
  # line_search = none
  # petsc_options = '-ksp_snes_ew'
  # petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  # petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
  # l_max_its  = 100
  # l_tol      = 1e-3
  # nl_max_its = 20
  # nl_rel_tol = 1e-5
  # nl_abs_tol = 1e-5
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
