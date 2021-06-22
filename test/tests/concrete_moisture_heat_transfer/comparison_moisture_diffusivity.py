import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math

out_file_dir = './test/tests/concrete_moisture_heat_transfer/'
bazant_Dh = pd.read_csv(out_file_dir+'humidity_diffusion_bazant_out.csv')
mensi_Dh = pd.read_csv(out_file_dir+'humidity_diffusion_mensi_out.csv')

## plotting moisture diffusivity comparison ####################################################
DH_fig, DH_sfig = plt.subplots(5, sharex=True, sharey=True, figsize = (4,8))
plt.subplots_adjust(left=0.18, bottom=0.10, right=0.90, top=0.97, hspace = 0.3)

i = 0
DH_sfig[i].set_title('RH = 1', fontsize=11)
DH_sfig[i].plot(bazant_Dh['temperature'][635*i+1:635*(i+1)+1], bazant_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'k',  linestyle ='solid', linewidth=1.0, label= 'Bazant')
DH_sfig[i].plot(mensi_Dh['temperature'][635*i+1:635*(i+1)+1], mensi_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'r',  linestyle ='solid', linewidth=1.0, label= 'Mensi')

i = 1
DH_sfig[i].set_title('RH = 0.8', fontsize=11)
DH_sfig[i].plot(bazant_Dh['temperature'][635*i+1:635*(i+1)+1], bazant_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'k',  linestyle ='solid', linewidth=1.0, label= 'Bazant')
DH_sfig[i].plot(mensi_Dh['temperature'][635*i+1:635*(i+1)+1], mensi_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'r',  linestyle ='solid', linewidth=1.0, label= 'Mensi')

i = 2
DH_sfig[i].set_title('RH = 0.6', fontsize=11)
DH_sfig[i].plot(bazant_Dh['temperature'][635*i+1:635*(i+1)+1], bazant_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'k',  linestyle ='solid', linewidth=1.0, label= 'Bazant')
DH_sfig[i].plot(mensi_Dh['temperature'][635*i+1:635*(i+1)+1], mensi_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'r',  linestyle ='solid', linewidth=1.0, label= 'Mensi')

i = 3
DH_sfig[i].set_title('RH = 0.4', fontsize=11)
DH_sfig[i].plot(bazant_Dh['temperature'][635*i+1:635*(i+1)+1], bazant_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'k',  linestyle ='solid', linewidth=1.0, label= 'Bazant')
DH_sfig[i].plot(mensi_Dh['temperature'][635*i+1:635*(i+1)+1], mensi_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'r',  linestyle ='solid', linewidth=1.0, label= 'Mensi')

i = 4
DH_sfig[i].set_title('RH = 0.2', fontsize=11)
DH_sfig[i].plot(bazant_Dh['temperature'][635*i+1:635*(i+1)+1], bazant_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'k',  linestyle ='solid', linewidth=1.0, label= 'Bazant')
DH_sfig[i].plot(mensi_Dh['temperature'][635*i+1:635*(i+1)+1], mensi_Dh['humidity_diffusivity'][635*i+1:635*(i+1)+1], 'r',  linestyle ='solid', linewidth=1.0, label= 'Mensi')

for i in range(5):
    DH_sfig[i].grid(color="grey", ls = '--', lw = 0.5)

handles, labels = DH_sfig[i].get_legend_handles_labels()
DH_fig.legend(handles, labels, loc='lower center',ncol = 2, edgecolor = 'none')
DH_fig.text(0.5, 0.05, 'Temperature [\N{DEGREE SIGN}C]', ha='center')
DH_fig.text(0.05, 0.4, 'Moisture diffusivity [$m^2/s$]', ha='center', rotation=90)

plt.savefig(out_file_dir+"comparison_moisture_diffusivity.png")
