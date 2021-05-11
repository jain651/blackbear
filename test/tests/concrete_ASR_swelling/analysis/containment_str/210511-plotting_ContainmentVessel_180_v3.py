import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math

out_file_loc = './test/tests/concrete_ASR_swelling/outputs/containment_str/'
out_file_name = out_file_loc+'ContainmentVessel3D_180_v3_out.csv'
out = pd.read_csv(out_file_name)

def fcyl_hz_exp(fp, lp, dx, dy, th_old):
    th_new = math.atan((lp[1]+0.5*dy)/(lp[0]-0.5*dx)) - math.atan((fp[1]-0.5*dy)/(fp[0]+0.5*dx))
    # print(th_new)
    return th_new/th_old*100

def fdome_vt_exp(fp, lp, dz, th_old):
    th_new = math.atan((lp_vt_dome[2]+0.5*dz)/pow((lp_vt_dome[0]**2+lp_vt_dome[1]**2),0.5)) - math.atan((fp_vt_dome[2]-0.5*dz)/pow((fp_vt_dome[0]**2+fp_vt_dome[1]**2),0.5))
    return th_new/th_old*100

def tangential_expansion(expansion_x, expansion_y):
    return pow((expansion_x**2 + expansion_y**2),0.5)

def sliding(disp_conc, disp_soil, gauge_conc, gauge_soil):
    return disp_conc - (disp_soil/gauge_soil*gauge_conc)

fp_hz_cyl = [2.59, 2.43, 4.470935]
lp_hz_cyl = [2.26, 2.743, 4.470935]
th_cyl = math.atan(lp_hz_cyl[1]/lp_hz_cyl[0]) - math.atan(fp_hz_cyl[1]/fp_hz_cyl[0])
# r_cyl = 0.5 * (pow((fp_hz_cyl[0]**2 + fp_hz_cyl[1]**2), 0.5) + pow((lp_hz_cyl[0]**2 + lp_hz_cyl[1]**2), 0.5))
fp_vt_cyl = [2.438776, 2.597033, 4.252161]
lp_vt_cyl = [2.435685, 2.593741, 4.689710]
gage_z = lp_vt_cyl[2]- fp_vt_cyl[2]
fp_hz_dome = [2.374, 1.924, 9.0805]
lp_hz_dome = [1.924, 2.374, 9.0805]
th_hz_dome = math.atan(lp_hz_dome[1]/lp_hz_dome[0]) - math.atan(fp_hz_dome[1]/fp_hz_dome[0])
fp_vt_dome = [2.149293, 2.303640, 8.909285]
lp_vt_dome = [1.876000, 2.020725, 9.520732]
th_vt_dome = math.atan(lp_vt_dome[2]/pow((lp_vt_dome[0]**2+lp_vt_dome[1]**2),0.5)) - math.atan(fp_vt_dome[2]/pow((fp_vt_dome[0]**2+fp_vt_dome[1]**2),0.5))
mat_r = 6.2485*6 # 491
base_r = 3.810*6

t = out['time']/86400

num_row = len(t)
cyl_hz_exp = [0]*(num_row)
cyl_vt_exp = out['cyl_z']/gage_z*100
dome_hz_exp = cyl_hz_exp
dome_vt_exp = cyl_hz_exp
dome_tang_exp = [0]*(num_row)
cyl_tang_exp = [0]*(num_row)
base_tang_exp = [0]*(num_row)
hz_sliding = [0]*(num_row)
sliding_x =0
sliding_y =0

for i in range(num_row):
    # print(cyl_hz_exp)
    cyl_hz_exp[i]  = fcyl_hz_exp (fp_hz_cyl,  lp_hz_cyl,  out['cyl_tang_x'][i],  out['cyl_tang_y'][i],  th_cyl)
    # print(dome_hz_exp)
    dome_hz_exp[i] = fcyl_hz_exp (fp_hz_dome, lp_hz_dome, out['dome_tang_x'][i], out['dome_tang_y'][i], th_hz_dome)
    # print(dome_vt_exp)
    dome_vt_exp[i] = fdome_vt_exp(fp_vt_dome, lp_vt_dome, out['dome_z_arc'][i], th_vt_dome)
    dome_tang_exp[i] = tangential_expansion(out['surfaceAvg_dome_x'][i], out['surfaceAvg_dome_y'][i])
    cyl_tang_exp[i] = tangential_expansion(out['surfaceAvg_cyl_x'][i], out['surfaceAvg_cyl_y'][i])
    base_tang_exp[i] = tangential_expansion(out['surfaceAvg_base_x'][i], out['surfaceAvg_base_y'][i])
    sliding_x = sliding(out['disp_base_mat_x'][i], out['disp_soil_x'][i], base_r, mat_r)
    sliding_y = sliding(out['disp_base_mat_y'][i], out['disp_soil_y'][i], base_r, mat_r)
    hz_sliding[i] = tangential_expansion(sliding_x, sliding_y)*1000

## plotting surface average ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(2, 2, sharex=False, sharey=False, figsize = (8,8))
plt.subplots_adjust(left=0.1, bottom=0.07, right=0.95, top=0.95, hspace=0.30, wspace=0.35)

[i, j] = [0, 0]
ASR_subfig[i][j].set_title('ASR Expansion: Dome ', fontsize=11)
ASR_subfig[i][j].plot(t, dome_tang_exp,             c = '0.6',  linestyle ='solid', linewidth=1.0, label= 'Azimuthal direction')
ASR_subfig[i][j].plot(t, out['surfaceAvg_dome_z'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Altitude direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.3)
ASR_subfig[i][j].legend(loc='lower right', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
ASR_subfig[i][j].set_title('ASR Expansion: Cylinder ', fontsize=11)
ASR_subfig[i][j].plot(t, cyl_tang_exp,              c = '0.6',  linestyle ='solid', linewidth=1.0, label= 'Tangential direction')
ASR_subfig[i][j].plot(t, out['surfaceAvg_cyl_z'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'Vertical direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.3)
ASR_subfig[i][j].legend(loc='upper left', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
ASR_subfig[i][j].set_title('ASR Expansion: Base ', fontsize=11)
ASR_subfig[i][j].plot(t, base_tang_exp,             c = '0.6',  linestyle ='solid', linewidth=1.0, label= 'Tangential direction')
ASR_subfig[i][j].plot(t, out['surfaceAvg_base_z'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Vertical direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.3)
ASR_subfig[i][j].legend(loc='upper left', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
ASR_subfig[i][j].set_title('Sliding between concrete and soil', fontsize=11)
ASR_subfig[i][j].plot(t, hz_sliding,             c = '0',    linestyle ='solid', linewidth=1.0, label= 'horizontal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Sliding [mm]")
# ASR_subfig[i][j].set_ylim(0,5)
ASR_subfig[i][j].legend(loc='upper left', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

for i in range(2):
    for j in range(2):
        # ASR_subfig[i][j].set_xlim(0, 200)
        # ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        ASR_subfig[i][j].set_xlabel("Time [days]")

# STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# place_image(STT_image, loc='lower right', ax=ASR_subfig[i][j], pad=0, zoom=0.18)
plt.show()
