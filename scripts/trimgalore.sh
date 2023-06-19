#!/bin/bash
#SBATCH --job-name=Trimgalore
#SBATCH --mail-type=END
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -t 24:23:00
#SBATCH --mem=500000
#SBATCH -o Trimgalore.%j.out # STDOUT
#SBATCH -e Trimgalore.%j.err # STDERR
#SBATCH --cpus-per-task=64  # Number of cores

module load singularity
#export LC_ALL=C.UTF-8 2>/dev/null

csv_file=$1
O_PATH=$2

# Read the CSV file using a while loop and IFS
{
    read -r _  # Discard the first line (header)
    while IFS=',' read -r sample fastq_1 fastq_2 strandedness || [ -n "$sample" ]; do
        subfolder=$(echo "$sample" | rev | cut -d '/' -f1 | rev)
        echo "=== Analyzing for sample ${subfolder} ==="
        {
           
            echo "Fastq1: $fastq_1"
            echo "Fastq2: $fastq_2"

            # Perform FastQC analysis using singularity
            singularity exec /projects/sh-li-lab/share/SiddiqaA/Singularity_AS/trimgalore_latest.sif trim_galore -q 20 --length 25 --fastqc --output_dir "$O_PATH" --paired $fastq_1 $fastq_2 --illumina --cores 8

        }
    done
} < "$csv_file"

#echo "All FastQC analyses completed successfully (echo version)"
