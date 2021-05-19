import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math


analsis_dir = './test/tests/concrete_ASR_swelling/outputs/containment_str/'
test_dir = './test/tests/concrete_ASR_swelling/'
out_file_name = test_dir+'ContainmentVessel3D_180_v3_out.csv'
out = pd.read_csv(out_file_name)

base_shade_r0 =  [16.000, 16.000,  0.15]
base_shade_r1 =  [15.804, 15.804,  0.15]
base_shade_th0 = [14.366, 17.122,  0.15]
base_shade_th1 = [17.122, 14.366,  0.15]
base_shade_z0 =  [14.694, 17.511, -2.00]
base_shade_z1 =  [14.694, 17.511,  3.00]

base_sun_r0 =  [16.000, -16.000,  0.15]
base_sun_r1 =  [15.804, -15.804,  0.15]
base_sun_th0 = [14.366, -17.122,  0.15]
base_sun_th1 = [17.122, -14.366,  0.15]
base_sun_z0 =  [14.694, -17.511, -2.00]
base_sun_z1 =  [14.694, -17.511,  3.00]

cyl_air_shade_r0 =  [14.900, 14.900, 32.792]
cyl_air_shade_r1 =  [14.713, 14.713, 32.792]
cyl_air_shade_th0 = [16.321, 13.600, 32.792]
cyl_air_shade_th1 = [13.600, 16.321, 32.792]
cyl_air_shade_z0 =  [14.900, 14.900, 32.542]
cyl_air_shade_z1 =  [14.900, 14.900, 33.042]

cyl_air_sun_r0 =  [14.900, -14.900, 32.792]
cyl_air_sun_r1 =  [14.713, -14.713, 32.792]
cyl_air_sun_th0 = [16.321, -13.600, 32.792]
cyl_air_sun_th1 = [13.600, -16.321, 32.792]
cyl_air_sun_z0 =  [14.900, -14.900, 32.542]
cyl_air_sun_z1 =  [14.900, -14.900, 33.042]

cyl_gnd_shade_r0 =  [14.900, 14.900, 10.596]
cyl_gnd_shade_r1 =  [14.713, 14.713, 10.596]
cyl_gnd_shade_th0 = [16.321, 13.600, 10.596]
cyl_gnd_shade_th1 = [13.600, 16.321, 10.596]
cyl_gnd_shade_z0 =  [14.900, 14.900, 10.346]
cyl_gnd_shade_z1 =  [14.900, 14.900, 10.846]

cyl_gnd_sun_r0 =  [14.900, -14.900, 10.596]
cyl_gnd_sun_r1 =  [14.713, -14.713, 10.596]
cyl_gnd_sun_th0 = [16.321, -13.600, 10.596]
cyl_gnd_sun_th1 = [13.600, -16.321, 10.596]
cyl_gnd_sun_z0 =  [14.900, -14.900, 10.346]
cyl_gnd_sun_z1 =  [14.900, -14.900, 10.846]

dome_shade_r0 =   [10.400, 10.400, 58.857]
dome_shade_r1 =   [10.345, 10.345, 58.503]
dome_shade_th0 =  [10.900,  9.633, 58.857]
dome_shade_th1 =  [9.633,  10.900, 58.857]
dome_shade_phi0 = [9.300,   9.300, 60.104]
dome_shade_phi1 = [10.500, 10.500, 57.495]

dome_sun_r0 =   [10.400, -10.400, 58.857]
dome_sun_r1 =   [10.345, -10.345, 58.503]
dome_sun_th0 =  [10.900, -9.633,  58.857]
dome_sun_th1 =  [9.633,  -10.900, 58.857]
dome_sun_phi0 = [9.300,  -9.300,  60.104]
dome_sun_phi1 = [10.500, -10.500, 57.495]

base_bot_shade =  [16.000,  16.000, -2.890]
base_bot_sun =  [16.000, -16.000, -2.890]
basemat_top_shade = [16.000,  16.000, -2.900]
basemat_top_sun = [16.000, -16.000, -2.900]

def cyl_r(loc):
    return math.sqrt(loc[0]**2+loc[1]**2)
def sph_r(loc):
    return math.sqrt(loc[0]**2+loc[1]**2+loc[2]**2)
def theta(loc):
    return math.atan(loc[1]/loc[0])
def phi(loc):
    return math.atan(loc[2]/cyl_r(loc))
