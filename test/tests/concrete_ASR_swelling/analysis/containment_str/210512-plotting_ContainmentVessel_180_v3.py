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

# time	ASR_ext	ASR_strain	ASR_strain_xx	ASR_strain_yy	ASR_strain_zz	base_45_rx	base_45_ry	base_45_th0	base_45_th1	base_45_z	base_btm_45_disp_x	base_btm_45_disp_y	base_btm_45_disp_z	base_btm_neg45_disp_x	base_btm_neg45_disp_y	base_btm_neg45_disp_z	base_neg_45_rx	base_neg_45_ry	base_neg_45_th0	base_neg_45_th1	base_neg_45_z	basemat_top_45_disp_x	basemat_top_45_disp_y	basemat_top_45_disp_z	basemat_top_neg45_disp_x	basemat_top_neg45_disp_y	basemat_top_neg45_disp_z	cyl_abv_gnd_45_rx	cyl_abv_gnd_45_ry	cyl_abv_gnd_45_thx	cyl_abv_gnd_45_thy	cyl_abv_gnd_45_z	cyl_abv_gnd_neg45_rx	cyl_abv_gnd_neg45_ry	cyl_abv_gnd_neg45_thx	cyl_abv_gnd_neg45_thy	cyl_abv_gnd_neg45_z	cyl_blw_gnd_45_rx	cyl_blw_gnd_45_ry	cyl_blw_gnd_45_thx	cyl_blw_gnd_45_thy	cyl_blw_gnd_45_z	cyl_blw_gnd_neg45_rx	cyl_blw_gnd_neg45_ry	cyl_blw_gnd_neg45_thx	cyl_blw_gnd_neg45_thy	cyl_blw_gnd_neg45_z	cyl_tang_x	cyl_tang_y	cyl_z	disp_base_mat_x	disp_base_mat_y	disp_base_x	disp_base_y	dome_45_phix	dome_45_phiy	dome_45_phiz	dome_45_rx	dome_45_ry	dome_45_thx	dome_45_thy	dome_tang_x	dome_tang_y	dome_z_arc	humidity	strain_xx	strain_yy	strain_zz	surfaceAvg_base_x	surfaceAvg_base_y	surfaceAvg_base_z	surfaceAvg_cyl_sunshade_x	surfaceAvg_cyl_sunshade_y	surfaceAvg_cyl_sunshade_z	surfaceAvg_cyl_sunshine_x	surfaceAvg_cyl_sunshine_y	surfaceAvg_cyl_sunshine_z	surfaceAvg_cyl_x	surfaceAvg_cyl_y	surfaceAvg_cyl_z	surfaceAvg_dome_sunshade_x	surfaceAvg_dome_sunshade_y	surfaceAvg_dome_sunshade_z	surfaceAvg_dome_sunshine_x	surfaceAvg_dome_sunshine_y	surfaceAvg_dome_sunshine_z	surfaceAvg_dome_x	surfaceAvg_dome_y	surfaceAvg_dome_z	temp	thermal_strain_xx	thermal_strain_yy	thermal_strain_zz	vonmises	vstrain

base_45_r_loc0 = [16.158, 16.158, 0.15]
base_45_r_loc1 = [15.804, 15.804, 0.15]
base_45_th_loc0 = [14.366, 17.122, 0.15]
base_45_th_loc1 = [17.122, 14.366, 0.15]
base_45_z_loc0 = [14.694, 17.511, -2.0]
base_45_z_loc1 = [14.694, 17.511,  3.0]

base_neg_45_r_loc0 = [16.158, -16.158, 0.15]
base_neg_45_r_loc1 = [15.804, -15.804, 0.15]
base_neg45_th_loc0 = [14.366, -17.122, 0.15]
base_neg45_th_loc1 = [17.122, -14.366, 0.15]
base_neg45_z_loc0 =  [14.694, -17.511, -2.0]
base_neg45_z_loc1 =  [14.694, -17.511,  3.0]

cyl_abv_gnd_45_r_loc0 =  [15.067, 15.067, 32.792]
cyl_abv_gnd_45_r_loc1 =  [14.713, 14.713, 32.792]
cyl_abv_gnd_45_th_loc0 = [16.321, 13.698, 32.792]
cyl_abv_gnd_45_th_loc1 = [13.698, 16.321, 32.792]
cyl_abv_gnd_45_z_loc0 =  [15.067, 15.067, 32.542]
cyl_abv_gnd_45_z_loc1 =  [15.067, 15.067, 33.042]

cyl_abv_gnd_neg45_r_loc0 =  [15.067, -15.067, 32.792]
cyl_abv_gnd_neg45_r_loc1 =  [14.713, -14.713, 32.792]
cyl_abv_gnd_neg45_th_loc0 = [16.321, -13.698, 32.792]
cyl_abv_gnd_neg45_th_loc1 = [13.698, -16.321, 32.792]
cyl_abv_gnd_neg45_z_loc0 =  [15.067, -15.067, 32.542]
cyl_abv_gnd_neg45_z_loc1 =  [15.067, -15.067, 33.042]

