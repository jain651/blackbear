import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math

# out_file_loc = './test/tests/concrete_ASR_swelling/outputs/containment_str/'
out_file_loc = './test/tests/concrete_ASR_swelling/'
out_file_name = out_file_loc+'ContainmentVessel3D_180_v3_out.csv'
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

base_bot_shade =      [16.000,  16.000, -2.890]
base_bot_sun =    [16.000, -16.000, -2.890]
basemat_top_shade =   [16.000,  16.000, -2.900]
basemat_top_sun = [16.000, -16.000, -2.900]

G_base_shade_r =      math.sqrt(base_shade_r1[0]**2 + base_shade_r1[1]**2) - math.sqrt(base_shade_r0[0]**2 + base_shade_r0[1]**2)
G_base_shade_th =     math.atan((base_shade_th1[1])/(base_shade_th1[0])) - math.atan((base_shade_th0[1])/(base_shade_th0[0]))
G_base_shade_z =      base_shade_z1[2] - base_shade_z0[2]

G_base_sun_r =    math.sqrt(base_sun_r1[0]**2 + base_sun_r1[1]**2) - math.sqrt(base_sun_r0[0]**2 + base_sun_r0[1]**2)
G_base_sun_th =   math.atan((base_sun_th1[1])/(base_sun_th1[0])) - math.atan((base_sun_th0[1])/(base_sun_th0[0]))
G_base_sun_z =    base_sun_z1[2] - base_sun_z0[2]

G_cyl_air_shade_r =   math.sqrt(cyl_air_shade_r1[0]**2 + cyl_air_shade_r1[1]**2) - math.sqrt(cyl_air_shade_r0[0]**2 + cyl_air_shade_r0[1]**2)
G_cyl_air_shade_th =  math.atan((cyl_air_shade_th1[1])/(cyl_air_shade_th1[0])) - math.atan((cyl_air_shade_th0[1])/(cyl_air_shade_th0[0]))
G_cyl_air_shade_z =   cyl_air_shade_z1[2] - cyl_air_shade_z0[2]

G_cyl_air_sun_r = math.sqrt(cyl_air_sun_r1[0]**2 + cyl_air_sun_r1[1]**2) - math.sqrt(cyl_air_sun_r0[0]**2 + cyl_air_sun_r0[1]**2)
G_cyl_air_sun_th =math.atan((cyl_air_sun_th1[1])/(cyl_air_sun_th1[0])) - math.atan((cyl_air_sun_th0[1])/(cyl_air_sun_th0[0]))
G_cyl_air_sun_z = cyl_air_sun_z1[2] - cyl_air_sun_z0[2]

G_cyl_gnd_shade_r =   math.sqrt(cyl_gnd_shade_r1[0]**2 + cyl_gnd_shade_r1[1]**2) - math.sqrt(cyl_gnd_shade_r0[0]**2 + cyl_gnd_shade_r0[1]**2)
G_cyl_gnd_shade_th =  math.atan((cyl_gnd_shade_th1[1])/(cyl_gnd_shade_th1[0])) - math.atan((cyl_gnd_shade_th0[1])/(cyl_gnd_shade_th0[0]))
G_cyl_gnd_shade_z =   cyl_gnd_shade_z1[2] - cyl_gnd_shade_z0[2]

G_cyl_gnd_sun_r = math.sqrt(cyl_gnd_sun_r1[0]**2 + cyl_gnd_sun_r1[1]**2) - math.sqrt(cyl_gnd_sun_r0[0]**2 + cyl_gnd_sun_r0[1]**2)
G_cyl_gnd_sun_th =math.atan((cyl_gnd_sun_th1[1])/(cyl_gnd_sun_th1[0])) - math.atan((cyl_gnd_sun_th0[1])/(cyl_gnd_sun_th0[0]))
G_cyl_gnd_sun_z = cyl_gnd_sun_z1[2] - cyl_gnd_sun_z0[2]

