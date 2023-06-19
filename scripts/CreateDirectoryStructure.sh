#!/bin/bash
: 'usage: ./create_directories.sh new_analysis'
if [ $# -eq 0 ]; then
  echo "Please provide a directory name."
  exit 1
fi

directory_name=$1

# Create the main directory
mkdir -p "$directory_name"

# Create subdirectories
mkdir -p "$directory_name/annotation"
mkdir -p "$directory_name/genome"
mkdir -p "$directory_name/input"
mkdir -p "$directory_name/output/1_initial_qc"
mkdir -p "$directory_name/output/2_trimmed_output"
mkdir -p "$directory_name/output/3_aligned_sequences"
mkdir -p "$directory_name/output/4_final_counts"
mkdir -p "$directory_name/output/5_multiQC"
#mkdir -p "$directory_name/sortmerna_db/index"
#mkdir -p "$directory_name/sortmerna_db/rRNA_databases"
mkdir  -p "$directory_name/GenomeIndex"
mkdir  -p "$directory_name/RsemGenomeIndex"




# Print success message
echo "Directory structure created successfully in '$directory_name'!"
