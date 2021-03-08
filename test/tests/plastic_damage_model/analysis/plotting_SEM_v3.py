import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox, AnchoredOffsetbox
from numpy import *
import numpy as np
import pandas as pd
import math

# Tension test
uni_ten_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_ten_v3.csv')

multiaxial1_ten_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/multiaxial1_ten_v3.csv')
multiaxial2_ten_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/multiaxial2_ten_v3.csv')

# Mesh sensitivity test
uni_ten_msh_sen_1ele_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_ten_msh_sen_1ele_v3.csv')
uni_ten_msh_sen_2ele_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_ten_msh_sen_2ele_v3.csv')
uni_ten_msh_sen_4ele_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_ten_msh_sen_4ele_v3.csv')

# Compression test
uni_cmp_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_cmp_v3.csv')
# bi_cmp_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/bi_cmp_v3.csv')

multiaxial1_cmp_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/multiaxial1_cmp_v3.csv')
multiaxial2_cmp_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/multiaxial2_cmp_v3.csv')

# Dilatancy test
uni_cmp_dila_ap_02_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_cmp_dila_ap_02_v3.csv')
uni_cmp_dila_ap_025_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_cmp_dila_ap_025_v3.csv')
uni_cmp_dila_ap_03_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/uni_cmp_dila_ap_03_v3.csv')

# Calculation of volumetric strain for Dilatancy test
vol_strain_ap_02_v3 = uni_cmp_dila_ap_02_v3['e_xx'] + uni_cmp_dila_ap_02_v3['e_yy'] + uni_cmp_dila_ap_02_v3['e_zz'] + uni_cmp_dila_ap_02_v3['max_ep'] + uni_cmp_dila_ap_02_v3['mid_ep'] + uni_cmp_dila_ap_02_v3['min_ep']
vol_strain_ap_025_v3 = uni_cmp_dila_ap_025_v3['e_xx'] + uni_cmp_dila_ap_025_v3['e_yy'] + uni_cmp_dila_ap_025_v3['e_zz'] + uni_cmp_dila_ap_025_v3['max_ep'] + uni_cmp_dila_ap_025_v3['mid_ep'] + uni_cmp_dila_ap_025_v3['min_ep']
vol_strain_ap_03_v3 = uni_cmp_dila_ap_03_v3['e_xx'] + uni_cmp_dila_ap_03_v3['e_yy'] + uni_cmp_dila_ap_03_v3['e_zz'] + uni_cmp_dila_ap_03_v3['max_ep'] + uni_cmp_dila_ap_03_v3['mid_ep'] + uni_cmp_dila_ap_03_v3['min_ep']

# Shear Cyclic Loading
shr_cyclic_v3 = pd.read_csv('./test/tests/plastic_damage_model/output/shr_cyclic_v3.csv')

# Lee results
Lee_uni_ten = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_ten.csv', header=None)
Lee_uni_cmp = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_cmp.csv', header=None)
Lee_bi_ten = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_bi_ten.csv', header=None)
Lee_bi_cmp = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_bi_cmp.csv', header=None)
Lee_cyc_uni_ten = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_cyc_uni_ten.csv', header=None)
Lee_cyc_uni_cmp = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_cmp.csv', header=None)
Lee_cyc_uni_ten_cmp = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_cyc_uni_ten_cmp.csv', header=None)
Lee_cyc_shr = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_cyc_shr.csv', header=None)
Lee_dila_ap_02 = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_dila_ap_02.csv', header=None)
Lee_dila_ap_025 = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_dila_ap_025.csv', header=None)
Lee_dila_ap_03 = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_dila_ap_03.csv', header=None)
Lee_uni_ten_msh_sen_2_elem = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_ten_msh_sen_2_elem.csv', header=None)
Lee_uni_ten_msh_sen_4_elem = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_ten_msh_sen_4_elem.csv', header=None)
Lee_uni_ten_msh_sen_8_elem = pd.read_csv('./test/tests/plastic_damage_model/analysis/Lee_uni_ten_msh_sen_8_elem.csv', header=None)

# function to put image
def place_image(im, loc=3, ax=None, zoom=1, **kw):
    if ax==None: ax=plt.gca()
    imagebox = OffsetImage(im, zoom=zoom*0.72)
    ab = AnchoredOffsetbox(loc=loc, child=imagebox, frameon=False, **kw)
    ax.add_artist(ab)

## plotting Single Element Model (SEM) response
#############################################################################
SEM, SEM_ax = plt.subplots(2,2, sharex=False, sharey=False, figsize = (10,8))
plt.subplots_adjust(left=0.08, bottom=0.1, right=0.95, top=0.95, wspace = 0.25, hspace = 0.3)
# SEM.text(0.03, 0.5, 'Force [N]', va='center', rotation='vertical')
# SEM.text(0.5, 0.05, 'Deformation [mm]', ha='center')