G_dome_shade_r =      math.sqrt(dome_shade_r1[0]**2 + dome_shade_r1[1]**2 + dome_shade_r1[2]**2) - math.sqrt(dome_shade_r0[0]**2 + dome_shade_r0[1]**2 + dome_shade_r0[2]**2)
G_dome_shade_th =     math.atan(dome_shade_th1[1]/dome_shade_th1[0]) - math.atan(dome_shade_th0[1]/dome_shade_th0[0])
G_dome_shade_phi =    math.atan(dome_shade_phi1[2]/math.sqrt(dome_shade_phi1[0]**2+dome_shade_phi1[1]**2)) - math.atan(dome_shade_phi0[2]/math.sqrt(dome_shade_phi0[0]**2+dome_shade_phi0[1]**2))

G_dome_sun_r =    math.sqrt(dome_sun_r1[0]**2 + dome_sun_r1[1]**2 + dome_sun_r1[2]**2) - math.sqrt(dome_sun_r0[0]**2 + dome_sun_r0[1]**2 + dome_sun_r0[2]**2)
G_dome_sun_th =   math.atan(dome_sun_th1[1]/dome_sun_th1[0]) - math.atan(dome_sun_th0[1]/dome_sun_th0[0])
G_dome_sun_phi =  math.atan(dome_sun_phi1[2]/math.sqrt(dome_sun_phi1[0]**2+dome_sun_phi1[1]**2)) - math.atan(dome_sun_phi0[2]/math.sqrt(dome_sun_phi0[0]**2+dome_sun_phi0[1]**2))

def rad_exp_cyl(dx0,dy0,loc0,dx1,dy1,loc1,G):
    return ((math.sqrt((loc1[0]+dx1)**2 + (loc1[1]+dy1)**2) - math.sqrt((loc0[0]+dx0)**2 + (loc0[1]+dy0)**2)) / G - 1)*100
def rad_exp_sph(dx0,dy0,dz0,loc0,dx1,dy1,dz1,loc1,G):
    return ((math.sqrt((loc1[0]+dx1)**2 + (loc1[1]+dy1)**2 + (loc1[2]+dz1)**2) - math.sqrt((loc0[0]+dx0)**2 + (loc0[1]+dy0)**2 + (loc0[2]+dz0)**2)) / G -1)*100
def th_exp(dx0,dy0,loc0,dx1,dy1,loc1,G):
    return ((math.atan((loc1[1]+dy1)/(loc1[0]+dx1)) - math.atan((loc0[1]+dy0)/(loc0[0]+dx0))) / G -1)*100
def z_exp(expansion,G):
    return  expansion / G * 100
def phi_exp(dx0,dy0,dz0,loc0,dx1,dy1,dz1,loc1,G):
    return ((math.atan((loc1[2]+dz1)/math.sqrt((loc1[0]+dx1)**2+(loc1[1]+dy1)**2)) - math.atan((loc0[2]+dz0)/math.sqrt((loc0[0]+dx0)**2+(loc0[1]+dy0)**2))) / G -1)*100
def sliding_r(dx_top,dy_top,dz_top,loc_top,dx_bot,dy_bot,dz_bot,loc_bot):
    return (math.sqrt(((loc_top[0]+dx_top)**2+(loc_top[1]+dy_top)**2)/(loc_top[0]**2+loc_top[1]**2)) - math.sqrt(((loc_bot[0]+dx_bot)**2+(loc_bot[1]+dy_bot)**2)/(loc_bot[0]**2+loc_bot[1]**2)))*1000
def sliding_th(dx_top,dy_top,dz_top,loc_top,dx_bot,dy_bot,dz_bot,loc_bot):
    return (math.atan((loc_top[1]+dy_top)/(loc_top[0]+dx_top)) - math.atan((loc_bot[1]+dy_bot)/(loc_bot[0]+dx_bot)))*180/math.pi
def sliding_z(dz_top,dz_bot):
    return (dz_top-dz_bot)*1000

t = out['time']/86400/365
num_row = len(t)
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
dome_sun_phi_exp         = [0]*(num_row)

sliding_shade_r = [0]*(num_row)
sliding_shade_th = [0]*(num_row)
sliding_shade_z = [0]*(num_row)
sliding_sun_r = [0]*(num_row)
sliding_sun_th = [0]*(num_row)
sliding_sun_z = [0]*(num_row)

