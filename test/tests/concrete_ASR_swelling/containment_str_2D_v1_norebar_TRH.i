[GlobalParams]
  displacements = 'disp_x disp_y'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
[]

[Mesh]
  # file = gold/TwoElement2DModel.e
  # construct_side_list_from_node_list = true
  # block 1 add face 2  left element
  # block 2 add face 1  right element
  #
  # nodeset 1 add curve 1
  # nodeset 2 add curve 2
  # nodeset 3 add curve 3
  # nodeset 4 add curve 4
  # nodeset 5 add vertex 1
  # nodeset 6 add vertex 2
  # nodeset 7 add vertex 3
  # nodeset 8 add vertex 4

  [./gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 2
    ny = 1
    xmax = 2
    ymax = 1
  []
  [./subdomains]
    type = SubdomainBoundingBoxGenerator
    input = gmg
    bottom_left = '0 1 1'
    block_id = 1
    top_right = '1 0 0'
    location = INSIDE
  []
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./concrete]
    strain = FINITE
    block = '0'
    add_variables = true
    # eigenstrain_names = 'asr_expansion thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./soil]
    strain = FINITE
    block = '1'
    add_variables = true
    # eigenstrain_names = 'asr_expansion thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./mc_int]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
  [./yield_fcn]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  [../]
[]

[AuxKernels]
  [./mc_int_auxk]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_internal_parameter
    variable = mc_int
    block = '1'
  [../]
  [./yield_fcn_auxk]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_yield_function
    variable = yield_fcn
    block = '1'
  [../]
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = 'left'
    # boundary = '2'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    # boundary = '3'
    value    = 0.0
  [../]
  [./y_disp_loading]
    type = FunctionDirichletBC
    variable = disp_y
    boundary = 'top'
    # boundary = '1'
    function = -1e-3*y*t
  [../]
[]

[Materials]
  [./elastic_stress]
    type = ComputeFiniteStrainElasticStress
    block = '0'
  [../]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 1e6
    block = '0'
  [../]

  [elastic_soil]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e11
    poissons_ratio = 0.3
    block = '1'
  []
  [./mc_soil_stress]
    type = ComputeMultiPlasticityStress
    block = '1'
    ep_plastic_tolerance = 1E-11
    plastic_models = mc
    max_NR_iterations = 1000
    debug_fspb = crash
  [../]
[]

[UserObjects]
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


[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type       = Transient
  start_time = 1209600 # 28 days
  dt = 604800 # 259200 # 3 day
  automatic_scaling = true
  end_time = 630720000 # 7300 days

  solve_type = 'PJFNK'
  nl_max_its = 20
  l_max_its = 100
  nl_abs_tol = 1e-5
  nl_rel_tol = 1e-3
  line_search = none
  # petsc_options = '-ksp_snes_ew'
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
[]

[Debug]
  show_var_residual_norms = true
[]
