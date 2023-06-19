#!/bin/bash
#SBATCH --job-name=stargenomeindex
#SBATCH --mail-type=END
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -t 72:00:00
#SBATCH --mem=500000
#SBATCH -o stargenomeindex.%j.out # STDOUT
#SBATCH -e stargenomeindex.%j.err # STDERR
#SBATCH --cpus-per-task=64  # Number of cores

# Set the variables based on user-provided arguments or default values
GENOME_FASTA=$1
SJDB_GTF=$2
THREADS=$3
SJDB_OVERHANG=$4
GENOME_DIR=$5  # Default value for genomeDir



# Parse user-provided arguments if provided
if [ $# -eq 2 ]; then
  GENOME_FASTA="$1"
  SJDB_GTF="$2"
elif [ $# -eq 3 ]; then
  GENOME_FASTA="$1"
  SJDB_GTF="$2"
  THREADS="$3"
elif [ $# -eq 4 ]; then
  GENOME_FASTA="$1"
  SJDB_GTF="$2"
  THREADS="$3"
  SJDB_OVERHANG="$4"
elif [ $# -eq 5 ]; then
  GENOME_FASTA="$1"
  SJDB_GTF="$2"
  THREADS="$3"
  SJDB_OVERHANG="$4"
  GENOME_DIR="$5"
fi

# Print the command that will be executed
echo "Running STAR command:"
echo "STAR --runMode genomeGenerate \
     --genomeDir \"$GENOME_DIR\" \
     --genomeFastaFiles \"$GENOME_FASTA\" \
     --sjdbGTFfile \"$SJDB_GTF\" \
     --runThreadN \"$THREADS\" \
     --sjdbOverhang \"$SJDB_OVERHANG\""

# Run the STAR command
STAR --runMode genomeGenerate \
     --genomeDir "$GENOME_DIR" \
     --genomeFastaFiles "$GENOME_FASTA" \
     --sjdbGTFfile "$SJDB_GTF" \
     --runThreadN "$THREADS" \
     --sjdbOverhang "$SJDB_OVERHANG"
