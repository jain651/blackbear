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
TRH_file_loc = './test/tests/concrete_ASR_swelling/analysis/containment_str/'
out     = pd.read_csv(out_file_loc+'containment_str_v1_out.csv')
T_his   = pd.read_csv(TRH_file_loc+'TempProfile.csv', header = None)
RH_his  = pd.read_csv(TRH_file_loc+'RHProfile.csv', header = None)

def fcyl_hz_exp(fp, lp, dx, dy, th_old):
    th_new = math.atan((lp[1]+0.5*dy)/(lp[0]-0.5*dx)) - math.atan((fp[1]-0.5*dy)/(fp[0]+0.5*dx))
    return (th_new/th_old-1)
def fdome_vt_exp(fp, lp, dz, th_old):
    th_new = math.atan((lp_vt_dome[2]+0.5*dz)/pow((lp_vt_dome[0]**2+lp_vt_dome[1]**2),0.5)) - math.atan((fp_vt_dome[2]-0.5*dz)/pow((fp_vt_dome[0]**2+fp_vt_dome[1]**2),0.5))
    return (th_new/th_old-1)

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
rad_cyl = 3.353+0.178
rad_dome_hz = 0.5 * (pow((fp_hz_dome[0]**2 + fp_hz_dome[1]**2), 0.5) + pow((lp_hz_dome[0]**2 + lp_hz_dome[1]**2), 0.5))
rad_dome_vt = 3.353+0.248

t_out = out['time']/86400/365
num_row = len(t_out)
cyl_hz_exp = [0]*(num_row)
cyl_vt_exp = out['cyl_z']/gage_z*100
dome_hz_exp = cyl_hz_exp
dome_vt_exp = cyl_hz_exp
for i in range(num_row):
    cyl_hz_exp[i]  = rad_cyl * 100 * fcyl_hz_exp (fp_hz_cyl,  lp_hz_cyl,  out['cyl_tang_x'][i],  out['cyl_tang_y'][i],  th_cyl)
    dome_hz_exp[i] = rad_dome_hz * 100 * fcyl_hz_exp (fp_hz_dome, lp_hz_dome, out['dome_tang_x'][i], out['dome_tang_y'][i], th_hz_dome)
    dome_vt_exp[i] = rad_dome_vt * 100 * fdome_vt_exp(fp_vt_dome, lp_vt_dome, out['dome_z_arc'][i], th_vt_dome)

surface = ['Cylinder', 'Dome']
dir =['tangential', 'vertical']

## plotting ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(2, 2, sharex=True, sharey=True, figsize = (8,8))
plt.subplots_adjust(left=0.10, bottom=0.10, right=0.90, top=0.90)
ASR_fig.text(0.03, 0.5, 'ASR expansion [%]', va='center', rotation='vertical')
ASR_fig.text(0.5, 0.02, 'Time [years]', ha='center')
for i in range(2):
    for j in range(2):
        ASR_subfig[i][j].set_title(surface[j] + ' ' + dir[i] + ' expansion', fontsize=11)
ASR_subfig[0][0].plot(t_out, cyl_hz_exp, 'k', linewidth=1.0, label= 'cyl_hz_exp')
ASR_subfig[1][0].plot(t_out, out['cyl_z']/gage_z*100, 'k', linewidth=1.0, label= 'cyl_vt_exp')
ASR_subfig[0][1].plot(t_out, dome_hz_exp, 'k', linewidth=1.0, label= 'dome_hz_exp')
ASR_subfig[1][1].plot(t_out, dome_vt_exp, 'k', linewidth=1.0, label= 'dome_vt_exp')
for i in range(2):
    for j in range(2):
        ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(1))
        ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(2))
plt.xlim(0, 10)
# plt.ylim(0, 10)
# hand_ASR, lab_ASR = (ASR_subfig[2]).get_legend_handles_labels()
# lgd_ASR = ASR_fig.legend(hand_ASR, lab_ASR, loc='lower center',ncol=2)
# lgd_ASR.FontSize = 11;
# lgd_ASR.get_frame().set_edgecolor('none')
# plt.show()
# plt.savefig("ASR_expansion.pdf")
# plt.savefig("ASR_expansion.png", dpi=300)

## plotting T and RH history###########################################################################
TRH_fig, TRH_subfig = plt.subplots(2, sharex=True, sharey=False, figsize = (8,8))
plt.subplots_adjust(left=0.10, bottom=0.10, right=0.90, top=0.90)
TRH_fig.text(0.03, 0.5, 'Temprature [C]', va='center', rotation='vertical')
TRH_fig.text(0.5, 0.02, 'Time [years]', ha='center')

TRH_subfig[0].set_title('Temperature history', fontsize=11)
TRH_subfig[0].plot(T_his[0]/86400/365, T_his[1], 'k', linewidth=1.0, label= 'Temperature Profile')
TRH_subfig[0].set_ylim(0, 40)

TRH_subfig[1].set_title('Relative humidity history', fontsize=11)
TRH_subfig[1].plot(RH_his[0]/86400/365, RH_his[1]*100, 'k', linewidth=1.0, label= 'RH Profile')
TRH_subfig[1].set_ylim(0, 100)

for i in range(2):
    TRH_subfig[i].grid(color="grey", ls = '--', lw = 0.5)
    TRH_subfig[i].xaxis.set_minor_locator(MultipleLocator(1))
    TRH_subfig[i].yaxis.set_minor_locator(MultipleLocator(2))
plt.xlim(0, 10)
# plt.ylim(0, 10)
# hand_TRH, lab_TRH = (TRH_subfig[2]).get_legend_handles_labels()
# lgd_TRH = TRH_fig.legend(hand_TRH, lab_TRH, loc='lower center',ncol=2)
# lgd_TRH.FontSize = 11;
# lgd_TRH.get_frame().set_edgecolor('none')
plt.show()
# plt.savefig("TRH.pdf")
# plt.savefig("TRH.png", dpi=300)
