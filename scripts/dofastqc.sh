#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --mail-type=END
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -t 24:23:00
#SBATCH --mem=500000
#SBATCH -o fastqc.%j.out # STDOUT
#SBATCH -e fastqc.%j.err # STDERR
#SBATCH --cpus-per-task=64  # Number of cores

module load singularity
export LC_ALL=C.UTF-8 2>/dev/null

csv_file=$1
output_dir=$2

# Read the CSV file using a while loop and IFS
{
    read -r _  # Discard the first line (header)
    while IFS=',' read -r sample fastq_1 fastq_2 strandedness || [ -n "$sample" ]; do
        subfolder=$(echo "$sample" | rev | cut -d '/' -f1 | rev)
        
        {
            echo "=== T QC for sample $sample ==="
            echo "Fastq1: $fastq_1"
            echo "Fastq2: $fastq_2"

            # Perform FastQC analysis using singularity
            echo "Running FastQC for $fastq_1"
            singularity exec -B "$PWD":/data /projects/sh-li-lab/share/SiddiqaA/Singularity_AS/fastqc_latest.sif fastqc "$fastq_1" -o "$output_dir"

            echo "Running FastQC for $fastq_2"
            singularity exec -B "$PWD":/data /projects/sh-li-lab/share/SiddiqaA/Singularity_AS/fastqc_latest.sif fastqc "$fastq_2" -o "$output_dir"
        }
    done
} < "$csv_file"

#echo "All FastQC analyses completed successfully (echo version)"
