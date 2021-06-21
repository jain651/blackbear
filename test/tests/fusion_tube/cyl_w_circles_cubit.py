import os
import numpy as np
from itertools import islice
import cubit

cubit.reset()

lammps_file = '/Users/amitjain/projects/lammps_1/myfiles/pour_flow_2d_out.3000000'
with open(lammps_file) as lines:
    num_circles = np.genfromtxt(islice(lines, 3, 4))
    domain_data = np.genfromtxt(islice(lines, 1, 4))
    circle_data = np.genfromtxt(islice(lines, 1, (1+num_circles)))


domain_data[1][1] = domain_data[1][1]-10


mesh_size = 5
for i in range(len(circle_data)):
        cubit.cmd('create surface circle radius '+str(circle_data[i][3])+' zplane ')
        cubit.cmd('move Surface '+str(cubit.get_last_id('surface'))+' location '+str(circle_data[i][0])+' '+str(circle_data[i][1])+' '+str(circle_data[i][2]))
        if(circle_data[i][3] == 0.5):
            cubit.cmd('color volume '+str(cubit.get_last_id('surface'))+' blue')
        else:
            cubit.cmd('color volume '+str(cubit.get_last_id('surface'))+' red')


x = domain_data[0]
y = domain_data[1]
z = domain_data[2].mean()
cubit.cmd('create curve location '+str(x[0])+' '+str(y[0])+' '+str(z)+' location '+str(x[0])+' '+str(y[1])+' '+str(z))
cubit.cmd('create curve location '+str(x[0])+' '+str(y[1])+' '+str(z)+' location '+str(x[1])+' '+str(y[1])+' '+str(z))
cubit.cmd('create curve location '+str(x[1])+' '+str(y[1])+' '+str(z)+' location '+str(x[1])+' '+str(y[0])+' '+str(z))
cubit.cmd('create curve location '+str(x[1])+' '+str(y[0])+' '+str(z)+' location '+str(x[0])+' '+str(y[0])+' '+str(z))

cubit.cmd('delete volume with y_coord > 100')
#cubit.cmd('merge surface all')
#cubit.cmd('imprint surface all')
cubit.cmd('mesh surface all')
cubit.cmd('mesh curve all')
