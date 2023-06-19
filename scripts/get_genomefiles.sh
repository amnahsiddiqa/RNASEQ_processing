#!/bin/bash

VERSION=$1
outdirectory=$2

genome_file="$outdirectory/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
annotation_file="$outdirectory/annotation/Homo_sapiens.GRCh38.$VERSION.gtf.gz"

wget -P "$outdirectory/genome" -L -N "ftp://ftp.ensembl.org/pub/release-$VERSION/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
wget -P "$outdirectory/annotation" -L -N "ftp://ftp.ensembl.org/pub/release-$VERSION/gtf/homo_sapiens/Homo_sapiens.GRCh38.$VERSION.gtf.gz"

# Unzip the downloaded files
gzip -d "$genome_file"
gzip -d "$annotation_file"
