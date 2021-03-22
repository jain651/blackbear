[GlobalParams]
  displacements = 'disp_x disp_z'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
[]


[Mesh]
  file = gold/containment_structure/FullScale2DContainmentVessel.e
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
  # nodeset 1 add curve 57    # disp_z zero
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
  [./mc_int]
    order = CONSTANT
    family = MONOMIAL
    block = '12'
  [../]
  [./yield_fcn]
    order = CONSTANT
    family = MONOMIAL
    block = '12'
  [../]
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
    save_in = 'resid_x resid_z'
  [../]
  [./soil]
    block = '12'
    strain = FINITE
    add_variables = true
    save_in = 'resid_x resid_z'
  [../]
[]

[Modules/TensorMechanics/LineElementMaster]
  [./btm_grid]
    block = '3'
    truss = true
    area = area_no6
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./top_grid]
    block = '4'
    truss = true
    area = area_no5
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./top_radial]
    block = '5'
    truss = true
    area = area_no5
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./shear_stirrups]
    block = '7'
    truss = true
    area = area_no3
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./cyl_mat_connection]
    block = '8'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./cyl_dome_meridional]
    block = '10'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
  [./cyl_mat_seismic]
    block = '11'
    truss = true
    area = area_no4
    displacements = 'disp_x disp_z'
    save_in = 'resid_x resid_z'
  [../]
[]

[Constraints/EqualValueEmbeddedConstraint/EqualValueEmbeddedConstraintAction]
  primary_block = '1'
  secondary_block = '3 4 5 7 8 10 11'
  primary_variable = 'disp_x disp_z'
  displacements = 'disp_x disp_z'
  penalty = 1e12
  formulation = penalty
[]

