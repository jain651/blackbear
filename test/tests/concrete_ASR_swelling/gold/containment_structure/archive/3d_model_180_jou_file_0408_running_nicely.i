reset
# unit m
cd "/Users/amitjain/projects/blackbear/test/tests/concrete_ASR_swelling/gold/containment_structure"
# {scale	=	6}
# {base_h	=	1.016*scale}
# {base_r	=	3.810*scale}
# {base_top_z	=	0.533*scale}
# {base_z	=	-base_h/2+base_top_z}
# {mid_top_z	=	7.315*scale}
# {mid_h	=	mid_top_z-base_top_z}
# {mid_ri	=	3.353*scale}
# {mid_ro	=	mid_ri+0.248*scale}
# {dome_ri	=	mid_ri}
# {dome_ro	=	dome_ri+0.178*scale}
# {conc_coarse	=	0.076*scale}
# {mat_thk	=	0.152*scale}
# {mat_r	=	6.2485*scale}
# {liner_thk1	=	0.00159*scale}
# {liner_thk2	=	0.00211*scale}
# {c		=	0.0508}
# {s_bot_grid	=	0.102*scale}
# {s_top_grid	=	0.152*scale}
# {s_top_rad_s	=	0.114*scale}
# {s_top_rad_r	=	3.476*scale}
# {top_cir_s1	=	0.152*scale}
# {top_cir_s2	=	0.229*scale}
# {h_shear_tie =	0.500*scale}
# {s_shear_tie =	0.114*scale}
# {dia_num4	=	0.0125}
# {mrdnl2_r 	=	mid_ri+0.04445*scale}
# {mrdnl5_r 	=	mrdnl2_r+0.121*scale}
# {mrdnl_s 	=	0.114*scale}
# {hoop1_r 	=	mrdnl2_r-dia_num4}
# {hoop3_r 	=	mrdnl2_r+dia_num4}
# {hoop4_r 	=	mrdnl5_r-dia_num4}
# {hoop6_r 	=	mrdnl5_r-dia_num4}
# {hoop_s 	=	0.114*scale}
# {seismic_ro 	=	mrdnl5_r+0.0254*scale}
# {seismic_ri 	=	seismic_ro-dia_num4}
# {seismic_th  =	(mid_h+base_h-2*c)/(0.5*(seismic_ro+seismic_ri))}
# {seismic_s   =	0.159*scale}
# {mrdnl_h 	=	(34*12+10)*0.0254*scale}
# {seismic_h 	=	(30*12+10)*0.0254*scale}
# {seismic_dr 	=	0.040*scale}
# {sismc_dm_th =	(seismic_h-mid_top_z)/(0.5*(seismic_ro+seismic_ri))}
# {hatch_r	=	0.508*scale}
# {lock_r	=	0.254*scale}
# {hatch_z	=	3.962*scale}
# {elem_sz	=	0.100*scale}
# {grnd_lvl	=	(mid_top_z + dome_ro)/3}
# {water_table	=	grnd_lvl-3}
# {soil_h	=	10/6*scale}
# {soil_r	=	10*scale}
# {tol 		= 	0.1}

