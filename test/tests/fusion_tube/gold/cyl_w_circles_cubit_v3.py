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
box = [0] * 12
t = r[0]/2
domain_yhi = 3
dr = 0.04
circle_mesh_size = r[0]/2
circle_count = 0

for i in range(len(circle_data)):
        if(circle_data[i][1] < domain_yhi):
            cubit.cmd('create surface circle radius '+str(circle_data[i][3]+dr)+' zplane ')
            cubit.cmd('move Surface '+str(cubit.get_last_id('surface'))+' location '+str(circle_data[i][0])+' '+str(circle_data[i][1])+' '+str(circle_data[i][2]))
            circle_count = circle_count + 1
            if((circle_data[i][0]+circle_data[i][3])>x[1]):
                x[1] = circle_data[i][0]+circle_data[i][3]
            if((circle_data[i][0]-circle_data[i][3])<x[0]):
                x[0] = circle_data[i][0]-circle_data[i][3]
            if((circle_data[i][1]+circle_data[i][3])>y[1]):
                y[1] = circle_data[i][1]+circle_data[i][3]
            if((circle_data[i][1]-circle_data[i][3])<y[0]):
                y[0] = circle_data[i][1]-circle_data[i][3]

# box = cubit.get_total_bounding_box("surface",all)
cubit.cmd('create surface rectangle width '+str(x[1]-x[0]+2*t)+' height '+str(y[1]-y[0]+2*t)+' zplane ')
cubit.cmd('create surface rectangle width '+str(x[1]-x[0])+' height '+str(y[1]-y[0])+' zplane ')
cubit.cmd('subtract volume '+str(cubit.get_last_id('volume'))+' from volume '+str(cubit.get_last_id('volume')-1))
cubit.cmd('move Volume '+str(cubit.get_last_id('volume')-1)+' x '+str(0.5*(x[1]+x[0]))+' y '+str(0.5*(y[1]+y[0]))+' include_merged ')
cubit.cmd('block 3 add surface '+str(cubit.get_last_id('surface')))
cubit.cmd('surface '+str(cubit.get_last_id('surface'))+' size '+str(t))
cubit.cmd('nodeset 4 add curve '+str(cubit.get_last_id('curve')-3)+' to '+str(cubit.get_last_id('curve')))

surfaceID = [0]*(circle_count+1)
volumeID = [0]*(circle_count+1)
surfaceID[-1] = cubit.get_last_id('surface')
volumeID[-1] = cubit.get_last_id('volume')-1

for i in range(circle_count):
        volumeID[i] = i+1

for i in range(circle_count+1):
    for j in range (i+1,circle_count+1):
        cubit.cmd('Remove overlap volume '+str(volumeID[i])+' '+str(volumeID[j])+' modify volume '+str(volumeID[i]))
        surfaceID[i] = cubit.get_last_id('surface')

nodeset_peri = 10
for i in range(circle_count):
    cubit.cmd('nodeset 1 add curve all in surface '+str(surfaceID[i]))
    cubit.cmd('nodeset '+str(nodeset_peri)+' add curve all in surface '+str(surfaceID[i]))
    nodeset_peri = nodeset_peri+1
    cubit.cmd('surface '+str(surfaceID[i])+' Scheme circle ')
    cubit.cmd('surface '+str(surfaceID[i])+' size '+str(circle_mesh_size))
    bb = cubit.get_bounding_box("surface",surfaceID[i])
    if(bb[2]<2*(r[0]+dr)):
        cubit.cmd('color volume '+str(volumeID[i])+' red')
        cubit.cmd('block 1 add surface '+str(surfaceID[i]))
    else:
        cubit.cmd('color volume '+str(volumeID[i])+' blue')
        cubit.cmd('block 2 add surface '+str(surfaceID[i]))

cubit.cmd('nodeset 2 add curve all in surface '+str(surfaceID[-3])+' '+str(surfaceID[-2]))
cubit.cmd('mesh surface all')
cubit.cmd('export mesh "/Users/amitjain/projects/blackbear/test/tests/fusion_tube/gold/fusion_tube_v3.e" dimension 2 overwrite')