cyl_blw_gnd_45_r_loc0 =  [15.067, 15.067, 10.596]
cyl_blw_gnd_45_r_loc1 =  [14.713, 14.713, 10.596]
cyl_blw_gnd_45_th_loc0 = [16.321, 13.698, 10.596]
cyl_blw_gnd_45_th_loc1 = [13.698, 16.321, 10.596]
cyl_blw_gnd_45_z_loc0 =  [15.067, 15.067, 32.542]
cyl_blw_gnd_45_z_loc1 =  [15.067, 15.067, 33.042]

cyl_blw_gnd_neg45_r_loc0 =  [15.067, -15.067, 10.596]
cyl_blw_gnd_neg45_r_loc1 =  [14.713, -14.713, 10.596]
cyl_blw_gnd_neg45_th_loc0 = [16.321, -13.698, 10.596]
cyl_blw_gnd_neg45_th_loc1 = [13.698, -16.321, 10.596]
cyl_blw_gnd_neg45_z_loc0 =  [15.067, -15.067, 32.542]
cyl_blw_gnd_neg45_z_loc1 =  [15.067, -15.067, 33.042]

dome_45_r_loc0 =   [10.595, 10.595, 58.857]
dome_45_r_loc1 =   [10.345, 10.345, 58.503]
dome_45_th_loc0 =  [11.477,  9.633, 58.857]
dome_45_th_loc1 =  [9.633,  11.477, 58.857]
dome_45_phi_loc0 = [11.477, 11.477, 60.104]
dome_45_phi_loc1 = [9.633,   9.633, 57.495]

dome_neg45_r_loc0 =   [10.595, -10.595, 58.857]
dome_neg45_r_loc1 =   [10.345, -10.345, 58.503]
dome_neg45_th_loc0 =  [11.477,  -9.633, 58.857]
dome_neg45_th_loc1 =  [9.633,  -11.477, 58.857]
dome_neg45_phi_loc0 = [11.477, -11.477, 60.104]
dome_neg45_phi_loc1 = [9.633,   -9.633, 57.495]

def dr(dx,dy,theta):
    return dx*math.cos(theta) + dy*math.sin(theta)

def dtheta(loc,dx,dy,r):
    return (loc[0]*dy-dx*loc[1])/r**2

def drho(dx,dy,dz,rho,loc):
    return (loc[0]*dx + loc[1]*dy + loc[2]*dz)/rho

def dphi(dx,dy,dz,rho,loc,r):
    return (dz-drho(dx,dy,dz,rho,loc)) / (rho*r)

def rad_exp(dx0,dy0,theta0,dx1,dy1,theta1,gauge):
    return (dr(dx0,dy0,theta0)-dr(dx1,dy1,theta1))/gauge

def th_exp(loc0,loc1,dx0,dx1,dy0,dy1,gauge_th):
    return (dtheta(loc0,dx0,dy0,r0)-dtheta(loc1,dx1,dy1,r1))/gauge_th

def rho_exp(dx0,dy0,dz0,rho0,loc0,dx1,dy1,dz1,rho1,loc1,gauge_rho):
    return (drho(dx0,dy0,dz0,rho0,loc0)-drho(dx1,dy1,dz1,rho1,loc1))/gauge_rho

def phi_exp(dx0,dy0,dz0,rho0,loc0,r0,dx1,dy1,dz1,rho1,loc1,r1,gauge_phi):
    return (dphi(dx0,dy0,dz0,rho0,loc0,r0)-dphi(dx1,dy1,dz1,rho1,loc1,r1))/gauge_phi