[i, j] = [0, 0]
SEM_ax[i][j].set_title('Multi-axial Tensile Loading', fontsize=11)
SEM_ax[i][j].plot(Lee_uni_ten[0], Lee_uni_ten[1], c = '0.6', linestyle ='solid', linewidth=1.0, label= 'Uniaxial (Lee)')
SEM_ax[i][j].plot(Lee_bi_ten[0] , Lee_bi_ten[1],  c = '0.6', linestyle ='dashdot', linewidth=1.0, label= 'Biaxial (Lee)')
SEM_ax[i][j].plot(multiaxial1_ten_v3['displacement_x']/25.4, multiaxial1_ten_v3['s_xx'], c = '0', linestyle ='solid',   linewidth=1.0, label= 'Uniaxial_v3')
SEM_ax[i][j].plot(multiaxial2_ten_v3['displacement_x']/25.4, multiaxial2_ten_v3['s_xx'], c = '0', linestyle ='dashdot', linewidth=1.0, label= 'Biaxial_v3')

SEM_ax[i][j].grid(color="grey", ls = '--', lw = 0.5)
# SEM_ax[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# SEM_ax[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
SEM_ax[i][j].set_xlabel("Strain [m/m]")
SEM_ax[i][j].set_ylabel("Stress [MPa]")
# SEM_ax[i][j].set_xlim(0, 0.001)
# SEM_ax[i][j].set_ylim(0,0.15)
# STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# place_image(STT_image, loc='lower right', ax=SEM_ax[i][j], pad=0, zoom=0.18)
SEM_ax[i][j].legend(loc='upper right', facecolor = 'white', framealpha = 0.4, edgecolor ='none')


[i, j] = [0, 1]
SEM_ax[i][j].set_title('Multi-axial Compressive Loading', fontsize=11)
SEM_ax[i][j].plot(-1*Lee_uni_cmp[0], -1*Lee_uni_cmp[1], c = '0.6', linestyle ='solid', linewidth=1.0, label= 'Uniaxial (Lee)')
SEM_ax[i][j].plot(-1*Lee_bi_cmp[0] , -1*Lee_bi_cmp[1],  c = '0.6', linestyle ='dashdot', linewidth=1.0, label= 'Biaxial (Lee)')
SEM_ax[i][j].plot(-1*multiaxial1_cmp_v3['displacement_x']/25.4, -1*multiaxial1_cmp_v3['s_xx'], c = '0', linestyle ='solid',   linewidth=1.0, label= 'Uniaxial (Model)')
SEM_ax[i][j].plot(-1*multiaxial2_cmp_v3['displacement_x']/25.4, -1*multiaxial2_cmp_v3['s_xx'], c = '0', linestyle ='dashdot', linewidth=1.0, label= 'Biaxial (Model)')
SEM_ax[i][j].grid(color="grey", ls = '--', lw = 0.5)
# SEM_ax[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# SEM_ax[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
SEM_ax[i][j].set_ylabel("Force [N]")
SEM_ax[i][j].set_xlabel("Deformation [mm]")
# SEM_ax[i][j].set_xlim(0, 0.01)
# SEM_ax[i][j].set_ylim(0,35)
SEM_ax[i][j].legend(loc='lower center', facecolor = 'white', framealpha = 0.4, edgecolor ='none')


# [i, j] = [0, 2]
# SEM_ax[i][j].set_title('Shear Cyclic Loading', fontsize=11)
# SEM_ax[i][j].plot(Lee_cyc_shr[0], Lee_cyc_shr[1], c = '0.6', linestyle ='solid', linewidth=1.0, label= 'Uniaxial (Lee)')
# SEM_ax[i][j].plot(shr_cyclic_v3['displacement_x']/25.4, shr_cyclic_v3['s_xy'], c = '0', linestyle ='solid',   linewidth=1.0, label= 'Uniaxial_v3')
# SEM_ax[i][j].grid(color="grey", ls = '--', lw = 0.5)
# # SEM_ax[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# # SEM_ax[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
# SEM_ax[i][j].set_xlabel("Strain [m/m]")
# SEM_ax[i][j].set_ylabel("Stress [MPa]")
# # SEM_ax[i][j].set_xlim(0, 0.001)
# # SEM_ax[i][j].set_ylim(0,0.15)
# # STT_image = mpimg.imread('./test/tests/plastic_damage_model_2017/analysis/STT.png')
# # place_image(STT_image, loc='lower right', ax=SEM_ax[i][j], pad=0, zoom=0.18)
# SEM_ax[i][j].legend(loc='lower right', facecolor = 'white', framealpha = 0.4, edgecolor ='none')



