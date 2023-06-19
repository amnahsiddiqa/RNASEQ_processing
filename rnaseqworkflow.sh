#!/bin/bash
#Amnah Siddiqa, 2023-06-17
# Version 1.01

help="Shell script to for processing of paired end RNA-seq data in a folder based on STAR-RSEM.
QC with fastqc at the beginning and use multiqc to summary qc figures.
Note RSEM --star can not implement STAR for all samples with a shared memory of genome, so separate the two steps!
Usage:
    RNAseq_workflow.sh -g <109> <-p> -i <path_of_inputs> -d <analyses directory name> -o <path_of_outputs> -t <threads>
Options:
    -g    set version of human reference genome, default is HG38 version 108 ; newer version can be passed here e.g. 109 
    -p    default is  for paired-end data, (include for single-end data; to do)
    -a    sjdboverhang for STAR ; 
    -i    path to directory of input fastq or fastq.gz files
    -m    metadata csv file in the described way; must have four columns 
    -d    directory name for output files, It will be created in current working dirtecrtory 
    -t    average number of threads for each sample, must be integer, default is 1
" 

if [[ $# -le 0 ]]; then
    echo "${help}" >&2
    exit 1
fi

# Set default value for the genome argument
genome=108

while getopts :a:g:pi:d:m:o:t: ARGS
do
case $ARGS in
    a) 
        sjdboverhang=$OPTARG
        ;;
    g)
        genome=$OPTARG
        ;;
    p)
        datatype="PE"
        ;;
    i)
        pathin=$OPTARG
        ;;
    d) directoryname=$OPTARG
        ;;
    m) metadatacsvfile=$OPTARG
        ;;
    o)
        pathout=$OPTARG
        ;;
    t)
        threads=$OPTARG
        ;;
    :)
        echo "no value for option: $OPTARG"
        echo "${manual}" >&2
        exit 1
        ;;
    *)
        echo "unknow option: $OPTARG"
        echo "${manual}" >&2
        exit 1
        ;;
esac
done


#create a project folder in current wd 
#./scripts/CreateDirectoryStructure.sh "$directoryname"


# echo files in samples.csv check head and tail 
#./scripts/check.sh "$metadatacsvfile"


# download annotation files 
#Set the version argument (if provided), otherwise default to 108
#./scripts/get_genomefiles.sh "$genome" "$directoryname"




# create index or download ; to do; craete if else for user choice 

# create STAR-RSEM index 
#mkdir "$directoryname/Genomeindexrsem"
#cd "$directoryname/Genomeindexrsem"
genome_file=$(find "$directoryname/genome" -type f)
annotation_file=$(find "$directoryname/annotation" -type f -name "Homo_sapiens.GRCh38.$genome.gtf")
echo "genome_file: $genome_file"
echo "annotation_file: $annotation_file"
#exhoed locations 
#genome_file: test_analyses/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
#annotation_file: test_analyses/annotation/Homo_sapiens.GRCh38.109.gtf


#current_dir=$(pwd)
#outdirname=$directoryname/RsemGenomeIndex
#cd "$outdirname"
# Run the creatersemstarindex.sh script
#jobid_createstarindex=$(sbatch ../../scripts/creatersemstarindex.sh "../../$genome_file" "../../$annotation_file" $threads $sjdboverhang "RsemGenomeIndex")
#cd "$current_dir"
#echo $jobid_createstarindex


# create STAR index 
# Retrieve genome and annotation file paths
# to do ; add download directly and unzip from google cloud or AWZigenomes 
#jobid_createstarindex=$(sbatch ./scripts/createstarindex.sh "$genome_file" "$annotation_file" "$threads" "$sjdboverhang" "$directoryname/GenomeIndex")
#echo $jobid_createstarindex

# do fastqc in fatqc directory folder 
#./dofastqc.sh "$metadatacsvfile" "$directoryname/output/1_initial_qc"
# above should work if your prereqs/conda is setup 
#sbatch ./scripts/dofastqc.sh "$metadatacsvfile" "$directoryname/output/1_initial_qc"


# trim files 
#./trimgalore.sh "$metadatacsvfile" "$directoryname/output/2_trimmed_output"
# above should work if your prereqs/conda is setup 
# the slurm id of this step is required for next step to schedule the dependency  
#jobid=$(sbatch --dependency=afterok:$jobid_createstarindex ./scripts/trimgalore.sh samples.csv "$directoryname/output/2_trimmed_output" | awk '{print $4}')
#sbatch ./scripts/trimgalore.sh samples.csv "$directoryname/output/2_trimmed_output" 



# create a  new list of trimmed filenames to pass through 
#awk -F',' 'NR>1 { cmd1 = "basename \"" $2 "\""; cmd2 = "basename \"" $3 "\""; cmd1 | getline result1; cmd2 | getline result2; close(cmd1); close(cmd2); $2 = result1; $3 = result2; sub(/\.fastq\.gz$/, "_val_1.fq.gz", $2); sub(/\.fastq\.gz$/, "_val_2.fq.gz", $3); print }' your_file.csv > samples_trimmed.csv

#Quantification Rsem
#add if lese statement and debug 
#Submit the quantification job and capture the job ID in the 'quant_jobid' variable
#quant_jobid=$(sbatch --dependency=afterok:$jobid ./scripts/runrsem.sh "$directoryname/Genomeindexrsem" "$directoryname/output/2_trimmed_output")
#sbatch ./scripts/runrsem.sh "$directoryname/RsemGenomeIndex" \
#"$directoryname/output/2_trimmed_output" \
#"$directoryname/output/3_aligned_sequences" \
#"samples_trimmed.csv"


#Submit the post-quantification scripts as dependent jobs
#sbatch --dependency=afterok:$quant_jobid python3 ./scripts/createmergedrawcountfile.py $directoryname
#sbatch --dependency=afterok:$quant_jobid python3 ./scripts/createmergedTPMcountfile.py $directoryname
#python3 ./scripts/createmergedrawcountfile.py $directoryname
#python3 ./scripts/createmergedTPMcountfile.py $directoryname


# ...HOW to run : Usecase
#rnaseqWorkflowV1.sh -d test_analyses -m samples.csv -g 109 -a 149 -t 48
