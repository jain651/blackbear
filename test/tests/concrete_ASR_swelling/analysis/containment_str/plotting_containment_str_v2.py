import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox, AnchoredOffsetbox
# from matplotlib.offsetbox import OffsetImage,
from numpy import *
import numpy as np
import pandas as pd
import math

out_file_loc = './test/tests/concrete_ASR_swelling/outputs/containment_str/'
analysis_loc = './test/tests/concrete_ASR_swelling/analysis/containment_str/'

wo_grav = pd.read_csv(out_file_loc+'containment_str_v2_out.csv')
w_grav  = pd.read_csv(out_file_loc+'containment_str_v3_gravity_out.csv')
T_air   = pd.read_csv(analysis_loc+'T_air.csv', header = None)
RH_air  = pd.read_csv(analysis_loc+'rh_air.csv', header = None)
T_bet_grnd_2in  = pd.read_csv(analysis_loc+'T_bet_grnd_2in.csv', header = None)
RH_bet_grnd_2in = pd.read_csv(analysis_loc+'rh_bet_grnd_2in.csv', header = None)
T_bet_2in_4in   = pd.read_csv(analysis_loc+'T_bet_2in_4in.csv', header = None)
RH_bet_2in_4in  = pd.read_csv(analysis_loc+'rh_bet_2in_4in.csv', header = None)
T_bet_4in_8in   = pd.read_csv(analysis_loc+'T_bet_4in_8in.csv', header = None)
RH_bet_4in_8in  = pd.read_csv(analysis_loc+'rh_bet_4in_8in.csv', header = None)
T_bet_8in_20in  = pd.read_csv(analysis_loc+'T_bet_8in_20in.csv', header = None)
RH_bet_8in_20in = pd.read_csv(analysis_loc+'rh_bet_8in_20in.csv', header = None)
T_below_20in    = pd.read_csv(analysis_loc+'T_below_20in.csv', header = None)
RH_below_20in   = pd.read_csv(analysis_loc+'rh_below_20in.csv', header = None)

def th_times_dr(fp, lp, dx, dy, th_old):
    dr1 = sqrt(pow(fp[0]+0.5*dx,2.)+pow(fp[1]-0.5*dy,2.))-sqrt(pow(fp[0],2.)+pow(fp[1],2.))
    dr2 = sqrt(pow(lp[0]-0.5*dx,2.)+pow(lp[1]+0.5*dy,2.))-sqrt(pow(lp[0],2.)+pow(lp[1],2.))
    dr = 0.5 * (dr1+dr2)
    return th_old*dr
def fcyl_hz_exp(fp, lp, dx, dy, th_old):
    th_new = math.atan((lp[1]+0.5*dy)/(lp[0]-0.5*dx)) - math.atan((fp[1]-0.5*dy)/(fp[0]+0.5*dx))
    return (th_new/th_old-1)
def fdome_vt_exp(fp, lp, dz, th_old):
    th_new = math.atan((lp_vt_dome[2]+0.5*dz)/pow((lp_vt_dome[0]**2+lp_vt_dome[1]**2),0.5)) - math.atan((fp_vt_dome[2]-0.5*dz)/pow((fp_vt_dome[0]**2+fp_vt_dome[1]**2),0.5))
    return (th_new/th_old-1)
def place_image(im, loc=3, ax=None, zoom=1, **kw):
    if ax==None: ax=plt.gca()
    imagebox = OffsetImage(im, zoom=zoom*0.72)
    ab = AnchoredOffsetbox(loc=loc, child=imagebox, frameon=False, **kw)
    ax.add_artist(ab)

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