# basemat rebars: bottom #6 rectangular grid
create vertex {-base_r+tol} {s_bot_grid/2} {base_top_z-base_h+c} 		# vertex 1
create vertex {0-tol} 	  {s_bot_grid/2} {base_top_z-base_h+c} 		# vertex 2
create curve vertex 1 2 							# curve 1
curve 1 copy move y {-s_bot_grid} repeat {37}
create curve arc radius {base_r-c-tol} center location {0} {0} {base_top_z-base_h+c} normal 0 0 1 start angle 0 stop angle 360
trim curve 1 AtIntersection curve 39 keepside vertex 2
trim curve 2 AtIntersection curve 39 keepside vertex 4
trim curve 3 AtIntersection curve 39 keepside vertex 6
trim curve 4 AtIntersection curve 39 keepside vertex 8
trim curve 5 AtIntersection curve 39 keepside vertex 10
trim curve 6 AtIntersection curve 39 keepside vertex 12
trim curve 7 AtIntersection curve 39 keepside vertex 14
trim curve 8 AtIntersection curve 39 keepside vertex 16
trim curve 9 AtIntersection curve 39 keepside vertex 18
trim curve 10 AtIntersection curve 39 keepside vertex 20
trim curve 11 AtIntersection curve 39 keepside vertex 22
trim curve 12 AtIntersection curve 39 keepside vertex 24
trim curve 13 AtIntersection curve 39 keepside vertex 26
trim curve 14 AtIntersection curve 39 keepside vertex 28
trim curve 15 AtIntersection curve 39 keepside vertex 30
trim curve 16 AtIntersection curve 39 keepside vertex 32
trim curve 17 AtIntersection curve 39 keepside vertex 34
trim curve 18 AtIntersection curve 39 keepside vertex 36
trim curve 19 AtIntersection curve 39 keepside vertex 38
trim curve 20 AtIntersection curve 39 keepside vertex 40
trim curve 21 AtIntersection curve 39 keepside vertex 42
trim curve 22 AtIntersection curve 39 keepside vertex 44
trim curve 23 AtIntersection curve 39 keepside vertex 46
trim curve 24 AtIntersection curve 39 keepside vertex 48
trim curve 25 AtIntersection curve 39 keepside vertex 50
trim curve 26 AtIntersection curve 39 keepside vertex 52
trim curve 27 AtIntersection curve 39 keepside vertex 54
trim curve 28 AtIntersection curve 39 keepside vertex 56
trim curve 29 AtIntersection curve 39 keepside vertex 58
trim curve 30 AtIntersection curve 39 keepside vertex 60
trim curve 31 AtIntersection curve 39 keepside vertex 62
trim curve 32 AtIntersection curve 39 keepside vertex 64
trim curve 33 AtIntersection curve 39 keepside vertex 66
trim curve 34 AtIntersection curve 39 keepside vertex 68
trim curve 35 AtIntersection curve 39 keepside vertex 70
trim curve 36 AtIntersection curve 39 keepside vertex 72
trim curve 37 AtIntersection curve 39 keepside vertex 74
trim curve 38 AtIntersection curve 39 keepside vertex 76
curve 40 to 77 copy rotate 90 about Z
curve 78 to 115 reflect x
curve 40 to 115 rotate 180 about Z

# basemat rebars: top #5 rectangular grid
create vertex {-base_r} {s_top_grid/2} {base_top_z-c} 		# vertex 230
create vertex {0} 	  {s_top_grid/2} {base_top_z-c} 		# vertex 231
create curve vertex 230 231 						# curve 116
curve 116 copy move y {-s_top_grid} repeat 25
curve 39 copy move z {base_h-2*c}					# curve 142
trim curve 116 AtIntersection curve 142 keepside vertex 231
trim curve 117 AtIntersection curve 142 keepside vertex 233
trim curve 118 AtIntersection curve 142 keepside vertex 235
trim curve 119 AtIntersection curve 142 keepside vertex 237
trim curve 120 AtIntersection curve 142 keepside vertex 239
trim curve 121 AtIntersection curve 142 keepside vertex 241
trim curve 122 AtIntersection curve 142 keepside vertex 243
trim curve 123 AtIntersection curve 142 keepside vertex 245
trim curve 124 AtIntersection curve 142 keepside vertex 247
trim curve 125 AtIntersection curve 142 keepside vertex 249
trim curve 126 AtIntersection curve 142 keepside vertex 251
trim curve 127 AtIntersection curve 142 keepside vertex 253
trim curve 128 AtIntersection curve 142 keepside vertex 255
trim curve 129 AtIntersection curve 142 keepside vertex 257
trim curve 130 AtIntersection curve 142 keepside vertex 259
trim curve 131 AtIntersection curve 142 keepside vertex 261
trim curve 132 AtIntersection curve 142 keepside vertex 263
trim curve 133 AtIntersection curve 142 keepside vertex 265
trim curve 134 AtIntersection curve 142 keepside vertex 267
trim curve 135 AtIntersection curve 142 keepside vertex 269
trim curve 136 AtIntersection curve 142 keepside vertex 271
trim curve 137 AtIntersection curve 142 keepside vertex 273
trim curve 138 AtIntersection curve 142 keepside vertex 275
trim curve 139 AtIntersection curve 142 keepside vertex 277
trim curve 140 AtIntersection curve 142 keepside vertex 279
trim curve 141 AtIntersection curve 142 keepside vertex 281
curve 143 to 168 copy rotate 90 about Z
curve 169 to 194 reflect x
curve 143 to 194 rotate 180 about Z