def cyl_exp_r(dx0,dy0,loc0,dx1,dy1,loc1,G):
    disp_xy_loc0 = [loc0[0]+dx0, loc0[1]+dy0]
    disp_xy_loc1 = [loc1[0]+dx1, loc1[1]+dy1]
    return ((cyl_r(disp_xy_loc1) - cyl_r(disp_xy_loc0))/G-1)*100
def sph_r_exp(dx0,dy0,dz0,loc0,dx1,dy1,dz1,loc1,G):
    disp_loc0 = [loc0[0]+dx0, loc0[1]+dy0, loc0[2]+dz0]
    disp_loc1 = [loc1[0]+dx1, loc1[1]+dy1, loc1[2]+dz1]
    return ((sph_r(disp_loc1)-sph_r(disp_loc0))/G-1)*100
def th_exp(dx0,dy0,loc0,dx1,dy1,loc1,G):
    disp_xy_loc0 = [loc0[0]+dx0, loc0[1]+dy0]
    disp_xy_loc1 = [loc1[0]+dx1, loc1[1]+dy1]
    return ((theta(disp_xy_loc1)-theta(disp_xy_loc0))/G-1)*100
def z_exp(expansion,G):
    return  expansion / G * 100
def phi_exp(dx0,dy0,dz0,loc0,dx1,dy1,dz1,loc1,G):
    disp_loc0 = [loc0[0]+dx0, loc0[1]+dy0, loc0[2]+dz0]
    disp_loc1 = [loc1[0]+dx1, loc1[1]+dy1, loc1[2]+dz1]
    return ((phi(disp_loc1)-phi(disp_loc0))/G-1)*100
def r_sliding(dx_top,dy_top,dz_top,loc_top,dx_bot,dy_bot,dz_bot,loc_bot):
    disp_loc_top = [loc_top[0]+dx_top, loc_top[1]+dy_top, loc_top[2]+dz_top]
    disp_loc_bot = [loc_bot[0]+dx_bot, loc_bot[1]+dy_bot, loc_bot[2]+dz_bot]
    return (cyl_r(disp_loc_top)/cyl_r(loc_top) - cyl_r(disp_loc_bot)/cyl_r(loc_bot))*1000
def th_sliding(dx_top,dy_top,dz_top,loc_top,dx_bot,dy_bot,dz_bot,loc_bot):
    disp_loc_top = [loc_top[0]+dx_top, loc_top[1]+dy_top, loc_top[2]+dz_top]
    disp_loc_bot = [loc_bot[0]+dx_bot, loc_bot[1]+dy_bot, loc_bot[2]+dz_bot]
    return (theta(disp_loc_top)-theta(disp_loc_bot))*180/math.pi
def z_sliding(dz_top,dz_bot):
    return (dz_top-dz_bot)*1000

G_base_sun_r =      cyl_r(base_sun_r1)    - cyl_r(base_sun_r0)
G_cyl_air_sun_r =   cyl_r(cyl_air_sun_r1) - cyl_r(cyl_air_sun_r0)
G_cyl_gnd_sun_r =   cyl_r(cyl_gnd_sun_r1) - cyl_r(cyl_gnd_sun_r0)
G_dome_sun_r =      sph_r(dome_sun_r1)    - sph_r(dome_sun_r0)
G_base_sun_th =     theta(base_sun_th1)      - theta(base_sun_th0)
G_cyl_air_sun_th =  theta(cyl_air_sun_th1)   - theta(cyl_air_sun_th0)
G_cyl_gnd_sun_th =  theta(cyl_gnd_sun_th1)   - theta(cyl_gnd_sun_th0)
G_dome_sun_th =     theta(dome_sun_th1)      - theta(dome_sun_th0)
G_base_sun_z =      base_sun_z1[2]        - base_sun_z0[2]
G_cyl_air_sun_z =   cyl_air_sun_z1[2]     - cyl_air_sun_z0[2]
G_cyl_gnd_sun_z =   cyl_gnd_sun_z1[2]     - cyl_gnd_sun_z0[2]
G_dome_sun_phi =    phi(dome_sun_phi1)    - phi(dome_sun_phi0)