t_wo_grav = wo_grav['time']/86400/365
num_row = len(t_wo_grav)
cyl_hz_exp_wo_grav = [1]*(num_row)
cyl_vt_exp_wo_grav = wo_grav['cyl_z']/gage_z*100
dome_hz_exp_wo_grav = cyl_hz_exp_wo_grav
dome_vt_exp_wo_grav = cyl_hz_exp_wo_grav
for i in range(num_row):
    cyl_hz_exp_wo_grav[i]  = 100 * th_times_dr (fp_hz_cyl,  lp_hz_cyl,  wo_grav['cyl_tang_x'][i],  wo_grav['cyl_tang_y'][i],  th_cyl)
    # cyl_hz_exp_wo_grav[i]  = rad_cyl * 100 * fcyl_hz_exp (fp_hz_cyl,  lp_hz_cyl,  wo_grav['cyl_tang_x'][i],  wo_grav['cyl_tang_y'][i],  th_cyl)
    dome_hz_exp_wo_grav[i] = rad_dome_hz * 100 * fcyl_hz_exp (fp_hz_dome, lp_hz_dome, wo_grav['dome_tang_x'][i], wo_grav['dome_tang_y'][i], th_hz_dome)
    dome_vt_exp_wo_grav[i] = rad_dome_vt * 100 * fdome_vt_exp(fp_vt_dome, lp_vt_dome, wo_grav['dome_z_arc'][i], th_vt_dome)

t_w_grav = w_grav['time']/86400/365
num_row = len(t_w_grav)
cyl_hz_exp_w_grav = [0]*(num_row)
cyl_vt_exp_w_grav = w_grav['cyl_z']/gage_z*100
dome_hz_exp_w_grav = cyl_hz_exp_w_grav
dome_vt_exp_w_grav = cyl_hz_exp_w_grav
for i in range(num_row):
    cyl_hz_exp_w_grav[i]  = 100 * th_times_dr (fp_hz_cyl,  lp_hz_cyl,  w_grav['cyl_tang_x'][i],  w_grav['cyl_tang_y'][i],  th_cyl)
    # cyl_hz_exp_w_grav[i]  = rad_cyl * 100 * fcyl_hz_exp (fp_hz_cyl,  lp_hz_cyl,  w_grav['cyl_tang_x'][i],  w_grav['cyl_tang_y'][i],  th_cyl)
    dome_hz_exp_w_grav[i] = rad_dome_hz * 100 * fcyl_hz_exp (fp_hz_dome, lp_hz_dome, w_grav['dome_tang_x'][i], w_grav['dome_tang_y'][i], th_hz_dome)
    dome_vt_exp_w_grav[i] = rad_dome_vt * 100 * fdome_vt_exp(fp_vt_dome, lp_vt_dome, w_grav['dome_z_arc'][i], th_vt_dome)

## plotting ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(2, 2, sharex=True, sharey=False, figsize = (8,8))
plt.subplots_adjust(left=0.12, bottom=0.1, right=0.90, top=0.90)
ASR_fig.text(0.03, 0.5, 'ASR expansion [%]', va='center', rotation='vertical')
ASR_fig.text(0.5, 0.05, 'Time [years]', ha='center')

[i, j] = [0, 0]
ASR_subfig[i][j].set_title('Cylinder tangential expansion', fontsize=11)
ASR_subfig[i][j].plot(t_wo_grav, sqrt(pow(wo_grav['cyl_tang_x'],2.)+pow(wo_grav['cyl_tang_y'],2.))*100, 'k', linewidth=1.0, label= 'cyl_hz_exp_wo_grav')
ASR_subfig[i][j].plot(t_w_grav,  sqrt(pow(w_grav['cyl_tang_x'],2.) +pow(w_grav['cyl_tang_y'],2.))*100, 'r', linewidth=1.0, label= 'cyl_hz_exp_w_grav')
# ASR_subfig[i][j].plot(t_wo_grav, cyl_hz_exp_wo_grav, 'k', linewidth=1.0, label= 'cyl_hz_exp_wo_grav')
# ASR_subfig[i][j].plot(t_w_grav, cyl_hz_exp_w_grav, 'r', linewidth=1.0, label= 'cyl_hz_exp_w_grav')
ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.005))
ASR_subfig[i][j].set_ylim(0,0.15)
cyl_tang_loc = mpimg.imread(analysis_loc+'cyl_tang.png')
place_image(cyl_tang_loc, loc='upper center', ax=ASR_subfig[i][j], pad=0, zoom=0.3)

