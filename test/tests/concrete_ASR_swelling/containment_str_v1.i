[GlobalParams]
 displacements = 'disp_x disp_y disp_z'
 volumetric_locking_correction = true
[]

[Mesh]
 file = gold/containment_structure/quarter_containment.e
 construct_side_list_from_node_list = true
# block 1 volume 8 to 12 				    # concrete structure
# block 2 surface 103 85 95					# steel liner
# block 3 curve 40 to 115 					# #6 mat: bottom grid
# block 4 curve 143 to 194					# #5 mat: top grid
# block 5 curve 195 to 243 					# #5 mat: top radial bars
# block 6 curve 244 to 258 					# #6 mat: top circumfrential bars
# block 7 curve 259 to 271 525 to 1100				# #3 mat: shear stirrups
# block 8 curve 272 to 276 1101 to 1340			# #4 cylinear-mat connection bars
# block 9 curve 277 to 516 					# #4 cylinear: long bars (layer 1 3 4 6)
# block 10 curve 517 to 522 1341 to 1436 1603 to 1698		# #4 cylinear-dome: meridional bars (layer 2 5)
# block 11 curve 1712 to 1782 1966 to 2430			# #4 cylinear-dome: seismic bars (layer 7 8)
# nodeset 1 add surface 114 74 104 42 94 	# disp_y zero
# nodeset 1 add curve 1939 1843 1924
# nodeset 2 add surface 111 71 101 81 91 	# disp_x zero
# nodeset 2 add curve 1934 1904 1920
# nodeset 3 add vertex 3650 3685 3687		# disp_z zero
# nodeset 4 add surface 113 72 83 93 73 112	# outer surface

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
   block = '1 2'
 [../]
 [./ASR_vstrain]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_xx]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_yy]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_zz]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_xy]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_yz]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./ASR_strain_zx]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
 [../]
 [./volumetric_strain]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
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
 [./thermal_strain_zz]
   order = CONSTANT
   family = MONOMIAL
   block = '1 2'
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
   block = '1 2'
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
  primary_block = '1 2'
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
   block = '1 2'
 [../]
 [./T_diff]
   type     = ConcreteThermalConduction
   variable = T
   block = '1 2'
 [../]

 [./T_conv]
   type     = ConcreteThermalConvection
   variable = T
   relative_humidity = rh
   block = '1 2'
 [../]

 [./T_adsorption]
   type     = ConcreteLatentHeat
   variable = T
   H = rh
   block = '1 2'
 [../]

 [./rh_td]
   type     = ConcreteMoistureTimeIntegration
   variable = rh
   block = '1 2'
 [../]

 [./rh_diff]
   type     = ConcreteMoistureDiffusion
   variable = rh
   temperature = T
   block = '1 2'
 [../]
 [./heat_dt]
   type = TimeDerivative
   variable = T
   block = '2 3 4 5 6 7 8 9 10 11'
 [../]
 [./heat_conduction]
   type = HeatConduction
   variable = T
   diffusion_coefficient = 53.0
   block = '2 3 4 5 6 7 8 9 10 11'
 [../]
[]

