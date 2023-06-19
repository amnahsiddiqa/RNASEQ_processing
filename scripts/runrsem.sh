#!/bin/bash
#SBATCH --job-name=rsemstar
#SBATCH --mail-type=END
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -t 72:00:00
#SBATCH --mem=400000
#SBATCH -o rsemstar.%j.out # STDOUT
#SBATCH -e rsemstar.%j.err # STDERR
#SBATCH --cpus-per-task=32  # Number of cores

#source activate rnaseq  # Assuming "rnaseq" is the name of your Conda environment
#module load singularity 
genomedir=$1
I_PATH=$2
output_dir=$3
csv_file=$4
head -n 1 "$csv_file" > /dev/null
while IFS=', ' read -r sample fastq_1 fastq_2 strandedness || [ -n "$sample" ]; do
    subfolder=$(echo "$sample" | rev | cut -d '/' -f1 | rev)
    i=$sample
    echo "=== Analyzing for sample ${subfolder} ==="
    {
        echo "=== Trimming data and QC for sample ${subfolder} ==="
        echo "Fastq1: $fastq_1"
        echo "Fastq2: $fastq_2"
        pairedend1=$fastq_1
        pairedend2=$fastq_2
        
        echo "$I_PATH/$pairedend1"
        echo "$I_PATH/$pairedend2"
        chmod -R +rwx  output_dir
        STAR --runThreadN 32 \
            --genomeDir $genomedir/ \
            --readFilesIn $I_PATH/$pairedend1 $I_PATH/$pairedend2 \
            --readFilesCommand zcat \
            --outSAMtype BAM SortedByCoordinate \
            --quantMode TranscriptomeSAM GeneCounts \
            --outSAMunmapped Within \
            --twopassMode Basic \
            --outFilterMultimapNmax 1 \
            --runMode alignReads \
            --outFileNamePrefix $output_dir/${i}_
        echo "Alignment for ${i} is done."
        chmod -R +rwx  output_dir
        echo "Calculating gene expression for ${i}..."
        rsem-calculate-expression --bam \
            --no-bam-output \
            --paired-end \
            --estimate-rspd \
            --strandedness reverse \
            --alignments \
            -p 32 \
            $output_dir/${i}_Aligned.toTranscriptome.out.bam\
            /projects/sh-li-lab/share/SiddiqaA/R01_preprocessing_Sep2021/PBMC_RNASEQ/RSEM_referencev2/ref \
            $output_dir/${i}
        echo "Gene expression calculation for ${i} is done."
    }
done < "$csv_file"

