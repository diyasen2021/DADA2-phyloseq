#!/bin/bash

# Set variables
DATA_DIR="Data"
TRIMMED_DIR="Data/cutadapt/"
FASTQC_DIR="output/FastQC_Reports"
SAMPLES_FILE="samples"  # File containing the list of sample names (without extensions)

# Create directories for output
mkdir -p $TRIMMED_DIR
mkdir -p $FASTQC_DIR

# Step 1: Run FastQC on raw FASTQ files
echo "Running FastQC on raw FASTQ files..."
fastqc -o $FASTQC_DIR $DATA_DIR/*_R1_001.fastq $DATA_DIR/*_R2_001.fastq

# Step 2: Trim primers using Cutadapt
echo "Trimming primers with Cutadapt..."

while read -r sample; do
    echo "On sample: $sample"

    cutadapt -a ^GTGCCAGCMGCCGCGGTAA...ATTAGAWACCCBDGTAGTCC \
             -A ^GGACTACHVGGGTWTCTAAT...TTACCGCGGCKGCTGGCAC \
             -m 215 -M 285 --discard-untrimmed \
             -o $TRIMMED_DIR/${sample}_sub_R1_trimmed.fq.gz -p $TRIMMED_DIR/${sample}_sub_R2_trimmed.fq.gz \
             $DATA_DIR/${sample}_sub_R1.fq $DATA_DIR/${sample}_sub_R2.fq \
             >> cutadapt_primer_trimming_stats.txt 2>&1

done < "$SAMPLES_FILE"

echo "FastQC and Cutadapt steps completed!"
