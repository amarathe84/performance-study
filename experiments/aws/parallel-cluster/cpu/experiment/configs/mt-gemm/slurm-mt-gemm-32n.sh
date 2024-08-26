#!/bin/sh

#SBATCH --job-name=mt-gemm-32n
#SBATCH --nodes=32
#SBATCH --time=0:20:00
#SBATCH --exclusive

echo "Start time:" $( date +%s )
/usr/bin/time -p mpirun -N 32 --map-by ppr:96:node \
	/shared/bin/singularity exec /shared/containers/mt-gemm_libfabric-cpu-zen4.sif \
	/opt/dense_linear_algebra/gemm/mpi/build/1_dense_gemm_mpi
echo "End time:" $( date +%s )