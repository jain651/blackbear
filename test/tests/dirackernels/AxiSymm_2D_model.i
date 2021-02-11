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
  displacements = 'disp_r disp_z'
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
    displacements = 'disp_r disp_z'
    # save_in = 'resid_r resid_z'
  [../]
[]

[Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
  primary_block = '1'
  secondary_block = '2'
  primary_variable = 'disp_r disp_z'
  displacements = 'disp_r disp_z'
  penalty = 1e12
  formulation = penalty
[]

[AuxVariables]
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

[DiracKernels]
  [./point1]
    type = ConstantPointSource
    variable = disp_r
    point = '0.55 -0.075'
    value = -2.5 # P = 10
  [../]
[]

[AuxKernels]
  # [./resid_r]
  # [../]
  # [./resid_z]
  # [../]

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

[BCs]
  [./symmetry_x]
    type = DirichletBC
    variable = disp_r
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
