[GlobalParams]
  displacements = 'disp_x disp_y'
  volumetric_locking_correction = true
[]

# [Problem]
#   coord_type = RZ
# []

[Mesh]
  file = gold/containment_structure/FullContainment2D_XY_no_contact.e
  construct_side_list_from_node_list = true
  # block 1 surface 1 2 8 10      # concrete structure
  # block 3 curve 1               # #6 mat: bottom grid
  # block 4 curve 2               # #5 mat: top grid
  # block 5 curve 3               # #5 mat: top radial bars
  # block 7 curve 4 to 16         # #3 mat: shear stirrups
  # block 8 curve 17 to 19 20 21  # #4 cylinear-mat connection bars
  # block 10 curve 22 23 25 26    # #4 cylinear-dome: meridional bars (layer 2 5)
  # block 11 curve 24 27          # #4 cylinear-dome: seismic bars (layer 7 8)
  # block 12 surface 11           # soil
  #
  # ## Displacement BC
  # nodeset 1 add curve 57    # disp_y zero
  # nodeset 2 add curve 57    # disp_x zero
  # ## Temperature and RH BC
  # nodeset 10 add curve 41 48 35 29 61 54 58         # zero flux BC
  # nodeset 11 add curve 49 33 31 63 56 65            # outer surface for above ground BC
  # nodeset 11 remove node with z_coord < {grnd_lvl}
  # nodeset 12 add curve 49 33 31 63 56 65            # outer surface for underground BC first 2" depth (unscaled dimension)
  # nodeset 12 remove node with z_coord < {grnd_lvl-2*0.0254/6*scale}
  # nodeset 12 remove node with z_coord < {grnd_lvl-2*0.0254/6*scale}
  # nodeset 13 add curve 49 33 31 63 56 65            # outer surface for underground BC between 2" and 4" depth (unscaled dimension)
  # nodeset 13 remove node with z_coord > {grnd_lvl-2*0.0254/6*scale}
  # nodeset 13 remove node with z_coord < {grnd_lvl-5*0.0254/6*scale}
  # nodeset 14 add curve 49 33 31 63 56 65            # outer surface for underground BC between 4" and 8" depth (unscaled dimension)
  # nodeset 14 remove node with z_coord > {grnd_lvl-4*0.0254/6*scale}
  # nodeset 14 remove node with z_coord < {grnd_lvl-8*0.0254/6*scale}
  # nodeset 15 add curve 49 33 31 63 56 65            # outer surface for underground BC between 8" and 20" depth (unscaled dimension)
  # nodeset 15 remove node with z_coord > {grnd_lvl-8*0.0254/6*scale}
  # nodeset 15 remove node with Z_coord < {grnd_lvl-20*0.0254/6*scale}
  # nodeset 16 add curve 49 33 31 63 56 65            # outer surface for underground BC between 20" depth and water table (unscaled dimension)
  # nodeset 16 remove node with z_coord > {grnd_lvl-20*0.0254/6*scale}
  # nodeset 16 remove node with z_coord < {water_table}
  # nodeset 17 add curve 49 33 31 63 56 65            # outer surface for underground BC below water table (unscaled dimension)
  # nodeset 17 remove node with z_coord > {water_table}
  # ## Soil pressure BC
  # nodeset 20 add curve 63 65                        # surface for vertical pressure from soil above
  # nodeset 20 remove node with z_coord > {grnd_lvl}
  # nodeset 21 add curve 31 56                        # surface for horizontal pressure from soil on the side
  # nodeset 21 remove node with z_coord > {grnd_lvl}
  # ## Measurement locations
  # nodeset 30 add curve 49 33 31 63 56 65            # outer surface for whole structure
  # nodeset 31 add curve 49                           # dome outer surface
  # nodeset 32 add curve 33                           # cylinder outer surface
  # nodeset 33 add curve 31                           # base outer surface
  # nodeset 34 add curve 56 64                        # base mat outer surface
[]