[i, j] = [1, 0]
SEM_ax[i][j].set_title('Mesh sensitivity', fontsize=11)
SEM_ax[i][j].plot(Lee_uni_ten_msh_sen_2_elem[0], Lee_uni_ten_msh_sen_2_elem[1], c = '0.6', linestyle ='solid', linewidth=1.0, label= '1 element (Lee)')
SEM_ax[i][j].plot(Lee_uni_ten_msh_sen_4_elem[0], Lee_uni_ten_msh_sen_4_elem[1], c = '0.6', linestyle ='dashdot', linewidth=1.0, label= '2 elements (Lee)')
SEM_ax[i][j].plot(Lee_uni_ten_msh_sen_8_elem[0], Lee_uni_ten_msh_sen_8_elem[1], c = '0.6', linestyle ='dashed', linewidth=1.0, label= '4 elements (Lee)')
SEM_ax[i][j].plot(uni_ten_msh_sen_1ele_v3['displacement_x'], -1*uni_ten_msh_sen_1ele_v3['react_x'], c = '0', linestyle ='solid', linewidth=1.0, label= '1 element (Model)')
SEM_ax[i][j].plot(uni_ten_msh_sen_2ele_v3['displacement_x'], -1*uni_ten_msh_sen_2ele_v3['react_x'], c = '0', linestyle ='dashdot', linewidth=1.0, label= '2 elements (Model)')
SEM_ax[i][j].plot(uni_ten_msh_sen_4ele_v3['displacement_x'], -1*uni_ten_msh_sen_4ele_v3['react_x'], c = '0', linestyle ='dashed', linewidth=1.0, label= '4 elements (Model)')
SEM_ax[i][j].grid(color="grey", ls = '--', lw = 0.5)
# SEM_ax[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# SEM_ax[i][j].yaxis.set_minor_locator(MultipleLocator(0.01))
SEM_ax[i][j].set_ylabel("Force [N]")
SEM_ax[i][j].set_xlabel("Deformation [mm]")
SEM_ax[i][j].set_xlim(0, 0.02)
SEM_ax[i][j].set_ylim(0,90)
SEM_ax[i][j].legend(loc='upper right', facecolor = 'white', framealpha = 0.4, edgecolor ='none')


[i, j] = [1, 1]
SEM_ax[i][j].set_title('Dilatancy check', fontsize=11)
SEM_ax[i][j].plot(Lee_dila_ap_02[0],  -1*Lee_dila_ap_02[1],  'k', marker='o', ms=3, linewidth=1.0, label= '$\\alpha_p$ = 0.20 (Lee)')
SEM_ax[i][j].plot(Lee_dila_ap_025[0], -1*Lee_dila_ap_025[1], 'r', marker='o', ms=3, linewidth=1.0, label= '$\\alpha_p$ = 0.25 (Lee)')
SEM_ax[i][j].plot(Lee_dila_ap_03[0],  -1*Lee_dila_ap_03[1],  'b', marker='o', ms=3, linewidth=1.0, label= '$\\alpha_p$ = 0.30 (Lee)')
SEM_ax[i][j].plot(vol_strain_ap_02_v3, -1*uni_cmp_dila_ap_02_v3['s_xx'], 'k', linewidth=1.0, label= '$\\alpha_p$ = 0.12 (Model)')
SEM_ax[i][j].plot(vol_strain_ap_025_v3, -1*uni_cmp_dila_ap_025_v3['s_xx'], 'r', linewidth=1.0, label= '$\\alpha_p$ = 0.15 (Model)')
SEM_ax[i][j].plot(vol_strain_ap_03_v3, -1*uni_cmp_dila_ap_03_v3['s_xx'], 'b', linewidth=1.0, label= '$\\alpha_p$ = 0.20 (Model)')
SEM_ax[i][j].grid(color="grey", ls = '--', lw = 0.5)
# SEM_ax[i][j].xaxis.set_minor_locator(MultipleLocator(0.2))
# SEM_ax[i][j].yaxis.set_minor_locator(MultipleLocator(0.2))
SEM_ax[i][j].set_ylabel("Force [N]")
SEM_ax[i][j].set_xlabel("Deformation [mm]")
SEM_ax[i][j].set_xlim(-0.001, 0.004)
# SEM_ax[i][j].set_ylim(0,0.15)
SEM_ax[i][j].legend(loc='upper right', facecolor = 'white', framealpha = 0.4, edgecolor ='none')

plt.show()
