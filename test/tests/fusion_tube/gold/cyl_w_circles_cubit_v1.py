import os
import numpy as np
from itertools import islice
import cubit
cubit.reset()

lammps_file = '/Users/amitjain/projects/lammps_1/myfiles/pour_flow_2d_sml_v1_out.59500'
with open(lammps_file) as lines:
    num_circles = np.genfromtxt(islice(lines, 3, 4))
    domain_data = np.genfromtxt(islice(lines, 1, 4))
    circle_data = np.genfromtxt(islice(lines, 1, (1+num_circles)))

r = [0.5, 1]
x = [0, 0]
y = [0, 0]
z = 0
t = r[0]
domain_yhi = 3
dr = 0.02
circle_mesh_size = r[1]
cir_peri_nodeset_start_id = 10

for i in range(len(circle_data)):
        if(circle_data[i][1] < domain_yhi):
            cubit.cmd('create surface circle radius '+str(circle_data[i][3]+dr)+' zplane ')
            cubit.cmd('move Surface '+str(cubit.get_last_id('surface'))+' location '+str(circle_data[i][0])+' '+str(circle_data[i][1])+' '+str(circle_data[i][2]))
            cubit.cmd('surface '+str(cubit.get_last_id('surface'))+' Scheme circle ')
            cubit.cmd('surface '+str(cubit.get_last_id('surface'))+' size '+str(circle_mesh_size))
            cubit.cmd('nodeset 1 add curve '+str(cubit.get_last_id('curve')))
            cubit.cmd('nodeset '+str(cir_peri_nodeset_start_id)+' add curve '+str(cubit.get_last_id('curve')))
            cir_peri_nodeset_start_id = cir_peri_nodeset_start_id + 1
            if(circle_data[i][3] == r[0]):
                cubit.cmd('color volume '+str(cubit.get_last_id('surface'))+' blue')
                cubit.cmd('block 1 add  surface '+str(cubit.get_last_id('surface')))
            else:
                cubit.cmd('color volume '+str(cubit.get_last_id('surface'))+' red')
                cubit.cmd('block 2 add surface '+str(cubit.get_last_id('surface')))
            # defining bounding box of these spheres
            if((circle_data[i][0]+circle_data[i][3])>x[1]):
                x[1] = circle_data[i][0]+circle_data[i][3]
            if((circle_data[i][0]-circle_data[i][3])<x[0]):
                x[0] = circle_data[i][0]-circle_data[i][3]
            if((circle_data[i][1]+circle_data[i][3])>y[1]):
                y[1] = circle_data[i][1]+circle_data[i][3]
            if((circle_data[i][1]-circle_data[i][3])<y[0]):
                y[0] = circle_data[i][1]-circle_data[i][3]

cubit.cmd('mesh surface all')
cubit.cmd('nodeset 2 add surface '+str(cubit.get_last_id('surface'))+' '+str(cubit.get_last_id('surface')-1))
# cubit.cmd('nodeset 2 add node with y_coord > '+str(y[1]-r[1]*1.5))

cubit.cmd('create surface rectangle width '+str(x[1]-x[0]+2*t)+' height '+str(y[1]-y[0]+2*t)+' zplane ')
cubit.cmd('create surface rectangle width '+str(x[1]-x[0])+' height '+str(y[1]-y[0])+' zplane ')
cubit.cmd('subtract volume '+str(cubit.get_last_id('volume'))+' from volume '+str(cubit.get_last_id('volume')-1))
cubit.cmd('move Volume '+str(cubit.get_last_id('volume')-1)+' x '+str(0.5*(x[1]+x[0]))+' y '+str(0.5*(y[1]+y[0]))+' include_merged ')
cubit.cmd('block 3 add surface '+str(cubit.get_last_id('surface')))
cubit.cmd('surface '+str(cubit.get_last_id('surface'))+' size '+str(t))
cubit.cmd('mesh surface all')
cubit.cmd('refine surface '+str(cubit.get_last_id('surface'))+' numsplit 2 bias 1.0 depth 1 smooth')
cubit.cmd('nodeset 4 add curve '+str(cubit.get_last_id('curve')-3)+' to '+str(cubit.get_last_id('curve')))

# cubit.cmd('nodeset 3 add curve '+str(cubit.get_last_id('curve')-9))
# cubit.cmd('nodeset 3 add node 431 263 385 217 49 135 30')

cubit.cmd('export mesh "/Users/amitjain/projects/blackbear/test/tests/fusion_tube/gold/fusion_tube_v1.e" dimension 2 overwrite')
