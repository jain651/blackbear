import os
import numpy as np
from itertools import islice
import cubit
import math
cubit.reset()

def are_neighbours(bbi, bbj, r):
    xi = 0.5*(bbi[0]+bbi[1])
    xj = 0.5*(bbj[0]+bbj[1])
    yi = 0.5*(bbi[3]+bbi[4])
    yj = 0.5*(bbj[3]+bbj[4])
    dist = math.sqrt((xj-xi)**2 + (yj-yi)**2)
    if (dist < 3.*r[1]):
        return 1
    else:
        return 0

lammps_file = '/Users/amitjain/projects/lammps_1/myfiles/pour_flow_2d_sml_v3_out.1400000'
with open(lammps_file) as lines:
    num_circles = np.genfromtxt(islice(lines, 3, 4))
    domain_data = np.genfromtxt(islice(lines, 1, 4))
    circle_data = np.genfromtxt(islice(lines, 1, (1+num_circles)))

r = [0.25, 0.5]
x = [0, 0]
y = [0, 0]
z = 0
t = r[0]/2
domain_ymax = 50
dr = 0.01
circle_mesh_size = r[0]/3
circle_count = 0
fix_circles = 10

for i in range(len(circle_data)):
        if(circle_data[i][1] < domain_ymax):
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

volumeID = [0]*(circle_count+1)
volumeID[-1] = cubit.get_last_id('volume')-1

for i in range(circle_count):
    volumeID[i] = i+1

for i in range(circle_count+1):
    for j in range (i+1,circle_count+1):
        bbi = cubit.get_bounding_box("volume",volumeID[i])
        bbj = cubit.get_bounding_box("volume",volumeID[j])
        if(are_neighbours(bbi, bbj, r) or j==circle_count):
            cubit.cmd('Remove overlap volume '+str(volumeID[i])+' '+str(volumeID[j])+' modify volume '+str(volumeID[i]))

# nodeset_peri = 10
for i in range(circle_count):
    cubit.cmd('nodeset 1 add curve all in volume '+str(volumeID[i]))
    # cubit.cmd('nodeset '+str(nodeset_peri)+' add curve all in volume '+str(volumeID[i]))
    # nodeset_peri = nodeset_peri+1
    cubit.cmd('surface all in volume '+str(volumeID[i])+' Scheme circle ')
    cubit.cmd('surface all in volume '+str(volumeID[i])+' size '+str(circle_mesh_size))
    bb = cubit.get_bounding_box("volume",volumeID[i])
    if(bb[2]>2*r[1]):
        cubit.cmd('color volume '+str(volumeID[i])+' blue')
        cubit.cmd('block 2 add surface all in volume '+str(volumeID[i]))
    else:
        cubit.cmd('color volume '+str(volumeID[i])+' red')
        cubit.cmd('block 1 add surface all in volume '+str(volumeID[i]))

for i in range(fix_circles):
    cubit.cmd('nodeset 2 add curve all in surface all in volume '+str(volumeID[-(2+i)]))

cubit.cmd('mesh surface all in volume all')
cubit.cmd('export mesh "/Users/amitjain/projects/blackbear/test/tests/fusion_tube/gold/fusion_tube_v4.e" dimension 2 overwrite')