[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./concrete]
    block = '1'
    strain = FINITE
    add_variables = true
    eigenstrain_names = 'asr_expansion thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  # [./soil]
  #   block = '12'
  #   strain = FINITE
  #   add_variables = true
  #   save_in = 'resid_x resid_y'
  # [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./btm_grid]
    block = '3'
    truss = true
    area = area_no6
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./top_grid]
    block = '4'
    truss = true
    area = area_no5
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./top_radial]
    block = '5'
    truss = true
    area = area_no5
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./shear_stirrups]
    block = '7'
    truss = true
    area = area_no3
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./cyl_mat_connection]
    block = '8'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./cyl_dome_meridional]
    block = '10'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
  [./cyl_mat_seismic]
    block = '11'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_y'
    save_in = 'resid_x resid_y'
  [../]
[]

[Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
  primary_block = '1'
  secondary_block = '3 4 5 7 8 10 11'
  primary_variable = 'disp_x disp_y'
  displacements = 'disp_x disp_y'
  penalty = 1e12
  formulation = penalty
[]

# [DiracKernels]
#   [./no4_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     disp_component = disp_x
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 129e-6
#     points = '20.3722 3.1472 0.  20.3722 3.8312 0.  20.3722 4.5152 0.  20.3722 5.1992 0.  20.3722 5.8832 0.  20.3722 6.5672 0.  20.3722 7.2512 0.  20.3722 7.9352 0.  20.3722 8.6192 0.  20.3722 9.3032 0.  20.3722 9.9872 0.  20.3722 10.6712 0.  20.3722 11.3552 0.  20.3722 12.0392 0.  20.3722 12.7232 0.  20.3722 13.4072 0.  20.3722 14.0912 0.  20.3722 14.7752 0.  20.3722 15.4592 0.  20.3722 16.1432 0.  20.3722 16.8272 0.  20.3722 17.5112 0.  20.3722 18.1952 0.  20.3722 18.8792 0.  20.3722 19.5632 0.  20.3722 20.2472 0.  20.3722 20.9312 0.  20.3722 21.6152 0.  20.3722 22.2992 0.  20.3722 22.9832 0.  20.3722 23.6672 0.  20.3722 24.3512 0.  20.3722 25.0352 0.  20.3722 25.7192 0.  20.3722 26.4032 0.  20.3722 27.0872 0.  20.3722 27.7712 0.  20.3722 28.4552 0.  20.3722 29.1392 0.  20.3722 29.8232 0.  20.3722 30.5072 0.  20.3722 31.1912 0.  20.3722 31.8752 0.  20.3722 32.5592 0.  20.3722 33.2432 0.  20.3722 33.9272 0.  20.3722 34.6112 0.  20.3722 35.2952 0.  20.3722 35.9792 0.  20.3722 36.6632 0.  20.3722 37.3472 0.  20.3722 38.0312 0.  20.3722 38.7152 0.  20.3722 39.3992 0.  20.3722 40.0832 0.  20.3972 3.1472 0.  20.3972 3.8312 0.  20.3972 4.5152 0.  20.3972 5.1992 0.  20.3972 5.8832 0.  20.3972 6.5672 0.  20.3972 7.2512 0.  20.3972 7.9352 0.  20.3972 8.6192 0.  20.3972 9.3032 0.  20.3972 9.9872 0.  20.3972 10.6712 0.  20.3972 11.3552 0.  20.3972 12.0392 0.  20.3972 12.7232 0.  20.3972 13.4072 0.  20.3972 14.0912 0.  20.3972 14.7752 0.  20.3972 15.4592 0.  20.3972 16.1432 0.  20.3972 16.8272 0.  20.3972 17.5112 0.  20.3972 18.1952 0.  20.3972 18.8792 0.  20.3972 19.5632 0.  20.3972 20.2472 0.  20.3972 20.9312 0.  20.3972 21.6152 0.  20.3972 22.2992 0.  20.3972 22.9832 0.  20.3972 23.6672 0.  20.3972 24.3512 0.  20.3972 25.0352 0.  20.3972 25.7192 0.  20.3972 26.4032 0.  20.3972 27.0872 0.  20.3972 27.7712 0.  20.3972 28.4552 0.  20.3972 29.1392 0.  20.3972 29.8232 0.  20.3972 30.5072 0.  20.3972 31.1912 0.  20.3972 31.8752 0.  20.3972 32.5592 0.  20.3972 33.2432 0.  20.3972 33.9272 0.  20.3972 34.6112 0.  20.3972 35.2952 0.  20.3972 35.9792 0.  20.3972 36.6632 0.  20.3972 37.3472 0.  20.3972 38.0312 0.  20.3972 38.7152 0.  20.3972 39.3992 0.  20.3972 40.0832 0.  21.0728 3.1472 0.  21.0728 3.8312 0.  21.0728 4.5152 0.  21.0728 5.1992 0.  21.0728 5.8832 0.  21.0728 6.5672 0.  21.0728 7.2512 0.  21.0728 7.9352 0.  21.0728 8.6192 0.  21.0728 9.3032 0.  21.0728 9.9872 0.  21.0728 10.6712 0.  21.0728 11.3552 0.  21.0728 12.0392 0.  21.0728 12.7232 0.  21.0728 13.4072 0.  21.0728 14.0912 0.  21.0728 14.7752 0.  21.0728 15.4592 0.  21.0728 16.1432 0.  21.0728 16.8272 0.  21.0728 17.5112 0.  21.0728 18.1952 0.  21.0728 18.8792 0.  21.0728 19.5632 0.  21.0728 20.2472 0.  21.0728 20.9312 0.  21.0728 21.6152 0.  21.0728 22.2992 0.  21.0728 22.9832 0.  21.0728 23.6672 0.  21.0728 24.3512 0.  21.0728 25.0352 0.  21.0728 25.7192 0.  21.0728 26.4032 0.  21.0728 27.0872 0.  21.0728 27.7712 0.  21.0728 28.4552 0.  21.0728 29.1392 0.  21.0728 29.8232 0.  21.0728 30.5072 0.  21.0728 31.1912 0.  21.0728 31.8752 0.  21.0728 32.5592 0.  21.0728 33.2432 0.  21.0728 33.9272 0.  21.0728 34.6112 0.  21.0728 35.2952 0.  21.0728 35.9792 0.  21.0728 36.6632 0.  21.0728 37.3472 0.  21.0728 38.0312 0.  21.0728 38.7152 0.  21.0728 39.3992 0.  21.0728 40.0832 0.  21.1236 3.1472 0.  21.1236 3.8312 0.  21.1236 4.5152 0.  21.1236 5.1992 0.  21.1236 5.8832 0.  21.1236 6.5672 0.  21.1236 7.2512 0.  21.1236 7.9352 0.  21.1236 8.6192 0.  21.1236 9.3032 0.  21.1236 9.9872 0.  21.1236 10.6712 0.  21.1236 11.3552 0.  21.1236 12.0392 0.  21.1236 12.7232 0.  21.1236 13.4072 0.  21.1236 14.0912 0.  21.1236 14.7752 0.  21.1236 15.4592 0.  21.1236 16.1432 0.  21.1236 16.8272 0.  21.1236 17.5112 0.  21.1236 18.1952 0.  21.1236 18.8792 0.  21.1236 19.5632 0.  21.1236 20.2472 0.  21.1236 20.9312 0.  21.1236 21.6152 0.  21.1236 22.2992 0.  21.1236 22.9832 0.  21.1236 23.6672 0.  21.1236 24.3512 0.  21.1236 25.0352 0.  21.1236 25.7192 0.  21.1236 26.4032 0.  21.1236 27.0872 0.  21.1236 27.7712 0.  21.1236 28.4552 0.  21.1236 29.1392 0.  21.1236 29.8232 0.  21.1236 30.5072 0.  21.1236 31.1912 0.  21.1236 31.8752 0.  21.1236 32.5592 0.  21.1236 33.2432 0.  21.1236 33.9272 0.  21.1236 34.6112 0.  21.1236 35.2952 0.  21.1236 35.9792 0.  21.1236 36.6632 0.  21.1236 37.3472 0.  21.1236 38.0312 0.  21.1236 38.7152 0.  21.1236 39.3992 0.  21.1236 40.0832 0.  21.2506 3.1472 0.  21.2506 3.8312 0.  21.2506 4.5152 0.  21.2506 5.1992 0.  21.2506 5.8832 0.  21.2506 6.5672 0.  21.2506 7.2512 0.  21.2506 7.9352 0.  21.2506 8.6192 0.  21.2506 9.3032 0.  21.2506 9.9872 0.  21.2506 10.6712 0.  21.2506 11.3552 0.  21.2506 12.0392 0.  21.2506 12.7232 0.  21.2506 13.4072 0.  21.2506 14.0912 0.  21.2506 14.7752 0.  21.2506 15.4592 0.  21.2506 16.1432 0.  21.2506 16.8272 0.  21.2506 17.5112 0.  21.2506 18.1952 0.  21.2506 18.8792 0.  21.2506 19.5632 0.  21.2506 20.2472 0.  21.2506 20.9312 0.  21.2506 21.6152 0.  21.2506 22.2992 0.  21.2506 22.9832 0.  21.2506 23.6672 0.  21.2506 24.3512 0.  21.2506 25.0352 0.  21.2506 25.7192 0.  21.2506 26.4032 0.  21.2506 27.0872 0.  21.2506 27.7712 0.  21.2506 28.4552 0.  21.2506 29.1392 0.  21.2506 29.8232 0.  21.2506 30.5072 0.  21.2506 31.1912 0.  21.2506 31.8752 0.  21.2506 32.5592 0.  21.2506 33.2432 0.  21.2506 33.9272 0.  21.2506 34.6112 0.  21.2506 35.2952 0.  21.2506 35.9792 0.  21.2506 36.6632 0.  21.2506 37.3472 0.  21.2506 38.0312 0.  21.2506 38.7152 0.  21.2506 39.3992 0.  21.2506 40.0832 0.'
#   [../]
#   [./no5_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     disp_component = disp_x
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 200e-6
#     points = '22.8092 3.1472 0.  21.8972 3.1472 0.  20.9852 3.1472 0.  20.0732 3.1472 0.  19.1612 3.1472 0.  18.2492 3.1472 0.  17.3372 3.1472 0.  16.4252 3.1472 0.  15.5132 3.1472 0.  14.6012 3.1472 0.  13.6892 3.1472 0.  12.7772 3.1472 0.  11.8652 3.1472 0.  10.9532 3.1472 0.  10.0412 3.1472 0.  9.1292 3.1472 0.  8.2172 3.1472 0.  7.3052 3.1472 0.  6.3932 3.1472 0.  5.4812 3.1472 0.  4.5692 3.1472 0.  3.6572 3.1472 0.  2.7452 3.1472 0.  1.8332 3.1472 0.  0.9212 3.1472 0.  22.8092 -2.9488 0.  21.8972 -2.9488 0.  20.9852 -2.9488 0.  20.0732 -2.9488 0.  19.1612 -2.9488 0.  18.2492 -2.9488 0.  17.3372 -2.9488 0.  16.4252 -2.9488 0.  15.5132 -2.9488 0.  14.6012 -2.9488 0.  13.6892 -2.9488 0.  12.7772 -2.9488 0.  11.8652 -2.9488 0.  10.9532 -2.9488 0.  10.0412 -2.9488 0.  9.1292 -2.9488 0.  8.2172 -2.9488 0.  7.3052 -2.9488 0.  6.3932 -2.9488 0.  5.4812 -2.9488 0.  4.5692 -2.9488 0.  3.6572 -2.9488 0.  2.7452 -2.9488 0.  1.8332 -2.9488 0.  0.9212 -2.9488 0.'
#   [../]
#   [./no6_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     disp_component = disp_x
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 284e-6
#     points = '22.8092 3.1472 0.  22.8092 0.15 0.  22.8092 -2.9488 0.  20.0672 3.1472 0.  19.1552 3.1472 0.  18.2432 3.1472 0.  17.3312 3.1472 0.  16.4192 3.1472 0.  15.5072 3.1472 0.  14.5952 3.1472 0.  13.6832 3.1472 0.  12.3092 3.1472 0.  10.9352 3.1472 0.  09.5612 3.1472 0.  08.1872 3.1472 0.'
#   [../]
# []

# [Contact]
#   [./leftright]
#     primary = '4'
#     secondary = '5'
#     model = frictionless
#     formulation = kinematic
#     penalty = 1e+12
#     normalize_penalty = true
#     normal_smoothing_distance = 0.1
#     # friction_coefficient = '0.25'
#   [../]
# []


[Variables]
  [./T]
    order = FIRST
    family = LAGRANGE
    initial_condition = 30.0
    block = '1 3 4 5 7 8 10 11'
  [../]
  [./rh]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.6
    block = '1'
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
    block = '3 4 5 7 8 10 11'
  [../]
  [./heat_conduction]
    type = HeatConduction
    variable = T
    diffusion_coefficient = 53.0
    block = '3 4 5 7 8 10 11'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
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
    block = '1'
  [../]
  [./thermal_capacity]
    order = CONSTANT
    family = Monomial
    block = '1'
  [../]
  [./moisture_capacity]
    order = CONSTANT
    family = Monomial
    block = '1'
  [../]
  [./humidity_diffusivity]
    order = CONSTANT
    family = Monomial
    block = '1'
  [../]
  [./water_content]
    order = CONSTANT
    family = Monomial
    block = '1'
  [../]
  [./water_hydrated]
    order = CONSTANT
    family = Monomial
    block = '1'
  [../]
  [damage_index]
    order = CONSTANT
    family = MONOMIAL
    block = '1'
  []
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

  # [./penetration]
  # [../]
  # [./inc_slip_x]
  # [../]
  # [./inc_slip_y]
  # [../]
  # [./accum_slip_x]
  # [../]
  # [./accum_slip_y]
  # [../]
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
    block = '8 10 11'
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
    block = '3'
    variable = area_no6
    value = 284e-6
    execute_on = 'initial timestep_begin'
  [../]
  # [./axial_stress]
  #   type = MaterialRealAux
  #   block = '3 4 5 7 8 10 11'
  #   variable = axial_stress
  #   property = axial_stress
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

  # [./penetration]
  #   type = PenetrationAux
  #   variable = penetration
  #   boundary = 5
  #   paired_boundary = 4
  # [../]
  # [./incslip_x]
  #   type = PenetrationAux
  #   variable = inc_slip_x
  #   quantity = incremental_slip_x
  #   boundary = 5
  #   paired_boundary = 4
  # [../]
  # [./incslip_y]
  #   type = PenetrationAux
  #   variable = inc_slip_y
  #   quantity = incremental_slip_y
  #   boundary = 5
  #   paired_boundary = 4
  # [../]
  # [./accum_slip_x]
  #   type = AccumulateAux
  #   variable = accum_slip_x
  #   accumulate_from_variable = inc_slip_x
  #   execute_on = timestep_end
  # [../]
  # [./accum_slip_y]
  #   type = AccumulateAux
  #   variable = accum_slip_y
  #   accumulate_from_variable = inc_slip_y
  #   execute_on = timestep_end
  # [../]
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
    variable = disp_x
    boundary = '1'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = '2'
    value    = 0.0
  [../]

  [./x_disp_loading]
    type = FunctionDirichletBC
    variable = disp_x
    boundary = '30 '
    function = -1e-4*x*t
  [../]

  # [./pressure_soil_z]
  #   type = Pressure
  #   variable = disp_y
  #   component = '2'
  #   boundary = '20'
  #   function = '-2.65*9.81*(21.692-z)' # rho_soil*g*h
  # [../]
  # [./pressure_soil_x]
  #   type = Pressure
  #   variable = disp_x
  #   component = '0'
  #   boundary = '21'
  #   function = '-0.3*2.65*9.81*(21.692-z)' # alpha*rho_soil*g*h
  # [../]

  [./T_inside]
    type = DirichletBC
    variable = T
    boundary = '10'
    value = 26.6
  [../]
  [./RH_inside_zeroFlux]
    type = NeumannBC
    variable = rh
    boundary = '10'
    value = 0
  [../]
  [./T_air]
    type = RepeatingDirichletBC
    variable = T
    boundary = '11'
    repetition_period = 31536000 # 365 days
    function = T_air
  [../]
  [./rh_air]
    type = RepeatingDirichletBC
    variable = rh
    boundary = '11'
    repetition_period = 31536000 # 365 days
    function = rh_air
  [../]
  # [./T_bet_grnd_2in]
  #   type = RepeatingDirichletBC
  #   variable = T
  #   boundary = '12'
  #   repetition_period = 31536000 # 365 days
  #   function = T_bet_grnd_2in
  # [../]
  # [./rh_bet_grnd_2in]
  #   type = RepeatingDirichletBC
  #   variable = rh
  #   boundary = '12'
  #   repetition_period = 31536000 # 365 days
  #   function = rh_bet_grnd_2in
  # [../]
  # [./T_bet_2in_4in]
  #   type = RepeatingDirichletBC
  #   variable = T
  #   boundary = '13'
  #   repetition_period = 31536000 # 365 days
  #   function = T_bet_2in_4in
  # [../]
  # [./rh_bet_2in_4in]
  #   type = RepeatingDirichletBC
  #   variable = rh
  #   boundary = '13'
  #   repetition_period = 31536000 # 365 days
  #   function = rh_bet_2in_4in
  # [../]
  # [./T_bet_4in_8in]
  #   type = RepeatingDirichletBC
  #   variable = T
  #   boundary = '14'
  #   repetition_period = 31536000 # 365 days
  #   function = T_bet_4in_8in
  # [../]
  # [./rh_bet_4in_8in]
  #   type = RepeatingDirichletBC
  #   variable = rh
  #   boundary = '14'
  #   repetition_period = 31536000 # 365 days
  #   function = rh_bet_4in_8in
  # [../]
  [./T_bet_8in_20in]
    type = RepeatingDirichletBC
    variable = T
    boundary = '15'
    repetition_period = 31536000 # 365 days
    function = T_bet_8in_20in
  [../]
  [./rh_bet_8in_20in]
    type = RepeatingDirichletBC
    variable = rh
    boundary = '15'
    repetition_period = 31536000 # 365 days
    function = rh_bet_8in_20in
  [../]
  [./T_below_20in]
    type = RepeatingDirichletBC
    variable = T
    boundary = '16 17'
    repetition_period = 31536000 # 365 days
    function = T_below_20in
  [../]
  [./rh_below_20in]
    type = RepeatingDirichletBC
    variable = rh
    boundary = '16'
    repetition_period = 31536000 # 365 days
    function = rh_below_20in
  [../]
  [./rh_below_water_table]
    type = FunctionDirichletBC
    variable = rh
    boundary = '17'
    function = '1.0'
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
    max_its                              = 100
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
  # [./density_conc]
  #  type                                 = GenericFunctionMaterial
  #  block                                = '1'
  #  prop_names                           = density
  #  prop_values                          = 2231.0 # kg/m3
  # [../]

  [truss]
    type                                 = LinearElasticTruss
    block                                = '3 4 5 7 8 10 11'
    youngs_modulus                       = 2.14e11
    temperature                          = T
    thermal_expansion_coeff              = 11.3e-6
    temperature_ref                      = 23.0
  []
  # [./density_steel]
  #   type                                = GenericFunctionMaterial
  #   block                               = '3 4 5 7 8 10 11'
  #   prop_names                          = density
  #   prop_values                         = 7850.0 # kg/m3
  # [../]

  # [elastic_soil]
  #   type = ComputeIsotropicElasticityTensor
  #   youngs_modulus = 2e11
  #   poissons_ratio = 0.3
  #   block = '12'
  # []
  # [elastic_soil]
  #   type = ComputeElasticityTensor
  #   fill_method = symmetric_isotropic
  #   C_ijkl = '0 1E7'
  #   block = '12'
  # []
  # [./mc_soil_stress]
  #   type = ComputeMultiPlasticityStress
  #   block = '12'
  #   ep_plastic_tolerance = 1E-11
  #   plastic_models = mc
  #   max_NR_iterations = 1000
  #   debug_fspb = crash
  # [../]
  # [./density_soil]
  #   type                                = GenericFunctionMaterial
  #   block                               = '12'
  #   prop_names                          = density
  #   prop_values                         = 2690.0 # kg/m3
  # [../]
[]

[UserObjects]
  [./visco_update]
    type = LinearViscoelasticityManager
    block = '1'
    # viscoelastic_model = logcreep
    viscoelastic_model = burgers
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

# [Postprocessors]
#   [./ASR_strain]
#     type = ElementAverageValue
#     variable = ASR_vstrain
#     block = '1'
#   [../]
#   [./ASR_strain_xx]
#     type = ElementAverageValue
#     variable = ASR_strain_xx
#     block = '1'
#   [../]
#   [./ASR_strain_yy]
#     type = ElementAverageValue
#     variable = ASR_strain_yy
#     block = '1'
#   [../]
#   [./ASR_strain_zz]
#     type = ElementAverageValue
#     variable = ASR_strain_zz
#     block = '1'
#   [../]
#   [ASR_ext]
#     type = ElementAverageValue
#     variable = ASR_ex
#     block = '1'
#   []
#
#   [./vonmises]
#     type = ElementAverageValue
#     variable = vonmises_stress
#     block = '1'
#   [../]
#
#   [./vstrain]
#     type = ElementAverageValue
#     variable = volumetric_strain
#     block = '1'
#   [../]
#
#   [./strain_xx]
#     type = ElementAverageValue
#     variable = strain_xx
#     block = '1'
#   [../]
#   [./strain_yy]
#     type = ElementAverageValue
#     variable = strain_yy
#     block = '1'
#   [../]
#   [./strain_zz]
#     type = ElementAverageValue
#     variable = strain_zz
#     block = '1'
#   [../]
#
#   [./temp]
#     type = ElementAverageValue
#     variable = T
#     block = '1'
#   [../]
#   [./humidity]
#     type = ElementAverageValue
#     variable = rh
#     block = '1'
#   [../]
#
#   [./thermal_strain_xx]
#     type = ElementAverageValue
#     variable = thermal_strain_xx
#     block = '1'
#   [../]
#   [./thermal_strain_yy]
#     type = ElementAverageValue
#     variable = thermal_strain_yy
#     block = '1'
#   [../]
#   [./thermal_strain_zz]
#     type = ElementAverageValue
#     variable = thermal_strain_zz
#     block = '1'
#   [../]
#
#   [./surfaceAvg_cyl_x]
#     type = SideAverageValue
#     variable = 'disp_x'
#     boundary = '32'
#   [../]
#   [./surfaceAvg_cyl_z]
#     type = SideAverageValue
#     variable = 'disp_y'
#     boundary = '32'
#   [../]
#   [./surfaceAvg_dome_x]
#     type = SideAverageValue
#     variable = disp_x
#     boundary = '31'
#   [../]
#   [./surfaceAvg_dome_z]
#     type = SideAverageValue
#     variable = 'disp_y'
#     boundary = '31'
#   [../]
#   [./cyl_tang_x] # 500 mm gauge length (not the arc length)
#     type = AveragePointSeparation
#     displacements = 'disp_x'
#     first_point = '2.59     2.43     4.470935'
#     last_point = '2.26     2.743     4.470935'
#   [../]
#   [./cyl_tang_y] # 500 mm gauge length (not the arc length)
#     type = AveragePointSeparation
#     displacements = 'disp_y'
#     first_point = '2.59     2.43     4.470935'
#     last_point = '2.26     2.743     4.470935'
#   [../]
#   [./dome_tang_x]# 500 mm gauge length (not the arc length)
#     type = AveragePointSeparation
#     displacements = 'disp_x'
#     first_point = '2.374 1.924 9.0805'# basesd on hand calculation
#     last_point = '1.924 2.374 9.0805'
#   [../]
#   [./dome_tang_y]# 500 mm gauge length (not the arc length)
#     type = AveragePointSeparation
#     displacements = 'disp_y'
#     first_point = '2.374 1.924 9.0805'# basesd on hand calculation
#     last_point = '1.924 2.374 9.0805'
#   [../]
# []

[Preconditioning]
  active = SMP
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
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  petsc_options = '-snes_converged_reason'

  # working solver conditions
  # solve_type = 'NEWTON'
  # nl_max_its = 100
  # l_max_its = 100
  # nl_abs_tol = 1.E-5
  # nl_rel_tol = 1E-3
  # line_search = none
  # petsc_options = '-ksp_snes_ew'
  # petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -snes_ls -pc_hypre_boomeramg_strong_threshold'
  # petsc_options_value = 'hypre boomeramg 201 cubic 0.7'


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
