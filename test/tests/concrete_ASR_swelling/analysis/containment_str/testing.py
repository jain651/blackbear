import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.image as mpimg
from matplotlib.ticker import (MultipleLocator, FormatStrFormatter, AutoMinorLocator)
from matplotlib.offsetbox import TextArea, DrawingArea, OffsetImage, AnnotationBbox
from numpy import *
import numpy as np
import pandas as pd
import math

def ft(x,ft0,at,d_b):


## plotting ASR expansion #############################################################################
RH_fig, RH_subfig = plt.subplots(3, sharex=True, sharey=True, figsize = (4,8))
plt.subplots_adjust(left=0.18, bottom=0.15, right=0.90, top=0.97)
RH_fig.text(0.03, 0.5, 'Relative humidity []%]', va='center', rotation='vertical')
RH_fig.text(0.5, 0.08, 'Time [days]', ha='center')
for i in range(3):
    for j in range(4):
        RH_subfig[i].plot(RH_History["Days"].values, RH_History[col_RH_T[i+j+1]].values, color[j], linewidth=1.0, label= sensor_loc[j])
RH_subfig[0].set_title("Laboratory environment for Beam 4", fontsize=11)
RH_subfig[1].set_title("Outside environment for Beam 5", fontsize=11)
RH_subfig[2].set_title("Outside environment for Beam 6", fontsize=11)
for i in range(3):
    RH_subfig[i].grid(color="grey", ls = '--', lw = 0.5)
    RH_subfig[i].xaxis.set_minor_locator(MultipleLocator(20))
    RH_subfig[i].yaxis.set_minor_locator(MultipleLocator(2))
    plt.xlim(0, 600)
    plt.ylim(0, 100)
hand_RH, lab_RH = (RH_subfig[2]).get_legend_handles_labels()
lgd_RH = RH_fig.legend(hand_RH, lab_RH, loc='lower center',ncol=2)
lgd_RH.FontSize = 11;
lgd_RH.get_frame().set_edgecolor('none')

# plt.show()
# plt.savefig(exp_data_path+"figures/"+"RH_History.pdf")
# plt.savefig(exp_data_path+"figures/"+"RH_History.png", dpi=300)