# basemat rebars: top #5 radial bars
create vertex {base_r-c-tol} {0} {base_top_z-c} 			# vertex 387
create vertex {0} 	     {0} {base_top_z-c} 			# vertex 388
create curve vertex 387 388						# curve 195
curve 195 copy rotate {s_top_rad_s/s_top_rad_r*180/3.14} about Z repeat 48

# basemat rebars: top #6 circumfrential bars
create curve arc radius {mid_ri-c-0*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-1*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-2*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-3*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-4*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-5*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-6*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-7*top_cir_s1} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-7*top_cir_s1-1*top_cir_s2} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-7*top_cir_s1-2*top_cir_s2} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-7*top_cir_s1-3*top_cir_s2} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {mid_ri-c-7*top_cir_s1-4*top_cir_s2} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {base_r-c-tol} center location {0} {0} {base_top_z-c} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {base_r-c-tol} center location {0} {0} {base_top_z-c-(base_h-2*c)/2} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {base_r-c-tol} center location {0} {0} {base_top_z-c-(base_h-2*c)} normal 0 0 1 start angle 0 stop angle 90

# basemat rebars: #3 shear tie bars
create vertex {mid_ri-c-0*top_cir_s1} {0} {base_top_z-c} 				# vertex 515
create vertex {mid_ri-c-0*top_cir_s1} {0} {base_top_z-c-(base_h-2*c)} 		# vertex 516
create curve vertex 515 516								# curve 259
curve 259 copy move x {-top_cir_s1} repeat 7
curve 266 copy move x {-top_cir_s2} repeat 4
curve 259 copy move x {-mid_ri+2*c}

# cylinder-basemat connection rebars: #4 shear tie bars
create vertex {mid_ri+2*c}  		 {0} {base_top_z+conc_coarse+h_shear_tie} 	# vertex 541
create vertex {mid_ri+2*c} 		 {0} {base_top_z+conc_coarse} 		# vertex 542
create vertex {mid_ri-c-5*top_cir_s1} {0} {base_top_z-base_h+c+tol)} 		# vertex 543
create vertex {mid_ri-c-7*top_cir_s1} {0} {base_top_z-base_h+c+tol)} 		# vertex 544
create curve vertex 541 542
create curve vertex 542 543
create curve vertex 543 544
# create curve polyline vertex 541 to 544						# curve 272 273 274
create vertex {base_r-2*c} {0} {base_top_z-c-tol}					# vertex 547
create vertex {mid_ri-c} {0} {base_top_z-c-tol}					# vertex 548
create curve vertex 547 548								# curve 275
curve 275 copy move z {-2*c}								# curve 276

# cylinder long rebars: hoops (layer 1, 3, 4, and 6) #4
create curve arc radius {hoop1_r} center location {0} {0} {base_top_z} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {hoop3_r} center location {0} {0} {base_top_z} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {hoop4_r} center location {0} {0} {base_top_z} normal 0 0 1 start angle 0 stop angle 90
create curve arc radius {hoop6_r} center location {0} {0} {base_top_z} normal 0 0 1 start angle 0 stop angle 90
curve 277 to 280 copy move z {hoop_s} repeat 59