G_base_shade_r =      cyl_r(base_shade_r1)    - cyl_r(base_shade_r0)
G_cyl_air_shade_r =   cyl_r(cyl_air_shade_r1) - cyl_r(cyl_air_shade_r0)
G_cyl_gnd_shade_r =   cyl_r(cyl_gnd_shade_r1) - cyl_r(cyl_gnd_shade_r0)
G_dome_shade_r =      sph_r(dome_shade_r1)    - sph_r(dome_shade_r0)
G_base_shade_th =     theta(base_shade_th1)      - theta(base_shade_th0)
G_cyl_air_shade_th =  theta(cyl_air_shade_th1)   - theta(cyl_air_shade_th0)
G_cyl_gnd_shade_th =  theta(cyl_gnd_shade_th1)   - theta(cyl_gnd_shade_th0)
G_dome_shade_th =     theta(dome_shade_th1)      - theta(dome_shade_th0)
G_base_shade_z =      base_shade_z1[2]       - base_shade_z0[2]
G_cyl_air_shade_z =   cyl_air_shade_z1[2]    - cyl_air_shade_z0[2]
G_cyl_gnd_shade_z =   cyl_gnd_shade_z1[2]    - cyl_gnd_shade_z0[2]
G_dome_shade_phi =    phi(dome_shade_phi1)   - phi(dome_shade_phi0)

t = out['time']/86400/365 # time in years
num_row = len(t)
base_sun_r_exp = [0]*(num_row)
base_sun_th_exp = [0]*(num_row)
base_sun_z_exp = [0]*(num_row)
cyl_air_sun_r_exp = [0]*(num_row)
cyl_air_sun_th_exp = [0]*(num_row)
cyl_air_sun_z_exp = [0]*(num_row)
cyl_gnd_sun_r_exp = [0]*(num_row)
cyl_gnd_sun_th_exp = [0]*(num_row)
cyl_gnd_sun_z_exp = [0]*(num_row)
dome_sun_r_exp = [0]*(num_row)
dome_sun_th_exp = [0]*(num_row)
dome_sun_phi_exp = [0]*(num_row)

base_shade_r_exp = [0]*(num_row)
base_shade_th_exp = [0]*(num_row)
base_shade_z_exp = [0]*(num_row)
cyl_air_shade_r_exp = [0]*(num_row)
cyl_air_shade_th_exp = [0]*(num_row)
cyl_air_shade_z_exp = [0]*(num_row)
cyl_gnd_shade_r_exp = [0]*(num_row)
cyl_gnd_shade_th_exp = [0]*(num_row)
cyl_gnd_shade_z_exp = [0]*(num_row)
dome_shade_r_exp = [0]*(num_row)
dome_shade_th_exp = [0]*(num_row)
dome_shade_phi_exp = [0]*(num_row)

sliding_sun_r = [0]*(num_row)
sliding_sun_th = [0]*(num_row)
sliding_sun_z = [0]*(num_row)
sliding_shade_r = [0]*(num_row)
sliding_shade_th = [0]*(num_row)
sliding_shade_z = [0]*(num_row)

