<<<<<<< HEAD
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


=======
>>>>>>> first_running_model
[GlobalParams]
 displacements = 'disp_x disp_y disp_z'
 volumetric_locking_correction = true
[]

[Mesh]
<<<<<<< HEAD
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
=======
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

>>>>>>> first_running_model
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
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_vstrain]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_xx]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_yy]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_zz]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_xy]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_yz]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_zx]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./volumetric_strain]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./thermal_strain_xx]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./thermal_strain_yy]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./thermal_strain_zz]
   order = CONSTANT
   family = MONOMIAL
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
  primary_block = '1'
=======
  primary_block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./T_diff]
   type     = ConcreteThermalConduction
   variable = T
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./T_conv]
   type     = ConcreteThermalConvection
   variable = T
   relative_humidity = rh
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./T_adsorption]
   type     = ConcreteLatentHeat
   variable = T
   H = rh
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./rh_td]
   type     = ConcreteMoistureTimeIntegration
   variable = rh
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./rh_diff]
   type     = ConcreteMoistureDiffusion
   variable = rh
   temperature = T
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./heat_dt]
   type = TimeDerivative
   variable = T
<<<<<<< HEAD
   block = '3 4 5 6 7 8 9 10 11'
=======
   block = '2 3 4 5 6 7 8 9 10 11'
>>>>>>> first_running_model
 [../]
 [./heat_conduction]
   type = HeatConduction
   variable = T
   diffusion_coefficient = 53.0
<<<<<<< HEAD
   block = '3 4 5 6 7 8 9 10 11'
=======
   block = '2 3 4 5 6 7 8 9 10 11'
>>>>>>> first_running_model
 [../]
[]

[AuxKernels]
 [./ASR_ex]
   type = MaterialRealAux
   variable = ASR_ex
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   property = ASR_extent
   execute_on = 'timestep_end'
 [../]
 [./ASR_vstrain]
   type = MaterialRealAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   variable = ASR_vstrain
   property = ASR_volumetric_strain
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_xx]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_xx
   index_i = 0
   index_j = 0
   execute_on = 'timestep_end'
 [../]
 [./ASR_strain_yy]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_yy
   index_i = 1
   index_j = 1
   execute_on = 'timestep_end'
 [../]
 [./ASR_strain_zz]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_zz
   index_i = 2
   index_j = 2
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_xy]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_xy
   index_i = 0
   index_j = 1
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_yz]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_yz
   index_i = 1
   index_j = 2
   execute_on = 'timestep_end'
 [../]

 [./ASR_strain_zx]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = asr_expansion
   variable = ASR_strain_zx
   index_i = 0
   index_j = 2
   execute_on = 'timestep_end'
 [../]
 [./thermal_strain_xx]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = thermal_expansion
   variable = thermal_strain_xx
   index_i = 0
   index_j = 0
   execute_on = 'timestep_end'
 [../]
 [./thermal_strain_yy]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
   rank_two_tensor = thermal_expansion
   variable = thermal_strain_yy
   index_i = 1
   index_j = 1
   execute_on = 'timestep_end'
 [../]
 [./thermal_strain_zz]
   type = RankTwoAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./k]
   type = MaterialRealAux
   variable = thermal_conductivity
   property = thermal_conductivity
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./capacity]
   type = MaterialRealAux
   variable = thermal_capacity
   property = thermal_capacity
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./rh_capacity]
   type = MaterialRealAux
   variable = moisture_capacity
   property = moisture_capacity
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./rh_duff]
   type = MaterialRealAux
   variable = humidity_diffusivity
   property = humidity_diffusivity
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./wc_duff]
   type = MaterialRealAux
   variable = water_content
   property = moisture_content
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./hydrw_duff]
   type = MaterialRealAux
   variable = water_hydrated
   property = hydrated_water
   execute_on = 'timestep_end'
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [damage_index]
   type = MaterialRealAux
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   value = 129e-6
=======
   value = 129-6