# cylinder long rebars: meridional bars #4
create vertex {mrdnl2_r} {tol} {base_top_z-base_h+c} 			# vertex 1031
create vertex {mrdnl2_r-seismic_dr} {tol} {mid_top_z-c} 		# vertex 1032
create curve vertex 1031 1032						# curve 517
curve 517 copy move x {mrdnl5_r-mrdnl2_r}

# cylinder long rebars: Seismic bars #4
create vertex {(seismic_ro-3*tol)*cos(seismic_th/2)} 	{-(seismic_ro-3*tol)*sin(seismic_th/2)} 	{base_top_z-base_h+c+tol}		# vertex 1035
create vertex {(seismic_ro-3*tol)} 	   			{0} 					{0.5*(mid_top_z+base_top_z-base_h)}	# vertex 1036
create vertex {(seismic_ro-seismic_dr-3*tol)*cos(seismic_th/2)} 	{(seismic_ro-seismic_dr-3*tol)*sin(seismic_th/2)} 	{mid_top_z-c-tol}			# vertex 1037
#create vertex {seismic_ro*cos(seismic_th/2)} 	{-seismic_ro*sin(seismic_th/2)} 	{base_top_z-base_h+c}			# vertex 1035
#create vertex {seismic_ro-0.5*seismic_dr} 	   	{0} 					{0.5*(mid_top_z+base_top_z-base_h)}	# vertex 1036
#create vertex {(seismic_ro-seismic_dr)*cos(seismic_th/2)} 	{(seismic_ro-seismic_dr)*sin(seismic_th/2)} 	{mid_top_z-c}		# vertex 1037
create curve arc three vertex 1035 1036 1037 											# curve 519
create vertex {(seismic_ri-3*tol)*cos(seismic_th/2)} 		{(seismic_ri-3*tol)*sin(seismic_th/2)}		{base_top_z-base_h+c+tol}			# vertex 1038
create vertex {(seismic_ri-3*tol)} 			   		{0} 				 			{0.5*(mid_top_z+base_top_z-base_h)}	# vertex 1039
create vertex {(seismic_ri-seismic_dr-3*tol)*cos(seismic_th/2)} 	{-(seismic_ri-seismic_dr-3*tol)*sin(seismic_th/2)}	{mid_top_z-c-tol}			# vertex 1040
#create vertex {seismic_ri*cos(seismic_th/2)} 	{seismic_ri*sin(seismic_th/2)}	{base_top_z-base_h+c}			# vertex 1038
#create vertex {seismic_ri} 			   	{0} 				 	{0.5*(mid_top_z+base_top_z-base_h)}	# vertex 1039
#create vertex {(seismic_ri-seismic_dr)*cos(seismic_th/2)} 	{-(seismic_ri-seismic_dr)*sin(seismic_th/2)}	{mid_top_z-c}		# vertex 1040
create curve arc three vertex 1038 1039 1040												# curve 520

# dome rebars: continuation of meridional bars
create vertex {((dome_ri+mrdnl2_r-mid_ri-seismic_dr+tol)^2-(0.5*(mrdnl_h-mid_top_z))^2)^0.5} {0} {mid_top_z+0.5*(mrdnl_h-mid_top_z)} 	# vertex 1041
create vertex {((dome_ri+mrdnl2_r-mid_ri-seismic_dr+tol)^2-(mrdnl_h-mid_top_z)^2)^0.5} 	    {0} {mrdnl_h}		 		# vertex 1042
create vertex {0} 					  	 		    {0} {mid_top_z+dome_ri+mrdnl2_r-mid_ri} 			# vertex 1043
create curve arc three vertex 1032 1041 1042 												# curve 521
create vertex {((dome_ri+mrdnl5_r-mid_ri-seismic_dr)^2-(0.5*(mrdnl_h-mid_top_z))^2)^0.5} {0} {mid_top_z+0.5*(mrdnl_h-mid_top_z)} 	# vertex 1045
create vertex {((dome_ri+mrdnl5_r-mid_ri-seismic_dr)^2-(mrdnl_h-mid_top_z)^2)^0.5} 	    {0} {mrdnl_h}		 		# vertex 1046
create curve arc three vertex 1034 1045 1046 												# curve 542

