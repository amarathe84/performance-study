#!/bin/sh

#SBATCH --job-name=kripke-2n
#SBATCH --nodes=2
#SBATCH --time=0:20:00
#SBATCH --exclusive

export OMP_NUM_THREADS=1
echo "Start time:" $( date +%s )
/usr/bin/time -p mpirun -N 2 --map-by ppr:96:node \
	                    /shared/bin/singularity exec /shared/containers/metric-kripke-cpu_libfabric-zen4.sif kripke \
			    --layout GDZ --dset 8 --zones 96,96,96 --gset 16 --groups 64 --niter 10 --legendre 2 --quad 8 --procs 4,6,8
echo "End time:" $( date +%s )

#full-scale input OOMs (expected behavior for the problem size)
export OMP_NUM_THREADS=1
echo "Start time:" $( date +%s )
/usr/bin/time -p mpirun -N 2 --map-by ppr:96:node \
	                    /shared/bin/singularity exec /shared/containers/metric-kripke-cpu_libfabric-zen4.sif kripke \
			    --layout DGZ --dset 16 --zones 448,280,256 --gset 16 --groups 16 --niter 10 --legendre 2 --quad 8 --procs 4,6,8
echo "End time:" $( date +%s )