>>>>>>> first_running_model
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
<<<<<<< HEAD
   data_file =  analysis/containment_str/TempProfile.csv
   format = columns
 [../]
 [./ramp_humidity]
   type = PiecewiseLinear
   data_file =  analysis/containment_str/RHProfile.csv
   format = columns
=======
   x = '5443200	5529600	5788800	5875200	5961600	6480000	6652800	7689600	7948800	8294400	8553600	8899200	9590400	9763200	10108800	10627200	10713600	10972800	11318400	11577600	11750400	12182400	12614400	13132800	13392000	15811200	16156800	23068800	23414400	23673600	24019200	24278400	24624000	24883200	25228800	25488000	25833600	26092800	26438400	26697600	27043200	27302400	27648000	27820800	28080000	28339200	28684800	28944000	29289600	29548800	29894400	30153600	30499200	31104000	31363200	31708800	31968000	32400000	32572800	32918400	33177600	33782400	34128000	34387200	34819200	34992000	35337600	35596800	35942400	36201600	36460800	37152000	41990400'
   y = '22.76666667	22.93333333	23.03333333	23.2	23.23333333	22.30666667	22.86666667	22.53333333	23.05333333	22.8	23.65333333	23.86666667	23.89333333	24.06666667	21.49333333	20.74666667	22.28	23.37333333	23.01333333	23.09333333	22.94666667	23.53333333	22	24.14	24.1	23.52	22.86666667	23.84	24	23.54666667	24.08	23.6	23.2	22.90666667	22.61333333	23.05333333	23.85333333	24.02666667	24.18666667	24.17333333	24.56	24.06666667	24.04	23.98666667	24.50666667	24.33333333	24.64	23.62666667	23.81333333	23.30666667	23.21333333	23.70666667	24.06666667	24.04	23.08	23.08	21.49333333	23.78666667	24.69333333	23.98666667	24.06666667	23.65333333	23.28	22.4	23.28	23.37333333	23.38666667	24.09333333	24.13333333	23.68	24.26666667	22.8	23.36'
 [../]

 [./ramp_humidity]
   type = PiecewiseLinear
   x = '5443200	5529600	5788800	5875200	5961600	6480000	6652800	7689600	7948800	8294400	8553600	8899200	9590400	9763200	10108800	10627200	10713600	10972800	11318400	11577600	11750400	12182400	12614400	13132800	13392000	15811200	16156800	16416000	16761600	17020800	17366400	17625600	17971200	18230400	18576000	18835200	19180800	19440000	19785600	20044800	20390400	20649600	20995200	21254400	21600000	21859200	22204800	22464000	22809600	23068800	23414400	23673600	24019200	24278400	24624000	24883200	25228800	25488000	25833600	26092800	26438400	26697600	27043200	27302400	27648000	27820800	28080000	28339200	28684800	28944000	29289600	29548800	29894400	30153600	30499200	31104000	31363200	31708800	31968000	32400000	32572800	32918400	33177600	33782400	34128000	34387200	34819200	34992000	35337600	35596800	35942400	36201600	36460800	36806400	37152000	37411200	37756800	38016000	38361600	38620800	39916800	40176000	40521600	40780800	41126400	41385600	41731200	41990400	42336000	42595200	42940800	43200000	44150400	44755200	45964800	47174400	49593600'
   y = '64.5	64.05	70.35	72.4	65.5	71.715	70.595	64.655	75.29	59.37	71.865	77.49	69.165	75.03	63.625	73.56	73.365	72.215	72.32	57.86	60.365	65.865	70.56	66.54	67.7	70.405	74.71	55.04	59.35	60.41	55.01	60.49	57.37	57.37	55.65	57.9	63.59	64.98	59.2	63.16	52.68	54.28	57.19	56.98	55.8	55.63	56.76	55.89	52.45	52.1	67.125	67.835	67.615	64.76	63.57	64.165	64.66	67.785	67.61	63.415	67.11	67.215	66.075	63.38	55.545	58.38	66.76	66.155	66.47	63.045	66.44	58.96	53.645	57.885	61.215	57.7	62.95	54.275	62.34	62.14	54.425	64.425	61.305	49.8	48.04	48.765	60.13	61.52	61.525	63.92	40.79	69.04	41.05	44.54	43.29	35.74	31.71	42.85	29.76	30.01	42.55	35.49	27.95	39.03	41.87	45.83	42.16	38.01	41.64	47.6	38.29	43.46	55.52	51.71	49.36	52.7	55.1'