# dome rebars: continuation of seismic bars
create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5-tol*3)*cos(sismc_dm_th+seismic_th/2)} 			{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5-tol*3)*sin(sismc_dm_th+seismic_th/2)} 		{seismic_h}					# vertex 1048
create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5-tol*3)*cos(sismc_dm_th/2+seismic_th/2)} 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5-tol*3)*sin(sismc_dm_th/2+seismic_th/2)} {mid_top_z+0.5*(seismic_h-mid_top_z)}	# vertex 1049
#create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5)*cos(sismc_dm_th+seismic_th/2)} 		{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5)*sin(sismc_dm_th+seismic_th/2)} 		{seismic_h}					# vertex 1048
#create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5)*cos(sismc_dm_th/2+seismic_th/2)} 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5)*sin(sismc_dm_th/2+seismic_th/2)} 	{mid_top_z+0.5*(seismic_h-mid_top_z)}	# vertex 1049
create curve arc three vertex 1037 1049 1048 																																		# curve 523
create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5-tol*3)*cos(-(sismc_dm_th+seismic_th/2))} 		{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5-tol*3)*sin(-(sismc_dm_th+seismic_th/2))} 		{seismic_h}					# vertex 1051
create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5-tol*3)*cos(-(sismc_dm_th/2+seismic_th/2))} 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5-tol*3)*sin(-(sismc_dm_th/2+seismic_th/2))}	{mid_top_z+0.5*(seismic_h-mid_top_z)}	# vertex 1052
#create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5)*cos(-(sismc_dm_th+seismic_th/2))} 		{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(seismic_h-mid_top_z)^2)^0.5)*sin(-(sismc_dm_th+seismic_th/2))} 		{seismic_h}					# vertex 1051
#create vertex 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5)*cos(-(sismc_dm_th/2+seismic_th/2))} 	{(((dome_ri+seismic_ri-mid_ri-seismic_dr)^2-(0.5*(seismic_h-mid_top_z))^2)^0.5)*sin(-(sismc_dm_th/2+seismic_th/2))}	{mid_top_z+0.5*(seismic_h-mid_top_z)}	# vertex 1052
create curve arc three vertex 1040 1052 1051 																																		# curve 524

# deleting addition rebars and free vertices
delete curve 39 142
delete Vertex 1036 1039 1041 1043 1045 1049 1052

# basemat rebars: #3 shear tie bars
curve 259 to 270 copy rotate {s_top_rad_s/s_top_rad_r*180/3.14} about Z repeat 48
# cylinder-basemat connection rebars: #4 shear tie bars
curve 272 to 276 copy rotate {s_shear_tie/((mid_ro+mid_ri)/2)*180/3.14} about Z repeat 48
# cylinder long rebars: meridional bars #4
curve 517 518 copy rotate {mrdnl_s/((mrdnl2_r+mrdnl5_r)/2)*180/3.14} about Z repeat 48
# cylinder long rebars: Seismic bars #4
curve 519 520 rotate {-seismic_th/2*180/3.14} about z
curve 519 copy rotate {seismic_s/(0.5*(seismic_ro+seismic_ri))*180/3.14} about Z repeat 83
curve 520 copy rotate {seismic_s/(0.5*(seismic_ro+seismic_ri))*180/3.14} about Z repeat 83
# dome rebars: continuation of meridional bars
curve 521 522 copy rotate {mrdnl_s/((mrdnl2_r+mrdnl5_r)/2)*180/3.14} about Z repeat 48
# dome rebars: continuation of seismic bars
curve 523 rotate {-seismic_th/2*180/3.14 + 90+0.17773} about z
curve 524 rotate {seismic_th/2*180/3.14-1.043565} about z
curve 523 copy rotate {-seismic_s/(0.5*(seismic_ro+seismic_ri))*180/3.14} about Z repeat 49
curve 524 copy rotate {seismic_s/(0.5*(seismic_ro+seismic_ri))*180/3.14} about Z repeat 49

