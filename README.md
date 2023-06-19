## Minimal RNASEQ Workflow with BASH/Nextflow 
![RNASEQ_AS](https://github.com/amnahsiddiqa/RNASEQ_processing/assets/28387956/79951381-598a-4f94-abe4-702981bdb106)

## About
This repository contains code for a computational workflow for RNA-Seq data preprocessing and data analysis using:
- Bash (for HPC environments; my earlier scripts)
- Nextflow
  
Both implementations make use of containerized environments using Docker or Singularity.

## Docker/Singularity Images
Docker images for the following tools are available [@dockerhub](https://hub.docker.com/u/amnahsid)
 - STAR-RSEM 
 - FASTQC
 - MultiQC 
 - TRIMGALORE
   
 These images can be pulled from ``` docker pull amnahsid/rnaseq_analysis```. Please note that the combined image is quite large.

## For Nextflow Version (To be Public yet)

To get started with the Nextflow version of the pipeline, make sure you have the following installed:

* [Java 8 or higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Nextflow](https://github.com/amnahsiddiqa/NGS_Pipelines/wiki/Install-and-Check-NEXTFLOW)
* [Docker](https://docs.docker.com/install/) (Recommended for MacOSX users; use Docker For Mac  [Docker For Mac](https://www.docker.com/docker-mac))


## Getting started 
### Create a sample metadata file
This is same as nf-core RNAseq sample file. Must have four columns;
- sample  < Sample name can be anuY IDentifioer of users own input criteria ; this is not going to me merged for example as in for sequencing depeth etc ; Thats not gona happen here >
- fastq_1  < Path to read1.fastq file >
- fastq_2 < Path to read2.fastq file>
- strandedness <reverse, forward, auto >


### Create directory structure like this:
```
── new_workflow/                    <- Working directory for analysis
  │   └── annotation/               <- Genome annotation file (.GTF/.GFF)
  │  
  │   └── genome/                   <- Host genome file (.FASTA)
  │  
  │   └── input/                    <- Location of input  RNAseq data
  │  
  │   └── output/                   <- Data generated during processing steps
  │       ├── 1_initial_qc/         <- Main alignment files for each sample
  │       ├── 2_trimmed_output/     <-  Log from running STAR alignment step
  │       ├── 3_rRNA/               <- STAR alignment counts output (for comparison with featureCounts)
  │       ├── 4_final_counts/       <- Summarized gene counts across all samples
  │       ├── 5_multiQC/            <- Overall report of logs for each step
  │   └── star_index/               <-  Folder to store the indexed genome files from STAR/STAR-RSEM
```
### Arguments for config file 
Example use:
   
    > RNAseq_workflow.sh -g <109> <-p> -i <path_of_inputs> -d <analyses directory name> -o <path_of_outputs> -t <threads>
 ```   
Options:
    -g    set version of human reference genome, default is HG38 version 108 ; newer version can be passed here e.g. 109 
    -p    default is  for paired-end data, (include for single-end data; to do)
    -a    sjdboverhang for STAR ; 
    -i    path to directory of input fastq or fastq.gz files
    -m    metadata csv file in the described way; must have four columns 
    -d    directory name for output files, It will be created in current working dirtecrtory 
    -t    average number of threads for each sample, must be integer, default is 1
```

## NOTES:
- For more detailed information, please refer to the documentation available in the repository's wiki.
- Under development 
- https://github.com/ewels/AWS-iGenomes (If needed indexed genomes to download)