[i, j] = [1, 0]
ASR_subfig[i][j].set_title('Cylinder vertical expansion', fontsize=11)
ASR_subfig[i][j].plot(t_wo_grav, wo_grav['surfaceAvg_cyl_z']*100, 'k', linewidth=1.0, label= 'cyl_vt_exp_wo_grav')
ASR_subfig[i][j].plot(t_w_grav, w_grav['surfaceAvg_cyl_z']*100, 'r', linewidth=1.0, label= 'cyl_vt_exp_w_grav')
# ASR_subfig[i][j].plot(t_wo_grav, wo_grav['cyl_z']/gage_z*100, 'k', linewidth=1.0, label= 'cyl_vt_exp_wo_grav')
# ASR_subfig[i][j].plot(t_w_grav, w_grav['cyl_z']/gage_z*100, 'r', linewidth=1.0, label= 'cyl_vt_exp_w_grav')
ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.02))
ASR_subfig[i][j].set_ylim(0,0.8)
cyl_vert_loc = mpimg.imread(analysis_loc+'cyl_vert.png')
place_image(cyl_vert_loc, loc='upper center', ax=ASR_subfig[i][j], pad=0, zoom=0.3)

[i, j] = [0, 1]
ASR_subfig[i][j].set_title('Dome azimuth expansion', fontsize=11)
ASR_subfig[i][j].plot(t_wo_grav, sqrt(pow(wo_grav['dome_tang_x'],2.)+pow(wo_grav['dome_tang_y'],2.))*100, 'k', linewidth=1.0, label= 'dome_hz_exp_wo_grav')
ASR_subfig[i][j].plot(t_w_grav,  sqrt(pow(w_grav['dome_tang_x'],2.) +pow(w_grav['dome_tang_y'],2.))*100, 'r', linewidth=1.0, label= 'dome_hz_exp_w_grav')
# ASR_subfig[i][j].plot(t_wo_grav, dome_hz_exp_wo_grav, 'k', linewidth=1.0, label= 'dome_hz_exp_wo_grav')
# ASR_subfig[i][j].plot(t_w_grav, dome_hz_exp_w_grav, 'r', linewidth=1.0, label= 'dome_hz_exp_w_grav')
ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.005))
ASR_subfig[i][j].set_ylim(0,0.14)
dome_azimuth_loc = mpimg.imread(analysis_loc+'dome_azimuth.png')
place_image(dome_azimuth_loc, loc='lower center', ax=ASR_subfig[i][j], pad=0, zoom=0.3)

[i, j] = [1, 1]
ASR_subfig[i][j].set_title('Dome altitude expansion', fontsize=11)
ASR_subfig[i][j].plot(t_wo_grav, wo_grav['surfaceAvg_dome_z']*100, 'k', linewidth=1.0, label= 'without gravity load')
ASR_subfig[i][j].plot(t_w_grav,  w_grav['surfaceAvg_dome_z']*100, 'r', linewidth=1.0, label= 'with gravity load')
# ASR_subfig[i][j].plot(t_wo_grav, dome_vt_exp_wo_grav, 'k', linewidth=1.0, label= 'dome_vt_exp_wo_grav')
# ASR_subfig[i][j].plot(t_w_grav, dome_vt_exp_w_grav, 'r', linewidth=1.0, label= 'dome_vt_exp_w_grav')
ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.02))
ASR_subfig[i][j].set_ylim(0,0.8)
dome_altitude_loc = mpimg.imread(analysis_loc+'dome_altitude.png')
place_image(dome_altitude_loc, loc='lower center', ax=ASR_subfig[i][j], pad=0, zoom=0.3)

plt.xlim(0, 6)
# plt.ylim(0, 10)
hand_ASR, lab_ASR = (ASR_subfig[1][1]).get_legend_handles_labels()
lgd_ASR = ASR_fig.legend(hand_ASR, lab_ASR, loc='lower center',ncol=2)
lgd_ASR.FontSize = 11;
lgd_ASR.get_frame().set_edgecolor('none')
# plt.show()
# plt.savefig("ASR_expansion.pdf")
# plt.savefig("ASR_expansion.png", dpi=300)

