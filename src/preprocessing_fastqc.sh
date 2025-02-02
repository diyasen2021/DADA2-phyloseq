#!/bin/bash

# Set variables
DATA_DIR="Data"
FASTQC_DIR="output/FastQC_Reports"

# Create directories for output
mkdir -p $FASTQC_DIR

# Step 1: Run FastQC on raw FASTQ files
echo "Running FastQC on raw FASTQ files..."
fastqc -o $FASTQC_DIR $DATA_DIR/*_R1_001.fastq $DATA_DIR/*_R2_001.fastq

echo "FastQC completed!"
