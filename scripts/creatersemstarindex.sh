#!/bin/bash
#SBATCH --job-name=starrsemgenomeindex
#SBATCH --mail-type=END
#SBATCH -p compute
#SBATCH -q batch
#SBATCH -t 72:00:00
#SBATCH --mem=500000
#SBATCH -o starrsemgenomeindex.%j.out # STDOUT
#SBATCH -e starrsemgenomeindex.%j.err # STDERR
#SBATCH --cpus-per-task=64 # Number of cores

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
echo "Running rsem-prepare-reference command:"
echo "rsem-prepare-reference --star-sjdboverhang \"$SJDB_OVERHANG\" \"$GENOME_FASTA\" --gtf \"$SJDB_GTF\" --p \"$THREADS\" --star \"$GENOME_DIR\""

# Run the rsem-prepare-reference command
rsem-prepare-reference --star-sjdboverhang "$SJDB_OVERHANG" "$GENOME_FASTA" --gtf "$SJDB_GTF" --p "$THREADS" --star "$GENOME_DIR"
