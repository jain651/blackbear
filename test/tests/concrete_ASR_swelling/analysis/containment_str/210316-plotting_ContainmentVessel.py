import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math

# Comaprison of ASR expansion in vertical displacement for cylinder (above grnd and below grnd), dome, and base (underground)
# Comparison of sliding between concrete and soil structure

out_file_loc = './test/tests/concrete_ASR_swelling/outputs/containment_str/'
out_file_name = out_file_loc+'containment_str_v1_out.csv'
out = pd.read_csv(out_file_name)

def fcyl_hz_exp(fp, lp, dx, dy, th_old):
    th_new = math.atan((lp[1]+0.5*dy)/(lp[0]-0.5*dx)) - math.atan((fp[1]-0.5*dy)/(fp[0]+0.5*dx))
    print(th_new)
    return th_new/th_old*100

def fdome_vt_exp(fp, lp, dz, th_old):
    th_new = math.atan((lp_vt_dome[2]+0.5*dz)/pow((lp_vt_dome[0]**2+lp_vt_dome[1]**2),0.5)) - math.atan((fp_vt_dome[2]-0.5*dz)/pow((fp_vt_dome[0]**2+fp_vt_dome[1]**2),0.5))
    return th_new/th_old*100

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

t = out['time']/86400

num_row = len(t)
cyl_hz_exp = [0]*(num_row)
cyl_vt_exp = out['cyl_z']/gage_z*100
dome_hz_exp = cyl_hz_exp
dome_vt_exp = cyl_hz_exp
for i in range(num_row):
    # print(cyl_hz_exp)
    cyl_hz_exp[i]  = fcyl_hz_exp (fp_hz_cyl,  lp_hz_cyl,  out['cyl_tang_x'][i],  out['cyl_tang_y'][i],  th_cyl)
    # print(dome_hz_exp)
    dome_hz_exp[i] = fcyl_hz_exp (fp_hz_dome, lp_hz_dome, out['dome_tang_x'][i], out['dome_tang_y'][i], th_hz_dome)
    # print(dome_vt_exp)
    dome_vt_exp[i] = fdome_vt_exp(fp_vt_dome, lp_vt_dome, out['dome_z_arc'][i], th_vt_dome)

surface = ['Cylinder', 'Dome']
dir =['tangential', 'vertical']

## plotting ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(2, 2, sharex=False, sharey=False, figsize = (8,8))
plt.subplots_adjust(left=0.18, bottom=0.15, right=0.90, top=0.97)

[i, j] = [0, 0]
ASR_subfig[i][j].set_title('ASR Expansion: Dome-Vertical ', fontsize=11)
ASR_subfig[i][j].plot(Lee_uni_ten[0], Lee_uni_ten[1], c = '0.6', linestyle ='solid', linewidth=1.0, label= 'Uniaxial (Lee)')
ASR_subfig[i][j].plot(uni_ten_v3_0['displacement_x']/25.4, uni_ten_v3_0['s_xx'], c = '0', linestyle ='solid', linewidth=1.0, label= 'Uniaxial_v3')

ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
# ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_xlabel("Time [days]")
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_xlim(0, 0.001)
# ASR_subfig[i][j].set_ylim(0,0.15)
# STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# place_image(STT_image, loc='lower right', ax=ASR_subfig[i][j], pad=0, zoom=0.18)
ASR_subfig[i][j].legend(loc='upper right')




















ASR_fig.text(0.03, 0.5, 'ASR expansion [%]', va='center', rotation='vertical')
ASR_fig.text(0.5, 0.08, 'Time [days]', ha='center')

for i in range(2):
    for j in range(2):
        ASR_subfig[i][j].set_title(surface[j] + ' ' + dir[i] + ' expansion', fontsize=11)

ASR_subfig[0][0].plot(t, cyl_hz_exp, 'k', linewidth=1.0)#, label= sensor_loc[j])
ASR_subfig[1][0].plot(t, out['cyl_z']/gage_z*100, 'k', linewidth=1.0)#, label= sensor_loc[j])
ASR_subfig[0][1].plot(t, dome_hz_exp, 'k', linewidth=1.0)#, label= sensor_loc[j])
ASR_subfig[1][1].plot(t, dome_vt_exp, 'k', linewidth=1.0)#, label= sensor_loc[j])

# for i in range(2):
#     for j in range(2):
#         ASR_subfig[i].grid(color="grey", ls = '--', lw = 0.5)
#         ASR_subfig[i].xaxis.set_minor_locator(MultipleLocator(20))
#         ASR_subfig[i].yaxis.set_minor_locator(MultipleLocator(2))
# plt.xlim(0, 600)
# plt.ylim(0, 100)
# hand_ASR, lab_ASR = (ASR_subfig[2]).get_legend_handles_labels()
# lgd_ASR = ASR_fig.legend(hand_ASR, lab_ASR, loc='lower center',ncol=2)
# lgd_ASR.FontSize = 11;
# lgd_ASR.get_frame().set_edgecolor('none')

plt.show()
# plt.savefig("ASR_expansion.pdf")
# plt.savefig("ASR_expansion.png", dpi=300)


 # [./cyl_z] # 500 mm gauge length
 #  first_point = '2.438776     2.597033     4.252161'
 #  last_point = '2.435685     2.593741     4.689710'

 # [./cyl_tang_xy] # 500 mm gauge length (not the arc length)
 #  first_point = '2.59     2.43     4.470935'
 #  last_point = '2.26     2.743     4.470935'

 # [./dome_z_arc]# 500 mm gauge length (not the arc length)
 #  first_point = '2.149293     2.303640     8.909285'
 #  last_point = '1.876000     2.020725     9.520732'

 # [./dome_tang_xy]# 500 mm gauge length (not the arc length)
 #  first_point = '2.374 1.924 9.0805'# basesd on hand calculation
 #  last_point = '1.924 2.374 9.0805'
