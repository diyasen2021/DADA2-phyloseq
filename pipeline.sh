#!/bin/bash

# Exit on error
set -e

echo "Starting DADA2 pipeline..."

# Step 1: Run Preprocessing (Cutadapt + FastQC)
echo "Running preprocessing..."

# Activate Cutadapt environment
echo "Activating Cutadapt environment..."
source ~/miniconda/etc/profile.d/conda.sh
conda activate fastqc
./preprocessing_fastqc.sh
conda deactivate

# Activate FastQC environment
echo "Activating FastQC environment..."
source activate /Users/diyasen/cutadapt_env
./preprocessing_cutadapt.sh
conda deactivate

echo "Preprocessing completed!"

# Step 2: Run DADA2 Analysis (Assumes R runs in base or a dedicated R environment)
echo "Running DADA2 processing..."
conda activate dada2_env  # Activate DADA2 environment if needed
Rscript dada2.R
conda deactivate
echo "DADA2 processing completed!"

# Step 3: Run Phyloseq Analysis
echo "Running Phyloseq analysis..."
conda activate phyloseq_env  # Activate Phyloseq environment if needed
Rscript phyloseq.R
conda deactivate
echo "Phyloseq analysis completed!"

echo "Pipeline completed successfully!"