# Dummy surfaces
create surface rectangle width 50 height 200 yplane
create surface rectangle width 200 height 50 xplane
move surface 1 x 25
move surface 2 y 25 x {tol}
split curve 519 520 1437 to 1484 1520 to 1567 524 1734 to 1746 1748 to 1760 crossing surface 1
split curve 	     1554 to 1602 1471 to 1519 523 1699 to 1711 1783 to 1795 crossing surface 2
delete curve with x_coord < 0
delete curve with y_coord < 0
split curve 1880 to 1904 1973 to 1999 crossing surface 2
delete curve with x_coord < 0
delete surface 1 2
Curve all copy reflect Y

color curve 41 to 115 2303 to 2376 grey 					# #6 mat: bottom grid
color curve 144 to 194 2377 to 2426 grey					# #5 mat: top grid
color curve 195 to 242 2427 to 2474 red					# #5 mat: top radial bars
color curve 244 to 258 2475 to 2489 blue					# #6 mat: top circumfrential bars
color curve 259 to 271 525 to 1088 2490 to 2502 2750 to 3313 green		# #3 mat: shear stirrups
color curve 272 to 276 1101 to 1335 2503 to 2507 3314 to 3548 yellow	# #4 cylinear-mat connection bars
color curve 277 to 516 2508 to 2747 red					# #4 cylinear: long bars (layer 1 3 4 6)
color curve 517 518 1341 to 1434 1603 to 1696 2748 2749 3549 to 3736 green	# #4 cylinear-dome: meridional bars (layer 2 5)
color curve 1712 to 1782 1810 to 2302 3737 to 3998 pink			# #4 cylinear-dome: seismic bars (layer 7 8)

move curve 3815 3911 to 3945 3972 to 3985 x {tol} y {-tol}
delete curve 1878 2275  41
block 2 add curve all

# block 3 curve 41 to 115 2303 to 2376 					# #6 mat: bottom grid
# block 4 curve 144 to 194 2377 to 2426					# #5 mat: top grid
# block 5 curve 195 to 242 2427 to 2474 					# #5 mat: top radial bars
# block 6 curve 244 to 258 2475 to 2489 					# #6 mat: top circumfrential bars
# block 7 curve 259 to 271 525 to 1088 2490 to 2502 2750 to 3313		# #3 mat: shear stirrups
# block 8 curve 272 to 276 1101 to 1335 2503 to 2507 3314 to 3548		# #4 cylinear-mat connection bars
# block 9 curve 277 to 516 2508 to 2747 					# #4 cylinear: long bars (layer 1 3 4 6)
# block 10 curve 517 518 1341 to 1434 1603 to 1696 2748 2749 3549 to 3736	# #4 cylinear-dome: meridional bars (layer 2 5)
# block 11 curve 1712 to 1782 1810 to 2302 3737 to 3999			# #4 cylinear-dome: seismic bars (layer 7 8)

