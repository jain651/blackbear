[Mesh]
  file = gold/AxiSymm_trial_model.e
  construct_side_list_from_node_list = true
  # block 1 surface 1
  # block 2 curve 5 to 8
  #
  # nodeset 1 add curve 1		# top
  # nodeset 2 add curve 2		# left
  # nodeset 3 add curve 3		# bot
  # nodeset 4 add curve 4		# right
[]

[GlobalParams]
  displacements = 'disp_x disp_z'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    block = '1'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./rebar]
    block = '2'
    truss = true
    area = area_no6
    displacements = 'disp_x disp_z'
    generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz'
    # save_in = 'resid_r resid_z'
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

[AuxVariables]
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

[AuxKernels]
  # [./resid_x]
  # [../]
  # [./resid_y]
  # [../]
  # [./resid_z]
  # [../]
  [./strain_xx]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_xy]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_xy
    index_i = 0
    index_j = 1
  [../]
  [./strain_xz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_xz
    index_i = 0
    index_j = 2
  [../]
  [./strain_yy]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
  [../]
  [./strain_yz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_yz
    index_i = 1
    index_j = 2
  [../]
  [./strain_zz]
    type = RankTwoAux
    block = '1'
    rank_two_tensor = elastic_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
  [./area_no6]
    type = ConstantAux
    block = '2'
    variable = area_no6
    value = 284e-6
    execute_on = 'initial timestep_begin'
  [../]
  [./axial_stress]
    type = MaterialRealAux
    block = '2'
    variable = axial_stress
    property = axial_stress
  [../]
[]

[DiracKernels]
  [./hoop_reinforcement]
    type = HoopReinforcement
    hoop_strain = strain_yy
    yield_strength = 550e6
    elastic_modulus = 2e14
    area = 284e-6
    variable = disp_x
    points = '0.55 -0.075 0
              0.55 +0.075 0
              0.95 -0.075 0
              0.95 +0.075 0'
  [../]
[]

[BCs]
  [./symmetry_x]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = '4'
  [../]
  [./roller_z]
    type = DirichletBC
    variable = disp_z
    value = 0
    boundary = '3'
  [../]
  [./top_load]
    type = FunctionDirichletBC
    variable = disp_z
    function = -0.001*t
    boundary = '1'
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1e10
    poissons_ratio = 0.3
    block = '1'
  [../]
  [./_elastic_strain]
    type = ComputeFiniteStrainElasticStress
    block = '1'
  [../]
  [truss]
    type                                 = LinearElasticTruss
    block                                = '2'
    youngs_modulus                       = 2.14e11
    temperature                          = temperature
    thermal_expansion_coeff              = 11.3e-6
    temperature_ref                      = 23.0
  []
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  line_search = 'none'

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10
  nl_max_its = 15

  l_tol = 1e-6
  l_max_its = 50

  start_time = 0.0
  end_time = 1
  dt = 0.1
[]

[Postprocessors]
  [./center_temperature]
    type = AxisymmetricCenterlineAverageValue
    variable = temperature
    boundary = '4'
  [../]
  [./rebar_sxx]
    type = ElementIntegralMaterialProperty
    mat_prop = axial_stress
    block = '2'
  [../]
[]

[Outputs]
  csv = true
  perf_graph = true
  [./Exo]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]