## plotting T and RH history###########################################################################
TRH_fig, TRH_subfig = plt.subplots(2, sharex=True, sharey=False, figsize = (4,8))
plt.subplots_adjust(left=0.10, bottom=0.14, right=0.90, top=0.90)
TRH_fig.text(0.03, 0.75, 'Temprature [\N{DEGREE SIGN}C]', va='center', rotation='vertical')
TRH_fig.text(0.03, 0.25, 'Relative humidity [%]', va='center', rotation='vertical')
TRH_fig.text(0.5, 0.08, 'Time [years]', ha='center')

i=0
TRH_subfig[i].set_title('Temperature history', fontsize=11)
TRH_subfig[i].plot(T_air[0]/86400,          T_air[1],          'k', linewidth=1.0, label= 'Air')
TRH_subfig[i].plot(T_bet_grnd_2in[0]/86400, T_bet_grnd_2in[1], 'y', linewidth=1.0, label= '-2" depth')
TRH_subfig[i].plot(T_bet_2in_4in[0]/86400,  T_bet_2in_4in[1],  'r', linewidth=1.0, label= '-4" depth')
TRH_subfig[i].plot(T_bet_4in_8in[0]/86400,  T_bet_4in_8in[1],  'b', linewidth=1.0, label= '-8" depth')
TRH_subfig[i].plot(T_bet_8in_20in[0]/86400, T_bet_8in_20in[1], 'c', linewidth=1.0, label= '-20" depth')
TRH_subfig[i].plot(T_below_20in[0]/86400,   T_below_20in[1],   'g', linewidth=1.0, label= '-40" depth')
TRH_subfig[i].grid(color="grey", ls = '--', lw = 0.5)
TRH_subfig[i].set_ylim(-20, 30)
TRH_subfig[i].xaxis.set_minor_locator(MultipleLocator(10))
TRH_subfig[i].yaxis.set_minor_locator(MultipleLocator(2))

i=1
TRH_subfig[i].set_title('Relative humidity history', fontsize=11)
TRH_subfig[i].plot(RH_air[0]/86400,          RH_air[1]*100,          'k', linewidth=1.0, label= 'Air')
TRH_subfig[i].plot(RH_bet_grnd_2in[0]/86400, RH_bet_grnd_2in[1]*100, 'y', linewidth=1.0, label= '-2" depth')
TRH_subfig[i].plot(RH_bet_2in_4in[0]/86400,  RH_bet_2in_4in[1]*100,  'r', linewidth=1.0, label= '-4" depth')
TRH_subfig[i].plot(RH_bet_4in_8in[0]/86400,  RH_bet_4in_8in[1]*100,  'b', linewidth=1.0, label= '-8" depth')
TRH_subfig[i].plot(RH_bet_8in_20in[0]/86400, RH_bet_8in_20in[1]*100, 'c', linewidth=1.0, label= '-20" depth')
TRH_subfig[i].plot(RH_below_20in[0]/86400,   RH_below_20in[1]*100,   'g', linewidth=1.0, label= '-40" depth')
TRH_subfig[i].grid(color="grey", ls = '--', lw = 0.5)
TRH_subfig[i].set_ylim(0, 100)
TRH_subfig[i].xaxis.set_minor_locator(MultipleLocator(10))
TRH_subfig[i].yaxis.set_minor_locator(MultipleLocator(5))

plt.xlim(0, 365)
# plt.ylim(0, 10)
hand_TRH, lab_TRH = (TRH_subfig[1]).get_legend_handles_labels()
lgd_TRH = TRH_fig.legend(hand_TRH, lab_TRH, loc='lower center',ncol=3)
lgd_TRH.FontSize = 11;
lgd_TRH.get_frame().set_edgecolor('none')
plt.show()
# plt.savefig("TRH.pdf")
# plt.savefig("TRH.png", dpi=300)