# concrete base
create Cylinder height {base_h} radius {base_r}
move Volume 3 z {base_z} include_merged
# concrete cylinder
create frustum height {mid_h} radius {mid_ro} top {dome_ro}
create Cylinder height {mid_h} radius {mid_ri}
subtract Volume 5 from volume 4
move Volume 4 z {base_top_z+mid_h/2}
# concrete sphere
create Sphere radius {dome_ro} inner radius {dome_ri}
webcut Volume 6 with plane zplane offset 0 noimprint nomerge
delete Volume 7
move Volume 6 z {mid_top_z} include_merged
# concrete coarse on base
create Cylinder height {conc_coarse} radius {mid_ri}
move Volume 8 z {base_top_z+conc_coarse/2} include_merged
# concrete mat below base
create Cylinder height {mat_thk} radius {mat_r}
move Volume 9 z {base_top_z-base_h-mat_thk/2} include_merged
# cylinder representing soil
create Cylinder height {soil_h} radius {soil_r}
move Volume 10 z {base_top_z-base_h-mat_thk-soil_h/2} include_merged
webcut Volume 3 4 6 8 9 10 with plane xplane offset 0 noimprint nomerge
delete volume 11 to 16

delete volume 8
imprint volume 3 4 6 9
merge volume 3 4 6 9

block 1 add volume 3 4 6 8 9
block 12 add volume 10







# volume all size auto factor 3 # 0.25
mesh volume all
mesh curve all


sideset 1 add surface 76 68 32 40 41 52
sideset 2 add surface 76 68 32 40 41 52
sideset 3 add surface 79 71
sideset 4 add surface 70 87 34 84 44 55
sideset 5 add surface 71
sideset 6 add surface 77

## Temperature and RH BC
sideset 10 add surface 86 43 53			# inner surfaces (no flux BC)
nodeset 11 add surface 70 87 34 84 44 55		# outer surface for above ground BC
nodeset 11 remove node with z_coord < {grnd_lvl}
nodeset 12 add surface 70 87 34 84 44 55		# outer surface for underground BC first 2" depth (unscaled dimension)
nodeset 12 remove node with z_coord > {grnd_lvl}
nodeset 12 remove node with z_coord < {grnd_lvl-2*0.0254/6*scale}
nodeset 13 add surface 70 87 34 84 44 55		# outer surface for underground BC between 2" and 4" depth (unscaled dimension)
nodeset 13 remove node with z_coord > {grnd_lvl-2*0.0254/6*scale}
nodeset 13 remove node with z_coord < {grnd_lvl-5*0.0254/6*scale}
nodeset 14 add surface 70 87 34 84 44 55		# outer surface for underground BC between 4" and 8" depth (unscaled dimension)
nodeset 14 remove node with z_coord > {grnd_lvl-4*0.0254/6*scale}
nodeset 14 remove node with z_coord < {grnd_lvl-8*0.0254/6*scale}
nodeset 15 add surface 70 87 34 84 44 55		# outer surface for underground BC between 8" and 20" depth (unscaled dimension)
nodeset 15 remove node with z_coord > {grnd_lvl-8*0.0254/6*scale}
nodeset 15 remove node with z_coord < {grnd_lvl-20*0.0254/6*scale}
nodeset 16 add surface 70 87 34 84 44 55		# outer surface for underground BC between 20" depth and water table (unscaled dimension)
nodeset 16 remove node with z_coord > {grnd_lvl-20*0.0254/6*scale}
nodeset 16 remove node with z_coord < {water_table}
nodeset 17 add surface 70 87 34 84 44 55		# outer surface for underground BC below water table (unscaled dimension)
nodeset 17 remove node with z_coord > {water_table}
## Measurement locations
nodeset 30 add surface 70 87 34 84 44 55		# outer surface for whole structure
sideset 31 add surface 55				# dome outer surface
sideset 32 add surface 44				# cylinder outer surface
sideset 33 add surface 34 84				# base outer surface
sideset 34 add surface 70 87				# base mat outer surface
sideset 35 add surface 71		 		# surface on base mat to calcualte slip
sideset 36 add surface 77		 		# surface on soil to calcualte slip

export mesh 'ContainmentVessel3D_180.e' overwrite