>>>>>>> first_running_model
 [../]
[]

[Materials]
 [./concrete]
   type                                 = PorousMediaBase
<<<<<<< HEAD
   block                                = '1'
=======
   block                                = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   water_to_cement_ratio                = 0.53
=======
   water_to_cement_ratio                = 0.52
>>>>>>> first_running_model
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
<<<<<<< HEAD
   block                                = '1'
 [../]
 [./logcreep]
   type                                 = ConcreteLogarithmicCreepModel
   block                                = '1'
   poissons_ratio                       = 0.2
   youngs_modulus                       = 33.1e9
   recoverable_youngs_modulus           = 33.1e9
=======
   block                                = '1 2'
 [../]
 [./logcreep]
   type                                 = ConcreteLogarithmicCreepModel
   block                                = '1 2'
   poissons_ratio                       = 0.22
   youngs_modulus                       = 37.3e9
   recoverable_youngs_modulus           = 37.3e9
>>>>>>> first_running_model
   recoverable_viscosity                = 1
   long_term_viscosity                  = 1
   long_term_characteristic_time        = 1
   humidity                             = rh
   temperature                          = T
   activation_temperature               = 23.0
 [../]

 [ASR_expansion]
   type                                 = ConcreteASREigenstrain
<<<<<<< HEAD
   block                                = '1'
=======
   block                                = '1 2'
>>>>>>> first_running_model
   expansion_type                       = Anisotropic

   reference_temperature                = 23.0      # parameter to play
   temperature_unit                     = Celsius
   max_volumetric_expansion             = 1.125e-2  # parameter to play

   characteristic_time                  = 100       # parameter to play
   latency_time                         = 50        # parameter to play
   characteristic_activation_energy     = 5400.0
   latency_activation_energy            = 9400.0
   stress_latency_factor                = 1.0

<<<<<<< HEAD
   compressive_strength                 = 46.9e6
   compressive_stress_exponent          = 0.0
   expansion_stress_limit               = 8.0e6

   tensile_strength                     = 3.45e6
=======
   compressive_strength                 = 38.0e6
   compressive_stress_exponent          = 0.0
   expansion_stress_limit               = 8.0e6

   tensile_strength                     = 3.8e6
>>>>>>> first_running_model
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
<<<<<<< HEAD
   block                                = '1'
   temperature                          = T
   thermal_expansion_coeff              = 8.0e-6
   stress_free_temperature              = 23.0
=======
   block                                = '1 2'
   temperature                          = T
   thermal_expansion_coeff              = 8.0e-6
   stress_free_temperature              = 10.6
>>>>>>> first_running_model
   eigenstrain_name                     = thermal_expansion
 []

 [ASR_damage_concrete]
   type                                 = ConcreteASRMicrocrackingDamage
   residual_youngs_modulus_fraction     = 0.1
<<<<<<< HEAD
   block                                = '1'
=======
   block                                = '1 2'
>>>>>>> first_running_model
 []

 [./stress]
   type                                 = ComputeMultipleInelasticStress
<<<<<<< HEAD
   block                                = '1'
=======
   block                                = '1 2'
>>>>>>> first_running_model
   inelastic_models                     = 'creep'
   damage_model                         = ASR_damage_concrete
 [../]

 [truss]
   type                                 = LinearElasticTruss
   block                                = '3 4 5 6 7 8 9 10 11'