for i in range(num_row):
    base_shade_r_exp[i] = cyl_exp_r(out['base_shade_rx0'][i],
                                   out['base_shade_ry0'][i],
                                   base_shade_r0,
                                   out['base_shade_rx1'][i],
                                   out['base_shade_ry1'][i],
                                   base_shade_r1,
                                   G_base_shade_r)
    base_shade_th_exp[i] = th_exp(out['base_shade_thx0'][i],
                               out['base_shade_thy0'][i],
                               base_shade_th0,
                               out['base_shade_thx1'][i],
                               out['base_shade_thy1'][i],
                               base_shade_th1,
                               G_base_shade_th)
    cyl_air_shade_r_exp[i] = cyl_exp_r(out['cyl_air_shade_rx0'][i],
                                   out['cyl_air_shade_ry0'][i],
                                   cyl_air_shade_r0,
                                   out['cyl_air_shade_rx1'][i],
                                   out['cyl_air_shade_ry1'][i],
                                   cyl_air_shade_r1,
                                   G_cyl_air_shade_r)
    cyl_air_shade_th_exp[i] = th_exp(out['cyl_air_shade_thx0'][i],
                               out['cyl_air_shade_thy0'][i],
                               cyl_air_shade_th0,
                               out['cyl_air_shade_thx1'][i],
                               out['cyl_air_shade_thy1'][i],
                               cyl_air_shade_th1,
                               G_cyl_air_shade_th)
    cyl_gnd_shade_r_exp[i] = cyl_exp_r(out['cyl_gnd_shade_rx0'][i],
                                   out['cyl_gnd_shade_ry0'][i],
                                   cyl_gnd_shade_r0,
                                   out['cyl_gnd_shade_rx1'][i],
                                   out['cyl_gnd_shade_ry1'][i],
                                   cyl_gnd_shade_r1,
                                   G_cyl_gnd_shade_r)
    cyl_gnd_shade_th_exp[i] = th_exp(out['cyl_gnd_shade_thx0'][i],
                               out['cyl_gnd_shade_thy0'][i],
                               cyl_gnd_shade_th0,
                               out['cyl_gnd_shade_thx1'][i],
                               out['cyl_gnd_shade_thy1'][i],
                               cyl_gnd_shade_th1,
                               G_cyl_gnd_shade_th)
    dome_shade_r_exp[i] = sph_r_exp(out['dome_shade_rx0'][i],
                                out['dome_shade_ry0'][i],
                                out['dome_shade_rz0'][i],
                                dome_shade_r0,
                                out['dome_shade_rx1'][i],
                                out['dome_shade_ry1'][i],
                                out['dome_shade_rz1'][i],
                                dome_shade_r1,
                                G_dome_shade_r)

    dome_shade_th_exp[i] = th_exp(out['dome_shade_thx0'][i],
                                out['dome_shade_thy0'][i],
                                dome_shade_th0,
                                out['dome_shade_thx1'][i],
                                out['dome_shade_thy1'][i],
                                dome_shade_th1,
                                G_dome_shade_th)
    dome_shade_phi_exp[i] = phi_exp(out['dome_shade_phix0'][i],
                                  out['dome_shade_phiy0'][i],
                                  out['dome_shade_phiz0'][i],
                                  dome_shade_phi0,
                                  out['dome_shade_phix1'][i],
                                  out['dome_shade_phiy1'][i],
                                  out['dome_shade_phiz1'][i],
                                  dome_shade_phi1,
                                  G_dome_shade_phi)

    base_sun_r_exp[i] = cyl_exp_r(out['base_sun_rx0'][i],
                                   out['base_sun_ry0'][i],
                                   base_sun_r0,
                                   out['base_sun_rx1'][i],
                                   out['base_sun_ry1'][i],
                                   base_sun_r1,
                                   G_base_sun_r)
    base_sun_th_exp[i] = th_exp(out['base_sun_thx0'][i],
                               out['base_sun_thy0'][i],
                               base_sun_th0,
                               out['base_sun_thx1'][i],
                               out['base_sun_thy1'][i],
                               base_sun_th1,
                               G_base_sun_th)

    cyl_air_sun_r_exp[i] = cyl_exp_r(out['cyl_air_sun_rx0'][i],
                                   out['cyl_air_sun_ry0'][i],
                                   cyl_air_sun_r0,
                                   out['cyl_air_sun_rx1'][i],
                                   out['cyl_air_sun_ry1'][i],
                                   cyl_air_sun_r1,
                                   G_cyl_air_sun_r)
    cyl_air_sun_th_exp[i] = th_exp(out['cyl_air_sun_thx0'][i],
                               out['cyl_air_sun_thy0'][i],
                               cyl_air_sun_th0,
                               out['cyl_air_sun_thx1'][i],
                               out['cyl_air_sun_thy1'][i],
                               cyl_air_sun_th1,
                               G_cyl_air_sun_th)

    cyl_gnd_sun_r_exp[i] = cyl_exp_r(out['cyl_gnd_sun_rx0'][i],
                                   out['cyl_gnd_sun_ry0'][i],
                                   cyl_gnd_sun_r0,
                                   out['cyl_gnd_sun_rx1'][i],
                                   out['cyl_gnd_sun_ry1'][i],
                                   cyl_gnd_sun_r1,
                                   G_cyl_gnd_sun_r)
    cyl_gnd_sun_th_exp[i] = th_exp(out['cyl_gnd_sun_thx0'][i],
                               out['cyl_gnd_sun_thy0'][i],
                               cyl_gnd_sun_th0,
                               out['cyl_gnd_sun_thx1'][i],
                               out['cyl_gnd_sun_thy1'][i],
                               cyl_gnd_sun_th1,
                               G_cyl_gnd_sun_th)

    dome_sun_r_exp[i] = sph_r_exp(out['dome_sun_rx0'][i],
                                out['dome_sun_ry0'][i],
                                out['dome_sun_rz0'][i],
                                dome_sun_r0,
                                out['dome_sun_rx1'][i],
                                out['dome_sun_ry1'][i],
                                out['dome_sun_rz1'][i],
                                dome_sun_r1,
                                G_dome_sun_r)

    dome_sun_th_exp[i] = th_exp(out['dome_sun_thx0'][i],
                                out['dome_sun_thy0'][i],
                                dome_sun_th0,
                                out['dome_sun_thx1'][i],
                                out['dome_sun_thy1'][i],
                                dome_sun_th1,
                                G_dome_sun_th)
    dome_sun_phi_exp[i] = phi_exp(out['dome_sun_phix0'][i],
                                  out['dome_sun_phiy0'][i],
                                  out['dome_sun_phiz0'][i],
                                  dome_sun_phi0,
                                  out['dome_sun_phix1'][i],
                                  out['dome_sun_phiy1'][i],
                                  out['dome_sun_phiz1'][i],
                                  dome_sun_phi1,
                                  G_dome_sun_phi)
    base_shade_z_exp[i] = z_exp(out['base_shade_z'][i],
                              G_base_shade_z)
    cyl_air_shade_z_exp[i] = z_exp(out['cyl_air_shade_z'][i],
                                 G_cyl_air_shade_z)
    cyl_gnd_shade_z_exp[i] = z_exp(out['cyl_gnd_shade_z'][i],
                                 G_cyl_gnd_shade_z)
    base_sun_z_exp[i] = z_exp(out['base_sun_z'][i],
                                G_base_sun_z)
    cyl_air_sun_z_exp[i] = z_exp(out['cyl_air_sun_z'][i],
                                   G_cyl_air_sun_z)
    cyl_gnd_sun_z_exp[i] = z_exp(out['cyl_gnd_sun_z'][i],
                                   G_cyl_gnd_sun_z)

    sliding_shade_r[i] = r_sliding(out['base_bot_shade_x'][i],
                                 out['base_bot_shade_y'][i],
                                 out['base_bot_shade_z'][i],
                                 base_bot_shade,
                                 out['basemat_top_shade_x'][i],
                                 out['basemat_top_shade_y'][i],
                                 out['basemat_top_shade_z'][i],
                                 basemat_top_shade)
    sliding_shade_th[i] = th_sliding(out['base_bot_shade_x'][i],
                                  out['base_bot_shade_y'][i],
                                  out['base_bot_shade_z'][i],
                                  base_bot_shade,
                                  out['basemat_top_shade_x'][i],
                                  out['basemat_top_shade_y'][i],
                                  out['basemat_top_shade_z'][i],
                                  basemat_top_shade)
    sliding_shade_z[i] = z_sliding(out['base_bot_shade_z'][i],out['basemat_top_shade_z'][i])
    sliding_sun_r[i] = r_sliding(out['base_bot_sun_x'][i],
                                 out['base_bot_sun_y'][i],
                                 out['base_bot_sun_z'][i],
                                 base_bot_sun,
                                 out['basemat_top_sun_x'][i],
                                 out['basemat_top_sun_y'][i],
                                 out['basemat_top_sun_z'][i],
                                 basemat_top_sun)
    sliding_sun_th[i] = th_sliding(out['base_bot_sun_x'][i],
                                  out['base_bot_sun_y'][i],
                                  out['base_bot_sun_z'][i],
                                  base_bot_sun,
                                  out['basemat_top_sun_x'][i],
                                  out['basemat_top_sun_y'][i],
                                  out['basemat_top_sun_z'][i],
                                  basemat_top_sun)
    sliding_sun_z[i] = z_sliding(out['base_bot_sun_z'][i],out['basemat_top_sun_z'][i])

