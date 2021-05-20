#!/bin/bash
#PBS -M amit.jain@inl.gov
#PBS -m be
#PBS -N ContainmentVessel3D_180_v3_refined
#PBS -l select=10:ncpus=36:mpiprocs=36:mem=100gb
#PBS -l walltime=1000:00:00
#PBS -P lwrs

JOB_NUM=${PBS_JOBID%%\.*}

cd $PBS_O_WORKDIR

module purge
module load pbs
module load use.moose PETSc/3.10.5-GCC

\rm -f out
time mpiexec ~/projects_falcon1/blackbear/blackbear-opt -i ~/projects_falcon1/blackbear/test/test/concrete_ASR_swelling/ContainmentVessel3D_180_v3_refined.i > out