# [DiracKernels]
#   [./no4_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     hoop_strain = strain_zz
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 129e-6
#     points = '20.3722 0. 3.1472  20.3722 0. 3.8312  20.3722 0. 4.5152  20.3722 0. 5.1992  20.3722 0. 5.8832  20.3722 0. 6.5672  20.3722 0. 7.2512  20.3722 0. 7.9352  20.3722 0. 8.6192  20.3722 0. 9.3032  20.3722 0. 9.9872  20.3722 0. 10.6712  20.3722 0. 11.3552  20.3722 0. 12.0392  20.3722 0. 12.7232  20.3722 0. 13.4072  20.3722 0. 14.0912  20.3722 0. 14.7752  20.3722 0. 15.4592  20.3722 0. 16.1432  20.3722 0. 16.8272  20.3722 0. 17.5112  20.3722 0. 18.1952  20.3722 0. 18.8792  20.3722 0. 19.5632  20.3722 0. 20.2472  20.3722 0. 20.9312  20.3722 0. 21.6152  20.3722 0. 22.2992  20.3722 0. 22.9832  20.3722 0. 23.6672  20.3722 0. 24.3512  20.3722 0. 25.0352  20.3722 0. 25.7192  20.3722 0. 26.4032  20.3722 0. 27.0872  20.3722 0. 27.7712  20.3722 0. 28.4552  20.3722 0. 29.1392  20.3722 0. 29.8232  20.3722 0. 30.5072  20.3722 0. 31.1912  20.3722 0. 31.8752  20.3722 0. 32.5592  20.3722 0. 33.2432  20.3722 0. 33.9272  20.3722 0. 34.6112  20.3722 0. 35.2952  20.3722 0. 35.9792  20.3722 0. 36.6632  20.3722 0. 37.3472  20.3722 0. 38.0312  20.3722 0. 38.7152  20.3722 0. 39.3992  20.3722 0. 40.0832  20.3972 0. 3.1472  20.3972 0. 3.8312  20.3972 0. 4.5152  20.3972 0. 5.1992  20.3972 0. 5.8832  20.3972 0. 6.5672  20.3972 0. 7.2512  20.3972 0. 7.9352  20.3972 0. 8.6192  20.3972 0. 9.3032  20.3972 0. 9.9872  20.3972 0. 10.6712  20.3972 0. 11.3552  20.3972 0. 12.0392  20.3972 0. 12.7232  20.3972 0. 13.4072  20.3972 0. 14.0912  20.3972 0. 14.7752  20.3972 0. 15.4592  20.3972 0. 16.1432  20.3972 0. 16.8272  20.3972 0. 17.5112  20.3972 0. 18.1952  20.3972 0. 18.8792  20.3972 0. 19.5632  20.3972 0. 20.2472  20.3972 0. 20.9312  20.3972 0. 21.6152  20.3972 0. 22.2992  20.3972 0. 22.9832  20.3972 0. 23.6672  20.3972 0. 24.3512  20.3972 0. 25.0352  20.3972 0. 25.7192  20.3972 0. 26.4032  20.3972 0. 27.0872  20.3972 0. 27.7712  20.3972 0. 28.4552  20.3972 0. 29.1392  20.3972 0. 29.8232  20.3972 0. 30.5072  20.3972 0. 31.1912  20.3972 0. 31.8752  20.3972 0. 32.5592  20.3972 0. 33.2432  20.3972 0. 33.9272  20.3972 0. 34.6112  20.3972 0. 35.2952  20.3972 0. 35.9792  20.3972 0. 36.6632  20.3972 0. 37.3472  20.3972 0. 38.0312  20.3972 0. 38.7152  20.3972 0. 39.3992  20.3972 0. 40.0832  21.0728 0. 3.1472  21.0728 0. 3.8312  21.0728 0. 4.5152  21.0728 0. 5.1992  21.0728 0. 5.8832  21.0728 0. 6.5672  21.0728 0. 7.2512  21.0728 0. 7.9352  21.0728 0. 8.6192  21.0728 0. 9.3032  21.0728 0. 9.9872  21.0728 0. 10.6712  21.0728 0. 11.3552  21.0728 0. 12.0392  21.0728 0. 12.7232  21.0728 0. 13.4072  21.0728 0. 14.0912  21.0728 0. 14.7752  21.0728 0. 15.4592  21.0728 0. 16.1432  21.0728 0. 16.8272  21.0728 0. 17.5112  21.0728 0. 18.1952  21.0728 0. 18.8792  21.0728 0. 19.5632  21.0728 0. 20.2472  21.0728 0. 20.9312  21.0728 0. 21.6152  21.0728 0. 22.2992  21.0728 0. 22.9832  21.0728 0. 23.6672  21.0728 0. 24.3512  21.0728 0. 25.0352  21.0728 0. 25.7192  21.0728 0. 26.4032  21.0728 0. 27.0872  21.0728 0. 27.7712  21.0728 0. 28.4552  21.0728 0. 29.1392  21.0728 0. 29.8232  21.0728 0. 30.5072  21.0728 0. 31.1912  21.0728 0. 31.8752  21.0728 0. 32.5592  21.0728 0. 33.2432  21.0728 0. 33.9272  21.0728 0. 34.6112  21.0728 0. 35.2952  21.0728 0. 35.9792  21.0728 0. 36.6632  21.0728 0. 37.3472  21.0728 0. 38.0312  21.0728 0. 38.7152  21.0728 0. 39.3992  21.0728 0. 40.0832  21.1236 0. 3.1472  21.1236 0. 3.8312  21.1236 0. 4.5152  21.1236 0. 5.1992  21.1236 0. 5.8832  21.1236 0. 6.5672  21.1236 0. 7.2512  21.1236 0. 7.9352  21.1236 0. 8.6192  21.1236 0. 9.3032  21.1236 0. 9.9872  21.1236 0. 10.6712  21.1236 0. 11.3552  21.1236 0. 12.0392  21.1236 0. 12.7232  21.1236 0. 13.4072  21.1236 0. 14.0912  21.1236 0. 14.7752  21.1236 0. 15.4592  21.1236 0. 16.1432  21.1236 0. 16.8272  21.1236 0. 17.5112  21.1236 0. 18.1952  21.1236 0. 18.8792  21.1236 0. 19.5632  21.1236 0. 20.2472  21.1236 0. 20.9312  21.1236 0. 21.6152  21.1236 0. 22.2992  21.1236 0. 22.9832  21.1236 0. 23.6672  21.1236 0. 24.3512  21.1236 0. 25.0352  21.1236 0. 25.7192  21.1236 0. 26.4032  21.1236 0. 27.0872  21.1236 0. 27.7712  21.1236 0. 28.4552  21.1236 0. 29.1392  21.1236 0. 29.8232  21.1236 0. 30.5072  21.1236 0. 31.1912  21.1236 0. 31.8752  21.1236 0. 32.5592  21.1236 0. 33.2432  21.1236 0. 33.9272  21.1236 0. 34.6112  21.1236 0. 35.2952  21.1236 0. 35.9792  21.1236 0. 36.6632  21.1236 0. 37.3472  21.1236 0. 38.0312  21.1236 0. 38.7152  21.1236 0. 39.3992  21.1236 0. 40.0832  21.2506 0. 3.1472  21.2506 0. 3.8312  21.2506 0. 4.5152  21.2506 0. 5.1992  21.2506 0. 5.8832  21.2506 0. 6.5672  21.2506 0. 7.2512  21.2506 0. 7.9352  21.2506 0. 8.6192  21.2506 0. 9.3032  21.2506 0. 9.9872  21.2506 0. 10.6712  21.2506 0. 11.3552  21.2506 0. 12.0392  21.2506 0. 12.7232  21.2506 0. 13.4072  21.2506 0. 14.0912  21.2506 0. 14.7752  21.2506 0. 15.4592  21.2506 0. 16.1432  21.2506 0. 16.8272  21.2506 0. 17.5112  21.2506 0. 18.1952  21.2506 0. 18.8792  21.2506 0. 19.5632  21.2506 0. 20.2472  21.2506 0. 20.9312  21.2506 0. 21.6152  21.2506 0. 22.2992  21.2506 0. 22.9832  21.2506 0. 23.6672  21.2506 0. 24.3512  21.2506 0. 25.0352  21.2506 0. 25.7192  21.2506 0. 26.4032  21.2506 0. 27.0872  21.2506 0. 27.7712  21.2506 0. 28.4552  21.2506 0. 29.1392  21.2506 0. 29.8232  21.2506 0. 30.5072  21.2506 0. 31.1912  21.2506 0. 31.8752  21.2506 0. 32.5592  21.2506 0. 33.2432  21.2506 0. 33.9272  21.2506 0. 34.6112  21.2506 0. 35.2952  21.2506 0. 35.9792  21.2506 0. 36.6632  21.2506 0. 37.3472  21.2506 0. 38.0312  21.2506 0. 38.7152  21.2506 0. 39.3992  21.2506 0. 40.0832'
#   [../]
#   [./no5_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     hoop_strain = strain_zz
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 200e-6
#     points = '22.8092 0. 3.1472  21.8972 0. 3.1472  20.9852 0. 3.1472  20.0732 0. 3.1472  19.1612 0. 3.1472  18.2492 0. 3.1472  17.3372 0. 3.1472  16.4252 0. 3.1472  15.5132 0. 3.1472  14.6012 0. 3.1472  13.6892 0. 3.1472  12.7772 0. 3.1472  11.8652 0. 3.1472  10.9532 0. 3.1472  10.0412 0. 3.1472  9.1292 0. 3.1472  8.2172 0. 3.1472  7.3052 0. 3.1472  6.3932 0. 3.1472  5.4812 0. 3.1472  4.5692 0. 3.1472  3.6572 0. 3.1472  2.7452 0. 3.1472  1.8332 0. 3.1472  0.9212 0. 3.1472  22.8092 0. -2.9488  21.8972 0. -2.9488  20.9852 0. -2.9488  20.0732 0. -2.9488  19.1612 0. -2.9488  18.2492 0. -2.9488  17.3372 0. -2.9488  16.4252 0. -2.9488  15.5132 0. -2.9488  14.6012 0. -2.9488  13.6892 0. -2.9488  12.7772 0. -2.9488  11.8652 0. -2.9488  10.9532 0. -2.9488  10.0412 0. -2.9488  9.1292 0. -2.9488  8.2172 0. -2.9488  7.3052 0. -2.9488  6.3932 0. -2.9488  5.4812 0. -2.9488  4.5692 0. -2.9488  3.6572 0. -2.9488  2.7452 0. -2.9488  1.8332 0. -2.9488  0.9212 0. -2.9488'
#   [../]
#   [./no6_bars]
#     type = HoopReinforcement
#     variable = disp_x
#     hoop_strain = strain_zz
#     yield_strength = 500e6
#     youngs_modulus = 2.14e11
#     area = 284e-6
#     points = '22.8092 0. 3.1472  22.8092 0. 0.15  22.8092 0. -2.9488  20.0672 0. 3.1472  19.1552 0. 3.1472  18.2432 0. 3.1472  17.3312 0. 3.1472  16.4192 0. 3.1472  15.5072 0. 3.1472  14.5952 0. 3.1472  13.6832 0. 3.1472  12.3092 0. 3.1472  10.9352 0. 3.1472  09.5612 0. 3.1472  08.1872 0. 3.1472'
#   [../]
# []

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
  [./axial_stress]
    type = MaterialRealAux
    block = '3 4 5 7 8 10 11'
    variable = axial_stress
    property = axial_stress
  [../]

  [./mc_int_auxk]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_internal_parameter
    variable = mc_int
    block = '12'
  [../]
  [./yield_fcn_auxk]
    type = MaterialStdVectorAux
    index = 0
    property = plastic_yield_function
    variable = yield_fcn
    block = '12'
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
  [./density_conc]
   type                                 = GenericFunctionMaterial
   block                                = '1'
   prop_names                           = density
   prop_values                          = 2231.0 # kg/m3
  [../]

  [truss]
    type                                 = LinearElasticTruss
    block                                = '3 4 5 7 8 10 11'
    youngs_modulus                       = 2.14e11
    temperature                          = T
    thermal_expansion_coeff              = 11.3e-6
    temperature_ref                      = 23.0
  []
  [./density_steel]
    type                                = GenericFunctionMaterial
    block                               = '3 4 5 7 8 10 11'
    prop_names                          = density
    prop_values                         = 7850.0 # kg/m3
  [../]

  [elastic_soil]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2e11
    poissons_ratio = 0.3
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
  [./density_soil]
    type                                = GenericFunctionMaterial
    block                               = '12'
    prop_names                          = density
    prop_values                         = 2690.0 # kg/m3
  [../]
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

[BCs]
  [./z_disp]
    type = DirichletBC
    variable = disp_z
    boundary = '2'
    value    = 0.0
  [../]
  # [./pressure_soil_z]
  #   type = Pressure
  #   variable = disp_z
  #   component = 3
  #   boundary = '20'
  #   function = '-1-z'
  # [../]
  # [./pressure_soil_x]
  #   type = Pressure
  #   variable = disp_x
  #   component = 0
  #   boundary = '21'
  #   function = '-1-z'
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
