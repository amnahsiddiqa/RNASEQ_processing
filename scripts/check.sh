#!/bin/bash

csv_file=$1
# Read the CSV file using a while loop and IFS
while IFS=',' read -r sample fastq_1 fastq_2 strandedness || [ -n "$sample" ]; do
    subfolder=$(echo "$sample" | rev | cut -d '/' -f1 | rev)
    echo "=== Analyzing for sample ${subfolder} ==="
    {
        echo "=== Trimming data and QC for sample ${subfolder} ==="
        echo "Fastq1: $fastq_1"
        echo "Fastq2: $fastq_2"
    }
done < "$csv_file"
