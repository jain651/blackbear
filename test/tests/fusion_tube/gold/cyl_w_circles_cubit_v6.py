import os
import numpy as np
from itertools import islice
import cubit
import math
cubit.reset()

def are_neighbours(bbi,bbj,r):
    xi = 0.5*(bbi[0]+bbi[1])
    xj = 0.5*(bbj[0]+bbj[1])
    yi = 0.5*(bbi[3]+bbi[4])
    yj = 0.5*(bbj[3]+bbj[4])
    dist = math.sqrt((xj-xi)**2 + (yj-yi)**2)
    if (dist < 2.5*r[1]):
        return 1
    else:
        return 0

lammps_file = '/Users/amitjain/projects/lammps_1/myfiles/pour_flow_2d_sml_v3_out.2000000'
with open(lammps_file) as lines:
    num_circles = np.genfromtxt(islice(lines, 3, 4))
    domain_data = np.genfromtxt(islice(lines, 1, 4))
    circle_data = np.genfromtxt(islice(lines, 1, (1+num_circles)))

r = [0.25, 0.5]
x = [0, 10]
domain_ymax = 50
y = [0, domain_ymax]
t = r[0]/2
dr = 0.005
circle_mesh_size = r[0]/3
circle_count = 0

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

cubit.cmd('create surface rectangle width '+str(x[1]-x[0]+2*t)+' height '+str(y[1]-y[0]+2*t)+' zplane ')
cubit.cmd('create surface rectangle width '+str(x[1]-x[0])+' height '+str(y[1]-y[0]+2*t)+' zplane ')
cubit.cmd('subtract volume '+str(cubit.get_last_id('volume'))+' from volume '+str(cubit.get_last_id('volume')-1))
cubit.cmd('move Volume '+str(cubit.get_last_id('volume')-1)+' x '+str(0.5*(x[1]+x[0]))+' y '+str(0.5*(y[1]+y[0]))+' include_merged ')
cubit.cmd('block 1 add surface '+str(cubit.get_last_id('surface'))+' '+str(cubit.get_last_id('surface')-1))
cubit.cmd('surface '+str(cubit.get_last_id('surface'))+' '+str(cubit.get_last_id('surface')-1)+' size '+str(t))
cubit.cmd('sideset 1 add curve all in surface '+str(cubit.get_last_id('surface'))+' '+str(cubit.get_last_id('surface')-1)+' with x_coord > '+str(-t/2)+' and x_coord < '+str(x[1]+t/2))
cubit.cmd('color surface '+str(cubit.get_last_id('surface'))+' '+str(cubit.get_last_id('surface')-1)+' black')

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

fix_circle_list = []
for i in range(circle_count):
    cubit.cmd('surface all in volume '+str(volumeID[i])+' Scheme circle ')
    cubit.cmd('surface all in volume '+str(volumeID[i])+' size '+str(circle_mesh_size))
    bb = cubit.get_bounding_box("volume",volumeID[i]) # axis-min, axis-max, and axis-range order, repeated for x-axis, y-axis, and z-axis and ending with the total diagonal measure.
    if(bb[3]>y[1]-4*r[1]): # fixed circles
        cubit.cmd('block 1 add surface all in volume '+str(volumeID[i]))
        cubit.cmd('color volume '+str(volumeID[i])+' black')
        cubit.cmd('sideset 1 add surface all in volume '+str(volumeID[i]))
        fix_circle_list.append(i)
        continue

nodeset_circle_boundary = 1001
neighbor_count = 0
for i in range(circle_count):
    if(fix_circle_list.count(i)==0):
        cubit.cmd('sideset 2 add curve all in volume '+str(volumeID[i])) # for temperature BC
        bb = cubit.get_bounding_box("volume",volumeID[i]) # axis-min, axis-max, and axis-range order, repeated for x-axis, y-axis, and z-axis and ending with the total diagonal measure.
        neighbor_count = 0
        for j in range(i+1, circle_count):
            if(fix_circle_list.count(j)==0):
                bb_complementary = cubit.get_bounding_box("volume",volumeID[j])
                if(are_neighbours(bb,bb_complementary,r)):
                    cubit.cmd('sideset '+str(nodeset_circle_boundary+9000)+' add curve all in volume '+str(volumeID[j]))
                    neighbor_count = neighbor_count+1
        if(bb[2]>1.5*r[1]): # big circles
            cubit.cmd('color volume '+str(volumeID[i])+' blue')
            cubit.cmd('block 3 add surface all in volume '+str(volumeID[i]))
        else: # small circles
            cubit.cmd('color volume '+str(volumeID[i])+' red')
            cubit.cmd('block 2 add surface all in volume '+str(volumeID[i]))
        if(neighbor_count>0):
            cubit.cmd('sideset '+str(nodeset_circle_boundary)+' add curve all in volume '+str(volumeID[i]))
        nodeset_circle_boundary = nodeset_circle_boundary+1

cubit.cmd('mesh surface all in volume all')
cubit.cmd('export mesh "/Users/amitjain/projects/blackbear/test/tests/fusion_tube/gold/fusion_tube_v6.e" dimension 2 overwrite')
