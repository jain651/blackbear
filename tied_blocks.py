import os
import numpy as np
from itertools import islice
import cubit
cubit.reset()

cubit.cmd('create surface rectangle width 1 height 1 zplane ')
cubit.cmd('block 1 add surface 1  ')
cubit.cmd('create surface rectangle width 1 height 1 zplane')
cubit.cmd('move Surface 2  x 2 include_merged')
cubit.cmd('block 2 add surface 2  ')
cubit.cmd('create curve location 0 0 0 direction 1 0 0 length 2')
cubit.cmd('block 3 add curve 9  ')
cubit.cmd('surface all size 1')
cubit.cmd('mesh surface all')
cubit.cmd('curve 9 interval 1')
cubit.cmd('mesh curve 9')
cubit.cmd('nodeset 1 add node 1 2 3 4')
cubit.cmd('nodeset 2 add node 1 2 3 4 ')
cubit.cmd('nodeset 3 add curve 8 ')

cubit.cmd('export mesh "/Users/amitjain/projects/blackbear/test/tests/fusion_tube/gold/tied_blocks.e" dimension 2 overwrite')
