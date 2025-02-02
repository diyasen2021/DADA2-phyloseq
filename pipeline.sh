#!/bin/bash
# Exit on error
set -e

echo "Starting DADA2 pipeline..."

# Step 1: Run Preprocessing (FastQC + Cutadapt)
echo "Running preprocessing..."

# Ensure FastQC environment exists
if ! conda env list | grep -q "^fastqc_env\s"; then
    echo "Creating FastQC environment..."
    mamba env create -f fastqc_environment.yaml || conda env create -f fastqc_environment.yaml
fi

echo "Activating FastQC environment..."
source ~/miniconda/etc/profile.d/conda.sh
conda activate fastqc_env
./preprocessing_fastqc.sh
conda deactivate

# Ensure Cutadapt environment exists
if ! conda env list | grep -q "^cutadapt_env\s"; then
    echo "Creating Cutadapt environment..."
    mamba env create -f cutadapt_environment.yaml || conda env create -f cutadapt_environment.yaml
fi

echo "Activating Cutadapt environment..."
conda activate cutadapt_env
./preprocessing_cutadapt.sh
conda deactivate

echo "Preprocessing completed!"

# Step 2: Run DADA2 Analysis
echo "Running DADA2 processing..."
conda activate dada2_env
Rscript dada2.R
conda deactivate
echo "DADA2 processing completed!"

# Step 3: Run Phyloseq Analysis
echo "Running Phyloseq analysis..."
Rscript phyloseq.R
conda deactivate
echo "Phyloseq analysis completed!"

echo "Pipeline completed successfully!"