## plotting Dome ASR expansion #############################################################################
Dome_fig, Dome_sfig = plt.subplots(5, 3, sharex=True, sharey=False, figsize = (12,8))
plt.subplots_adjust(left=0.08, bottom=0.07, right=0.97, top=0.95, hspace=0.25, wspace=0.31)

[i, j] = [0, 0]
# Dome_sfig[i][j].set_title('ASR exapnsion Radial', fontsize=11)
Dome_sfig[i][j].plot(t, dome_sun_r_exp,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, dome_shade_r_exp,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("Radial [%]")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
# Dome_sfig[i][j].set_title('ASR exapnsion Azimuthal', fontsize=11)
Dome_sfig[i][j].plot(t, dome_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, dome_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("Azimuthal [%]")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
# Dome_sfig[i][j].set_title('ASR exapnsion Altitude', fontsize=11)
Dome_sfig[i][j].plot(t, dome_sun_phi_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, dome_shade_phi_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("Altitude [%]")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
# Dome_sfig[i][j].set_title('ASR_strainxx', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainxx']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainxx']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain xx [%]")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
# Dome_sfig[i][j].set_title('ASR_strainyy', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainyy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainyy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain yy [%]")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 2]
# Dome_sfig[i][j].set_title('ASR_strainzz', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainzz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainzz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain zz [%]")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 0]
# Dome_sfig[i][j].set_title('ASR Strain xy', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainxy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainxy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain xy [%]")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 1]
# Dome_sfig[i][j].set_title('ASR Strain yz', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainyz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainyz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain yz [%]")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 2]
# Dome_sfig[i][j].set_title('ASR Strain zx', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_strainxz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_strainxz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR Strain zx [%]")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 0]
# Dome_sfig[i][j].set_title('ASR extent', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_ex'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_ex'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("ASR extent")
# Dome_sfig[i][j].set_ylim(0,0.04)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 1]
# Dome_sfig[i][j].set_title('vstrain', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_ASR_vstrain'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_ASR_vstrain'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("vol expansion [%]")
# Dome_sfig[i][j].set_ylim(0,0.04)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 2]
# Dome_sfig[i][j].set_title('damage', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_damage_index'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_damage_index'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("Damage index")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 0]
# Dome_sfig[i][j].set_title('rh', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_rh']*100,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_rh']*100,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("RH [%]")
# Dome_sfig[i][j].set_ylim(0,1)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 1]
# Dome_sfig[i][j].set_title('T', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_T'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_T'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("Temperature [\N{DEGREE SIGN}C]")
# Dome_sfig[i][j].set_ylim(0,0.04)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 2]
# Dome_sfig[i][j].set_title('water_content', fontsize=11)
Dome_sfig[i][j].plot(t, out['dome_sun_water_content'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Dome_sfig[i][j].plot(t, out['dome_shade_water_content'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Dome_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Dome_sfig[i][j].set_ylabel("water content")
# Dome_sfig[i][j].set_ylim(0,3)
# Dome_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)



for i in range(5):
    for j in range(3):
        # Dome_sfig[i][j].set_xlim(0, 1)
        # Dome_sfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        Dome_sfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        # Dome_sfig[i][j].set_xlabel("Time [years]")

handles, labels = Dome_sfig[i][j].get_legend_handles_labels()
Dome_fig.legend(handles, labels, loc='upper center',ncol = 2, edgecolor = 'none')
Dome_fig.text(0.5, 0.01, 'Duration of Exposure [year]', ha='center')
plt.savefig(analsis_dir+"Dome_plot.png")









## plotting Cylinder ASR expansion #############################################################################
Cyl_fig, Cyl_sfig = plt.subplots(5, 3, sharex=True, sharey=False, figsize = (12,8))
plt.subplots_adjust(left=0.08, bottom=0.07, right=0.97, top=0.95, hspace=0.25, wspace=0.31)

[i, j] = [0, 0]
# Cyl_sfig[i][j].set_title('ASR exapnsion Radial', fontsize=11)
Cyl_sfig[i][j].plot(t, cyl_air_sun_r_exp,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, cyl_air_shade_r_exp,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, cyl_gnd_sun_r_exp,  c = '0',  linestyle ='dashed', linewidth=1.0, label= 'sun in ground: Radial')
Cyl_sfig[i][j].plot(t, cyl_gnd_shade_r_exp,    c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("Radial [%]")
# Cyl_sfig[i][j].set_ylim(0,1)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
# Cyl_sfig[i][j].set_title('ASR exapnsion Tangential', fontsiz: Tangentiale=11)
Cyl_sfig[i][j].plot(t, cyl_air_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, cyl_air_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, cyl_gnd_sun_th_exp, c = '0',  linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, cyl_gnd_shade_th_exp,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("Tangential [%]")
# Cyl_sfig[i][j].set_ylim(0,1: Vertical)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
# Cyl_sfig[i][j].set_title('ASR exapnsion Vertical', fontsize=11)
Cyl_sfig[i][j].plot(t, cyl_air_sun_z_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, cyl_air_shade_z_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, cyl_gnd_sun_z_exp, c = '0',  linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, cyl_gnd_shade_z_exp,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("Vertical [%]")
# Cyl_sfig[i][j].set_ylim(0,1)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
# Cyl_sfig[i][j].set_title('ASR_strainxx', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainxx']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainxx']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainxx']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainxx']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain xx [%]")
# Cyl_sfig[i][j].set_ylim(0,1)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
# Cyl_sfig[i][j].set_title('ASR_strainyy', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainyy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainyy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainyy']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainyy']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain yy [%]")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 2]
# Cyl_sfig[i][j].set_title('ASR_strainzz', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainzz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainzz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainzz']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainzz']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain zz [%]")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 0]
# Cyl_sfig[i][j].set_title('ASR Strain xy', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainxy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainxy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainxy']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainxy']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain xy [%]")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 1]
# Cyl_sfig[i][j].set_title('ASR Strain yz', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainyz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainyz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainyz']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainyz']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain yz [%]")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 2]
# Cyl_sfig[i][j].set_title('ASR Strain zx', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_strainxz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_strainxz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_strainxz']*1e2,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_strainxz']*1e2,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR Strain zx [%]")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 0]
# Cyl_sfig[i][j].set_title('ASR extent', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_ex'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_ex'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_ex'],   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_ex'],   c = '0.7',    linestyle ='dashed',linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("ASR extent")
# Cyl_sfig[i][j].set_ylim(0,0.04)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 1]
# Cyl_sfig[i][j].set_title('vstrain', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_ASR_vstrain'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_ASR_vstrain'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_ASR_vstrain'],   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_ASR_vstrain'],   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("vol expansion [%]")
# Cyl_sfig[i][j].set_ylim(0,0.04)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 2]
# Cyl_sfig[i][j].set_title('damage', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_damage_index'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_damage_index'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_damage_index'],   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_damage_index'],   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("Damage index")
# Cyl_sfig[i][j].set_ylim(0,1)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 0]
# Cyl_sfig[i][j].set_title('rh', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_rh']*100,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_rh']*100,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_rh']*100,   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_rh']*100,   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("RH [%]")
# Cyl_sfig[i][j].set_ylim(0,1)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 1]
# Cyl_sfig[i][j].set_title('T', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_T'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_T'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_T'],   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_T'],   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("Temperature [\N{DEGREE SIGN}C]")
# Cyl_sfig[i][j].set_ylim(0,0.04)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 2]
# Cyl_sfig[i][j].set_title('water_content', fontsize=11)
Cyl_sfig[i][j].plot(t, out['cyl_air_sun_water_content'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun in air')
Cyl_sfig[i][j].plot(t, out['cyl_air_shade_water_content'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade in air')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_sun_water_content'],   c = '0',    linestyle ='dashed', linewidth=1.0, label= 'sun in ground')
Cyl_sfig[i][j].plot(t, out['cyl_gnd_shade_water_content'],   c = '0.7',    linestyle ='dashed', linewidth=1.0, label= 'shade in ground')
# Cyl_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Cyl_sfig[i][j].set_ylabel("water content")
# Cyl_sfig[i][j].set_ylim(0,3)
# Cyl_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)


for i in range(5):
    for j in range(3):
        # Cyl_sfig[i][j].set_xlim(0, 1)
        # Cyl_sfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        Cyl_sfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        # Cyl_sfig[i][j].set_xlabel("Time [years]")

handles, labels = Cyl_sfig[i][j].get_legend_handles_labels()
Cyl_fig.legend(handles, labels, loc='upper center',ncol = 4, edgecolor = 'none')

Cyl_fig.text(0.5, 0.01, 'Duration of Exposure [year]', ha='center')

plt.savefig(analsis_dir+"Cylinder_plot.png")


















## plotting Base ASR expansion #############################################################################
Base_fig, Base_sfig = plt.subplots(5, 3, sharex=True, sharey=False, figsize = (12,8))
plt.subplots_adjust(left=0.08, bottom=0.07, right=0.97, top=0.95, hspace=0.25, wspace=0.31)

[i, j] = [0, 0]
# Base_sfig[i][j].set_title('ASR exapnsion Radial', fontsize=11)
Base_sfig[i][j].plot(t, base_sun_r_exp,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, base_shade_r_exp,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("Radial [%]")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
# Base_sfig[i][j].set_title('ASR exapnsion Tangential', fontsize=11)
Base_sfig[i][j].plot(t, base_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, base_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("Tangential [%]")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
# Base_sfig[i][j].set_title('ASR exapnsion Vertical', fontsize=11)
Base_sfig[i][j].plot(t, base_sun_z_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, base_shade_z_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("Vertical [%]")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
# Base_sfig[i][j].set_title('ASR_strainxx', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainxx']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainxx']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain xx [%]")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
# Base_sfig[i][j].set_title('ASR_strainyy', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainyy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainyy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain yy [%]")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 2]
# Base_sfig[i][j].set_title('ASR_strainzz', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainzz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainzz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain zz [%]")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 0]
# Base_sfig[i][j].set_title('ASR Strain xy', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainxy']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainxy']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain xy [%]")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 1]
# Base_sfig[i][j].set_title('ASR Strain yz', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainyz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainyz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain yz [%]")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 2]
# Base_sfig[i][j].set_title('ASR Strain zx', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_strainxz']*1e2,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_strainxz']*1e2,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR Strain zx [%]")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 0]
# Base_sfig[i][j].set_title('ASR extent', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_ex'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_ex'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("ASR extent")
# Base_sfig[i][j].set_ylim(0,0.04)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 1]
# Base_sfig[i][j].set_title('vstrain', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_ASR_vstrain'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_ASR_vstrain'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("vol expansion [%]")
# Base_sfig[i][j].set_ylim(0,0.04)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 2]
# Base_sfig[i][j].set_title('damage', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_damage_index'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_damage_index'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("Damage index")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 0]
# Base_sfig[i][j].set_title('rh', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_rh']*100,   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_rh']*100,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("RH [%]")
# Base_sfig[i][j].set_ylim(0,1)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 1]
# Base_sfig[i][j].set_title('T', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_T'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_T'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("Temperature [\N{DEGREE SIGN}C]")
# Base_sfig[i][j].set_ylim(0,0.04)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [4, 2]
# Base_sfig[i][j].set_title('water_content', fontsize=11)
Base_sfig[i][j].plot(t, out['base_sun_water_content'],   c = '0',    linestyle ='solid', linewidth=1.0, label= 'sun')
Base_sfig[i][j].plot(t, out['base_shade_water_content'],   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Base_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Base_sfig[i][j].set_ylabel("water content")
# Base_sfig[i][j].set_ylim(0,3)
# Base_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)


for i in range(5):
    for j in range(3):
        # Base_sfig[i][j].set_xlim(0, 1)
        # Base_sfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        Base_sfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        # Base_sfig[i][j].set_xlabel("Time [years]")

handles, labels = Base_sfig[i][j].get_legend_handles_labels()
Base_fig.legend(handles, labels, loc='upper center',ncol = 2, edgecolor = 'none')

Base_fig.text(0.5, 0.01, 'Duration of Exposure [year]', ha='center')

plt.savefig(analsis_dir+"Base_plot.png")














## plotting sliding expansion #############################################################################
Sliding_fig, Sliding_sfig = plt.subplots(2, 3, sharex=True, sharey=False, figsize = (12,4))
plt.subplots_adjust(left=0.08, bottom=0.1, right=0.97, top=0.9, hspace=0.25, wspace=0.31)

[i, j] = [0, 0]
# Sliding_sfig[i][j].set_title('Sliding', fontsize=11)
Sliding_sfig[i][j].plot(t, sliding_sun_r,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Sliding_sfig[i][j].plot(t, sliding_shade_r,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Sliding_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Sliding_sfig[i][j].set_ylabel("Radial [%]")
# Sliding_sfig[i][j].set_ylim(0,1)
# Sliding_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
# Sliding_sfig[i][j].set_title('Sliding', fontsize=11)
Sliding_sfig[i][j].plot(t, sliding_sun_th,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Sliding_sfig[i][j].plot(t, sliding_shade_th,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Sliding_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Sliding_sfig[i][j].set_ylabel("Tangential [%]")
# Sliding_sfig[i][j].set_ylim(0,1)
# Sliding_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
# Sliding_sfig[i][j].set_title('Sliding', fontsize=11)
Sliding_sfig[i][j].plot(t, sliding_sun_z,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
Sliding_sfig[i][j].plot(t, sliding_shade_z,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')# Sliding_sfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
Sliding_sfig[i][j].set_ylabel("Vertical [%]")
# Sliding_sfig[i][j].set_ylim(0,1)
# Sliding_sfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

for i in range(2):
    for j in range(3):
        # Sliding_sfig[i][j].set_xlim(0, 1)
        # Sliding_sfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        Sliding_sfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        # Sliding_sfig[i][j].set_xlabel("Time [years]")

handles, labels = Sliding_sfig[i][j].get_legend_handles_labels()
Sliding_fig.legend(handles, labels, loc='upper center',ncol = 2, edgecolor = 'none')

Sliding_fig.text(0.5, 0.01, 'Duration of Exposure [year]', ha='center')

plt.savefig(analsis_dir+"sliding_plot.png")


# plt.show()
