#!/bin/bash
#SBATCH --partition=aaiken
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --exclusive
#SBATCH --time=01:00:00
#SBATCH --mail-type=ALL

(for s in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
     srun --cpu_bind none ../../starpu/main -kernel busy_wait -iter $(( 1 << (24-s) )) -type stencil_1d -steps 800 -width 20 -core 20
 done) | tee starpu.txt

grep Elapsed starpu.txt | cut -d' ' -f 3