t = out['time']/86400/365
num_row = len(t)
base_r_exp = [0]*(num_row)
for i in range(num_row):
    # print(cyl_hz_exp)
    base_r_exp[i]  = rad_exp (out['base_45_rx'][i],
                              out['base_45_ry'][i],
                              math.atan(base_45_r_loc0[1]/base_45_r_loc0[0]),
                              dx1,dy1,theta1,gauge)
    base_r_exp[i]  = rad_exp (fp_hz_cyl,  lp_hz_cyl,  out['cyl_tang_x'][i],




cyl_abv_gnd_45_loc = [13.691727, 16.317164, 32.792182]
cyl_abv_gnd_neg45_loc = [13.691727, -16.317164, 32.792182]
cyl_blw_gnd_45_loc = [13.838983, 16.492658, 10.596545]
cyl_blw_gnd_neg45_loc = [13.838983, -16.492658, 10.596545]
dome_45_loc = [11.10, 14.20, 55.005559]
dome_neg45_loc = [11.10, -14.20, 55.005559]

base_theta = math.atan(base_45_loc[1]/base_45_loc[0])
cyl_abv_gnd_theta = math.atan(cyl_abv_gnd_45_loc[1]/cyl_abv_gnd_45_loc[0])
cyl_blw_gnd_theta = math.atan(cyl_blw_gnd_45_loc[1]/cyl_blw_gnd_45_loc[0])
dome_theta = math.atan(dome_45_loc[1]/dome_45_loc[0])

base_r = (base_45_loc[0]**2 + base_45_loc[1]**2)**0.5
cyl_abv_gnd_r = (cyl_abv_gnd_45_loc[0]**2 + cyl_abv_gnd_45_loc[1]**2)**0.5
dome_rho = (dome_45_loc[0]**2 + dome_45_loc[1]**2 + dome_45_loc[2]**2)**0.5
dome_r = (dome_45_loc[0]**2 + dome_45_loc[1]**2)**0.5






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

t = out['time']/86400/365

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
    sliding_x = sliding(out['disp_base_x'][i], out['disp_base_mat_x'][i], base_r, mat_r)
    sliding_y = sliding(out['disp_base_y'][i], out['disp_base_mat_y'][i], base_r, mat_r)
    hz_sliding[i] = tangential_expansion(sliding_x, sliding_y)*1000

## plotting surface average ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(3, 4, sharex=False, sharey=False, figsize = (12,8))
plt.subplots_adjust(left=0.08, bottom=0.07, right=0.97, top=0.95, hspace=0.40, wspace=0.35)

[i, j] = [0, 0]
ASR_subfig[i][j].set_title('ASR Expansion: Dome', fontsize=11)
ASR_subfig[i][j].plot(t, out['surfaceAvg_dome_z'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Altitude direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
ASR_subfig[i][j].set_title('ASR Expansion: Cylinder', fontsize=11)
ASR_subfig[i][j].plot(t, out['surfaceAvg_cyl_z'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'Vertical direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
ASR_subfig[i][j].set_title('ASR Expansion: Base ', fontsize=11)
ASR_subfig[i][j].plot(t, out['surfaceAvg_base_z'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Vertical direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
ASR_subfig[i][j].set_title('ASR Expansion: Dome', fontsize=11)
ASR_subfig[i][j].plot(t, dome_tang_exp,             c = '0',  linestyle ='solid', linewidth=1.0, label= 'Azimuthal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
ASR_subfig[i][j].set_title('ASR Expansion: Cylinder', fontsize=11)
ASR_subfig[i][j].plot(t, cyl_tang_exp,              c = '0',  linestyle ='solid', linewidth=1.0, label= 'Tangential direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 2]
ASR_subfig[i][j].set_title('ASR Expansion: Base ', fontsize=11)
ASR_subfig[i][j].plot(t, base_tang_exp,             c = '0',  linestyle ='solid', linewidth=1.0, label= 'Tangential direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 3]
ASR_subfig[i][j].set_title('Temperature in air', fontsize=11)
ASR_subfig[i][j].plot(t, out['temp'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Temperature in air')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Temperature")
ASR_subfig[i][j].set_ylim(0,15)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 3]
ASR_subfig[i][j].set_title('RH in air ', fontsize=11)
ASR_subfig[i][j].plot(t, out['humidity']*100,  c = '0',    linestyle ='solid', linewidth=1.0, label= 'RH in air')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Relative humidity [%]")
ASR_subfig[i][j].set_ylim(0,100)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 0]
ASR_subfig[i][j].set_title('Sliding', fontsize=11)
ASR_subfig[i][j].plot(t, hz_sliding,             c = '0',    linestyle ='solid', linewidth=1.0, label= 'horizontal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Sliding [mm]")
ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 1]
# ASR_subfig[i][j].set_title('Sliding', fontsize=11)
# ASR_subfig[i][j].plot(t, hz_sliding,             c = '0',    linestyle ='solid', linewidth=1.0, label= 'horizontal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].set_ylabel("Sliding [mm]")
ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 2]
# ASR_subfig[i][j].set_title('Sliding', fontsize=11)
# ASR_subfig[i][j].plot(t, hz_sliding,             c = '0',    linestyle ='solid', linewidth=1.0, label= 'horizontal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].set_ylabel("Sliding [mm]")
ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 3]
# ASR_subfig[i][j].set_title('Sliding', fontsize=11)
# ASR_subfig[i][j].plot(t, hz_sliding,             c = '0',    linestyle ='solid', linewidth=1.0, label= 'horizontal direction')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].set_ylabel("Sliding [mm]")
ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)


for i in range(3):
    for j in range(4):
        ASR_subfig[i][j].set_xlim(0, 1)
        # ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        ASR_subfig[i][j].set_xlabel("Time [years]")

# STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# place_image(STT_image, loc='lower right', ax=ASR_subfig[i][j], pad=0, zoom=0.18)
plt.show()