for i in range(num_row):
    base_shade_r_exp[i] = rad_exp_cyl(out['base_shade_rx0'][i],
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
    cyl_air_shade_r_exp[i] = rad_exp_cyl(out['cyl_air_shade_rx0'][i],
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
    cyl_gnd_shade_r_exp[i] = rad_exp_cyl(out['cyl_gnd_shade_rx0'][i],
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
    dome_shade_r_exp[i] = rad_exp_sph(out['dome_shade_rx0'][i],
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

    base_sun_r_exp[i] = rad_exp_cyl(out['base_sun_rx0'][i],
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

    cyl_air_sun_r_exp[i] = rad_exp_cyl(out['cyl_air_sun_rx0'][i],
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

    cyl_gnd_sun_r_exp[i] = rad_exp_cyl(out['cyl_gnd_sun_rx0'][i],
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

    dome_sun_r_exp[i] = rad_exp_sph(out['dome_sun_rx0'][i],
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

    sliding_shade_r[i] = sliding_r(out['base_bot_shade_x'][i],
                                 out['base_bot_shade_y'][i],
                                 out['base_bot_shade_z'][i],
                                 base_bot_shade,
                                 out['basemat_top_shade_x'][i],
                                 out['basemat_top_shade_y'][i],
                                 out['basemat_top_shade_z'][i],
                                 basemat_top_shade)
    sliding_shade_th[i] = sliding_th(out['base_bot_shade_x'][i],
                                  out['base_bot_shade_y'][i],
                                  out['base_bot_shade_z'][i],
                                  base_bot_shade,
                                  out['basemat_top_shade_x'][i],
                                  out['basemat_top_shade_y'][i],
                                  out['basemat_top_shade_z'][i],
                                  basemat_top_shade)
    sliding_shade_z[i] = sliding_z(out['base_bot_shade_z'][i],out['basemat_top_shade_z'][i])
    sliding_sun_r[i] = sliding_r(out['base_bot_sun_x'][i],
                                 out['base_bot_sun_y'][i],
                                 out['base_bot_sun_z'][i],
                                 base_bot_sun,
                                 out['basemat_top_sun_x'][i],
                                 out['basemat_top_sun_y'][i],
                                 out['basemat_top_sun_z'][i],
                                 basemat_top_sun)
    sliding_sun_th[i] = sliding_th(out['base_bot_sun_x'][i],
                                  out['base_bot_sun_y'][i],
                                  out['base_bot_sun_z'][i],
                                  base_bot_sun,
                                  out['basemat_top_sun_x'][i],
                                  out['basemat_top_sun_y'][i],
                                  out['basemat_top_sun_z'][i],
                                  basemat_top_sun)
    sliding_sun_z[i] = sliding_z(out['base_bot_sun_z'][i],out['basemat_top_sun_z'][i])


## plotting surface average ASR expansion #############################################################################
ASR_fig, ASR_subfig = plt.subplots(4, 3, sharex=True, sharey=False, figsize = (12,8))
plt.subplots_adjust(left=0.08, bottom=0.07, right=0.97, top=0.95, hspace=0.25, wspace=0.31)

[i, j] = [0, 0]
ASR_subfig[i][j].set_title('Dome-Radial', fontsize=11)
ASR_subfig[i][j].plot(t, dome_sun_r_exp,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, dome_shade_r_exp,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 1]
ASR_subfig[i][j].set_title('Dome-Azimuthal', fontsize=11)
ASR_subfig[i][j].plot(t, dome_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, dome_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [0, 2]
ASR_subfig[i][j].set_title('Dome-Altitude', fontsize=11)
ASR_subfig[i][j].plot(t, dome_sun_phi_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, dome_shade_phi_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 0]
ASR_subfig[i][j].set_title('Cylinder-Radial', fontsize=11)
ASR_subfig[i][j].plot(t, cyl_air_sun_r_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun above ground')
ASR_subfig[i][j].plot(t, cyl_air_shade_r_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade above ground')
ASR_subfig[i][j].plot(t, cyl_gnd_sun_r_exp, c = '0',  linestyle ='dashed',  linewidth=1.0, label= 'sun under ground')
ASR_subfig[i][j].plot(t, cyl_gnd_shade_r_exp,   c = '0.7',    linestyle ='dashed',  linewidth=1.0, label= 'shade under ground')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 1]
ASR_subfig[i][j].set_title('Cylinder-Tangential', fontsize=11)
ASR_subfig[i][j].plot(t, cyl_air_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun above ground')
ASR_subfig[i][j].plot(t, cyl_air_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade above ground')
ASR_subfig[i][j].plot(t, cyl_gnd_sun_th_exp, c = '0',  linestyle ='dashed',  linewidth=1.0, label= 'sun under ground')
ASR_subfig[i][j].plot(t, cyl_gnd_shade_th_exp,   c = '0.7',    linestyle ='dashed',  linewidth=1.0, label= 'shade under ground')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [1, 2]
ASR_subfig[i][j].set_title('Cylinder-Vertical', fontsize=11)
ASR_subfig[i][j].plot(t, cyl_air_sun_z_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun above ground')
ASR_subfig[i][j].plot(t, cyl_air_shade_z_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade above ground')
ASR_subfig[i][j].plot(t, cyl_gnd_sun_z_exp, c = '0',  linestyle ='dashed',  linewidth=1.0, label= 'sun under ground')
ASR_subfig[i][j].plot(t, cyl_gnd_shade_z_exp,   c = '0.7',    linestyle ='dashed',  linewidth=1.0, label= 'shade under ground')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,0.04)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 0]
ASR_subfig[i][j].set_title('Base-Radial', fontsize=11)
ASR_subfig[i][j].plot(t, base_sun_r_exp,  c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, base_shade_r_exp,    c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 1]
ASR_subfig[i][j].set_title('Base-Tangential', fontsize=11)
ASR_subfig[i][j].plot(t, base_sun_th_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, base_shade_th_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [2, 2]
ASR_subfig[i][j].set_title('Base-Vertical', fontsize=11)
ASR_subfig[i][j].plot(t, base_sun_z_exp, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, base_shade_z_exp,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("ASR expansion [%]")
# ASR_subfig[i][j].set_ylim(0,1)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 0]
ASR_subfig[i][j].set_title('Sliding-Radial', fontsize=11)
ASR_subfig[i][j].plot(t, sliding_sun_r, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, sliding_shade_r,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Sliding [mm]")
# ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 1]
ASR_subfig[i][j].set_title('Sliding-Tangential', fontsize=11)
ASR_subfig[i][j].plot(t, sliding_sun_th, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, sliding_shade_th,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Sliding [\u00B0]")
# ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

[i, j] = [3, 2]
ASR_subfig[i][j].set_title('Sliding-Vertical', fontsize=11)
ASR_subfig[i][j].plot(t, sliding_sun_z, c = '0',  linestyle ='solid', linewidth=1.0, label= 'sun')
ASR_subfig[i][j].plot(t, sliding_shade_z,   c = '0.7',    linestyle ='solid', linewidth=1.0, label= 'shade')
# ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
ASR_subfig[i][j].set_ylabel("Sliding [mm]")
# ASR_subfig[i][j].set_ylim(0,3)
ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)

for i in range(4):
    for j in range(3):
        # ASR_subfig[i][j].set_xlim(0, 1)
        # ASR_subfig[i][j].xaxis.set_minor_locator(MultipleLocator(10))
        ASR_subfig[i][j].grid(color="grey", ls = '--', lw = 0.5)
        # ASR_subfig[i][j].set_xlabel("Time [years]")

# STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# place_image(STT_image, loc='lower right', ax=ASR_subfig[i][j], pad=0, zoom=0.18)
plt.show()


# [i, j] = [0, 3]
# ASR_subfig[i][j].set_title('Temperature in air', fontsize=11)
# ASR_subfig[i][j].plot(t, out['temp'],  c = '0',    linestyle ='solid', linewidth=1.0, label= 'Temperature in air')
# # ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].set_ylabel("Temperature")
# ASR_subfig[i][j].set_ylim(0,15)
# ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)
#
# [i, j] = [1, 3]
# ASR_subfig[i][j].set_title('RH in air ', fontsize=11)
# ASR_subfig[i][j].plot(t, out['humidity']*100,  c = '0',    linestyle ='solid', linewidth=1.0, label= 'RH in air')
# # ASR_subfig[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# ASR_subfig[i][j].set_ylabel("Relative humidity [%]")
# ASR_subfig[i][j].set_ylim(0,100)
# ASR_subfig[i][j].legend(loc='best', facecolor='1.0', framealpha=0.5, edgecolor = 'none', ncol=1)
#