[AuxKernels]
 [./ASR_ex]
   type = MaterialRealAux
   variable = ASR_ex
   block = '1 2'
   property = ASR_extent
   execute_on = 'timestep_end'
 [../]
 [./ASR_vstrain]
   type = MaterialRealAux
   block = '1 2'
   variable = ASR_vstrain
   property = ASR_volumetric_strain
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_xx]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_xx
   index_i = 0
   index_j = 0
   execute_on = 'timestep_end'
 [../]
 [./ASR_strain_yy]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_yy
   index_i = 1
   index_j = 1
   execute_on = 'timestep_end'
 [../]
 [./ASR_strain_zz]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_zz
   index_i = 2
   index_j = 2
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_xy]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_xy
   index_i = 0
   index_j = 1
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_yz]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_yz
   index_i = 1
   index_j = 2
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_zx]
   type = RankTwoAux
   block = '1 2'
   rank_two_tensor = asr_expansion
   variable = ASR_strain_zx
   index_i = 0
   index_j = 2
   execute_on = 'timestep_end'
 [../]
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
 [./thermal_strain_zz]
   type = RankTwoAux
   block = '1 2'
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
   block = '1 2'
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

 [./rh_capacity]
   type = MaterialRealAux
   variable = moisture_capacity
   property = moisture_capacity
   execute_on = 'timestep_end'
   block = '1 2'
 [../]
 [./rh_duff]
   type = MaterialRealAux
   variable = humidity_diffusivity
   property = humidity_diffusivity
   execute_on = 'timestep_end'
   block = '1 2'
 [../]
 [./wc_duff]
   type = MaterialRealAux
   variable = water_content
   property = moisture_content
   execute_on = 'timestep_end'
   block = '1 2'
 [../]
 [./hydrw_duff]
   type = MaterialRealAux
   variable = water_hydrated
   property = hydrated_water
   execute_on = 'timestep_end'
   block = '1 2'
 [../]

 [damage_index]
   type = MaterialRealAux
   block = '1 2'
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
   x = '5443200	5529600	5788800	5875200	5961600	6480000	6652800	7689600	7948800	8294400	8553600	8899200	9590400	9763200	10108800	10627200	10713600	10972800	11318400	11577600	11750400	12182400	12614400	13132800	13392000	15811200	16156800	23068800	23414400	23673600	24019200	24278400	24624000	24883200	25228800	25488000	25833600	26092800	26438400	26697600	27043200	27302400	27648000	27820800	28080000	28339200	28684800	28944000	29289600	29548800	29894400	30153600	30499200	31104000	31363200	31708800	31968000	32400000	32572800	32918400	33177600	33782400	34128000	34387200	34819200	34992000	35337600	35596800	35942400	36201600	36460800	37152000	41990400'
   y = '22.76666667	22.93333333	23.03333333	23.2	23.23333333	22.30666667	22.86666667	22.53333333	23.05333333	22.8	23.65333333	23.86666667	23.89333333	24.06666667	21.49333333	20.74666667	22.28	23.37333333	23.01333333	23.09333333	22.94666667	23.53333333	22	24.14	24.1	23.52	22.86666667	23.84	24	23.54666667	24.08	23.6	23.2	22.90666667	22.61333333	23.05333333	23.85333333	24.02666667	24.18666667	24.17333333	24.56	24.06666667	24.04	23.98666667	24.50666667	24.33333333	24.64	23.62666667	23.81333333	23.30666667	23.21333333	23.70666667	24.06666667	24.04	23.08	23.08	21.49333333	23.78666667	24.69333333	23.98666667	24.06666667	23.65333333	23.28	22.4	23.28	23.37333333	23.38666667	24.09333333	24.13333333	23.68	24.26666667	22.8	23.36'
 [../]

 [./ramp_humidity]
   type = PiecewiseLinear
   x = '5443200	5529600	5788800	5875200	5961600	6480000	6652800	7689600	7948800	8294400	8553600	8899200	9590400	9763200	10108800	10627200	10713600	10972800	11318400	11577600	11750400	12182400	12614400	13132800	13392000	15811200	16156800	16416000	16761600	17020800	17366400	17625600	17971200	18230400	18576000	18835200	19180800	19440000	19785600	20044800	20390400	20649600	20995200	21254400	21600000	21859200	22204800	22464000	22809600	23068800	23414400	23673600	24019200	24278400	24624000	24883200	25228800	25488000	25833600	26092800	26438400	26697600	27043200	27302400	27648000	27820800	28080000	28339200	28684800	28944000	29289600	29548800	29894400	30153600	30499200	31104000	31363200	31708800	31968000	32400000	32572800	32918400	33177600	33782400	34128000	34387200	34819200	34992000	35337600	35596800	35942400	36201600	36460800	36806400	37152000	37411200	37756800	38016000	38361600	38620800	39916800	40176000	40521600	40780800	41126400	41385600	41731200	41990400	42336000	42595200	42940800	43200000	44150400	44755200	45964800	47174400	49593600'
   y = '0.645	0.6405	0.7035	0.724	0.655	0.71715	0.70595	0.64655	0.7529	0.5937	0.71865	0.7749	0.69165	0.7503	0.63625	0.7356	0.73365	0.72215	0.7232	0.5786	0.60365	0.65865	0.7056	0.6654	0.677	0.70405	0.7471	0.5504	0.5935	0.6041	0.5501	0.6049	0.5737	0.5737	0.5565	0.579	0.6359	0.6498	0.592	0.6316	0.5268	0.5428	0.5719	0.5698	0.558	0.5563	0.5676	0.5589	0.5245	0.521	0.67125	0.67835	0.67615	0.6476	0.6357	0.64165	0.6466	0.67785	0.6761	0.63415	0.6711	0.67215	0.66075	0.6338	0.55545	0.5838	0.6676	0.66155	0.6647	0.63045	0.6644	0.5896	0.53645	0.57885	0.61215	0.577	0.6295	0.54275	0.6234	0.6214	0.54425	0.64425	0.61305	0.498	0.4804	0.48765	0.6013	0.6152	0.61525	0.6392	0.4079	0.6904	0.4105	0.4454	0.4329	0.3574	0.3171	0.4285	0.2976	0.3001	0.4255	0.3549	0.2795	0.3903	0.4187	0.4583	0.4216	0.3801	0.4164	0.476	0.3829	0.4346	0.5552	0.5171	0.4936	0.527	0.551'
 [../]
[]

