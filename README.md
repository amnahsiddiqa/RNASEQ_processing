## Minimal RNASEQ Workflow with BASH/Nextflow with Docker/Singularity

## About
This repository contains code for a computational workflow for RNA-Seq data preprocessing and data analysis using:
- Bash (for HPC environments; my earlier scripts)
- Nextflow
  
Both implementations make use of containerized environments using Docker or Singularity.

## Docker/Singularity Images
Docker images for the following tools are available on 
 - STAR-RSEM 
 - FASTQC
 - MultiQC 
 - TRIMGALORE
   
 These images can be pulled from amnahsid/rnaseq_analysis. Please note that the combined image is quite large.

## For Nextflow Version (To be Public yet)

To get started with the Nextflow version of the pipeline, make sure you have the following installed:

* [Java 8 or higher](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Nextflow](https://github.com/amnahsiddiqa/NGS_Pipelines/wiki/Install-and-Check-NEXTFLOW)
* [Docker](https://docs.docker.com/install/) (Recommended for MacOSX users; use Docker For Mac  [Docker For Mac](https://www.docker.com/docker-mac))




## NOTES:
- For more detailed information, please refer to the documentation available in the repository's wiki.
- Under development 