<<<<<<< HEAD
   youngs_modulus                       = 2.14e11
   temperature                          = T
   thermal_expansion_coeff              = 11.3e-6
   temperature_ref                      = 23.0
=======
   youngs_modulus                       = 2e11
   temperature                          = T
   thermal_expansion_coeff              = 11.3e-6
   temperature_ref                      = 10.6
>>>>>>> first_running_model
 []
[]

[UserObjects]
 [./visco_update]
   type = LinearViscoelasticityManager
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
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
<<<<<<< HEAD
   boundary = '5 6 7'
=======
   boundary = '4'
>>>>>>> first_running_model
   function = ramp_temp
 [../]
 [./rh]
   type = FunctionDirichletBC
   variable = rh
<<<<<<< HEAD
   boundary = '5 6 7'
=======
   boundary = '4'
>>>>>>> first_running_model
   function = ramp_humidity
 [../]
[]

[Postprocessors]
 [./ASR_strain]
   type = ElementAverageValue
   variable = ASR_vstrain
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_xx]
   type = ElementAverageValue
   variable = ASR_strain_xx
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_yy]
   type = ElementAverageValue
   variable = ASR_strain_yy
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./ASR_strain_zz]
   type = ElementAverageValue
   variable = ASR_strain_zz
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [ASR_ext]
   type = ElementAverageValue
   variable = ASR_ex
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 []

 [./vonmises]
   type = ElementAverageValue
   variable = vonmises_stress
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./vstrain]
   type = ElementAverageValue
   variable = volumetric_strain
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./strain_xx]
   type = ElementAverageValue
   variable = strain_xx
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./strain_yy]
   type = ElementAverageValue
   variable = strain_yy
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./strain_zz]
   type = ElementAverageValue
   variable = strain_zz
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./temp]
   type = ElementAverageValue
   variable = T
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./humidity]
   type = ElementAverageValue
   variable = rh
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]

 [./thermal_strain_xx]
   type = ElementAverageValue
   variable = thermal_strain_xx
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./thermal_strain_yy]
   type = ElementAverageValue
   variable = thermal_strain_yy
<<<<<<< HEAD
   block = '1'
=======
   block = '1 2'
>>>>>>> first_running_model
 [../]
 [./thermal_strain_zz]
   type = ElementAverageValue
   variable = thermal_strain_zz
<<<<<<< HEAD
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
   boundary = '6'
 [../]
 [./surfaceAvg_dome_x]
   type = SideAverageValue
   variable = disp_x
   boundary = '5'
 [../]
 [./surfaceAvg_dome_y]
=======
   block = '1 2'
 [../]

 [./surfaceAvg_x]
   type = SideAverageValue
   variable = disp_x
   boundary = '5 6'
 [../]
 [./surfaceAvg_y]
>>>>>>> first_running_model
   type = SideAverageValue
   variable = disp_y
   boundary = '5'
 [../]
<<<<<<< HEAD
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
=======
 [./surfaceAvg_z]
   type = SideAverageValue
   variable = disp_z
   boundary = '6'
>>>>>>> first_running_model
 [../]
[]

[Executioner]
<<<<<<< HEAD
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
=======
 type       = Transient
 # solve_type = 'NEWTON'
 # nl_max_its = 100
 # nl_abs_tol = 1.E-5
 # nl_rel_tol = 1E-3
 #
 # line_search = none
 # petsc_options_iname = '-pc_type'
 # petsc_options_value = 'lu'
 # petsc_options = '-snes_converged_reason'

 solve_type = 'PJFNK'
 line_search = none
 petsc_options = '-ksp_snes_ew'
 petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
 petsc_options_value = 'hypre boomeramg 201 cubic 0.7'
 start_time = 1209600 # 28 days
 dt = 86400 # 1 day
 automatic_scaling = true
 end_time = 21600000 # 250 days
 l_max_its  = 100
 l_tol      = 1e-3
 nl_max_its = 20
 nl_rel_tol = 1e-5
 nl_abs_tol = 1e-5
>>>>>>> first_running_model
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