[Materials]
 [./concrete]
   type                                 = PorousMediaBase
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
   water_to_cement_ratio                = 0.52
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
   block                                = '1 2'
 [../]
 [./logcreep]
   type                                 = ConcreteLogarithmicCreepModel
   block                                = '1 2'
   poissons_ratio                       = 0.22
   youngs_modulus                       = 37.3e9
   recoverable_youngs_modulus           = 37.3e9
   recoverable_viscosity                = 1
   long_term_viscosity                  = 1
   long_term_characteristic_time        = 1
   humidity                             = rh
   temperature                          = T
   activation_temperature               = 23.0
 [../]

 [ASR_expansion]
   type                                 = ConcreteASREigenstrain
   block                                = '1 2'
   expansion_type                       = Anisotropic

   reference_temperature                = 23.0      # parameter to play
   temperature_unit                     = Celsius
   max_volumetric_expansion             = 1.125e-2  # parameter to play

   characteristic_time                  = 100       # parameter to play
   latency_time                         = 50        # parameter to play
   characteristic_activation_energy     = 5400.0
   latency_activation_energy            = 9400.0
   stress_latency_factor                = 1.0

   compressive_strength                 = 38.0e6
   compressive_stress_exponent          = 0.0
   expansion_stress_limit               = 8.0e6

   tensile_strength                     = 3.8e6
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
   block                                = '1 2'
   temperature                          = T
   thermal_expansion_coeff              = 8.0e-6
   stress_free_temperature              = 10.6
   eigenstrain_name                     = thermal_expansion
 []

 [ASR_damage_concrete]
   type                                 = ConcreteASRMicrocrackingDamage
   residual_youngs_modulus_fraction     = 0.1
   block                                = '1 2'
 []

 [./stress]
   type                                 = ComputeMultipleInelasticStress
   block                                = '1 2'
   inelastic_models                     = 'creep'
   damage_model                         = ASR_damage_concrete
 [../]

 [truss]
   type                                 = LinearElasticTruss
   block                                = '3 4 5 6 7 8 9 10 11'
   youngs_modulus                       = 2e11
   temperature                          = T
   thermal_expansion_coeff              = 11.3e-6
   temperature_ref                      = 10.6
 []
[]

[UserObjects]
 [./visco_update]
   type = LinearViscoelasticityManager
   block = '1 2'
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
   boundary = '4'
   function = ramp_temp
 [../]
 [./rh]
   type = FunctionDirichletBC
   variable = rh
   boundary = '4'
   function = ramp_humidity
 [../]
[]

[Postprocessors]
 [./ASR_strain]
   type = ElementAverageValue
   variable = ASR_vstrain
   block = '1 2'
 [../]
 [./ASR_strain_xx]
   type = ElementAverageValue
   variable = ASR_strain_xx
   block = '1 2'
 [../]
 [./ASR_strain_yy]
   type = ElementAverageValue
   variable = ASR_strain_yy
   block = '1 2'
 [../]
 [./ASR_strain_zz]
   type = ElementAverageValue
   variable = ASR_strain_zz
   block = '1 2'
 [../]
 [ASR_ext]
   type = ElementAverageValue
   variable = ASR_ex
   block = '1 2'
 []

 [./vonmises]
   type = ElementAverageValue
   variable = vonmises_stress
   block = '1 2'
 [../]

 [./vstrain]
   type = ElementAverageValue
   variable = volumetric_strain
   block = '1 2'
 [../]

 [./strain_xx]
   type = ElementAverageValue
   variable = strain_xx
   block = '1 2'
 [../]
 [./strain_yy]
   type = ElementAverageValue
   variable = strain_yy
   block = '1 2'
 [../]
 [./strain_zz]
   type = ElementAverageValue
   variable = strain_zz
   block = '1 2'
 [../]

 [./temp]
   type = ElementAverageValue
   variable = T
   block = '1 2'
 [../]
 [./humidity]
   type = ElementAverageValue
   variable = rh
   block = '1 2'
 [../]

 [./thermal_strain_xx]
   type = ElementAverageValue
   variable = thermal_strain_xx
   block = '1 2'
 [../]
 [./thermal_strain_yy]
   type = ElementAverageValue
   variable = thermal_strain_yy
   block = '1 2'
 [../]
 [./thermal_strain_zz]
   type = ElementAverageValue
   variable = thermal_strain_zz
   block = '1 2'
 [../]

 [./surfaceAvg_x]
   type = SideAverageValue
   variable = disp_x
   boundary = '4'
 [../]
 [./surfaceAvg_y]
   type = SideAverageValue
   variable = disp_y
   boundary = '4'
 [../]
 [./surfaceAvg_z]
   type = SideAverageValue
   variable = disp_z
   boundary = '4'
 [../]
 [./cyl_x]
  type = PointsSeparation
  variable1 = disp_x
  variable2 = disp_y
  variable3 = disp_z
  point1 = '-2.8175 +0.225 +0.255'
  point2 = '-2.8175 -0.225 +0.255'
 [../]

[]

[Executioner]
  type       = Transient
  start_time = 1209600 # 28 days
  dt = 86400 # 1 day
  automatic_scaling = true
  end_time = 21600000 # 250 days

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
