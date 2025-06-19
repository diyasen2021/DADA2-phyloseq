
# Amplicon sequence analysis

This project provides a pipeline for processing 16S amplicon sequencing data using the DADA2 and other tools like Cutadapt and FastQC.

## Setup

- Install conda: https://conda.io/projects/conda/en/latest/index.html
- Create the conda environment:
  ```bash
  conda create -n dada2_env -c bioconda dada2 fastp cutadapt fastqc
  ```
- Activate the environment:
  ```bash
  conda activate dada2_env
  ```

## Running the Pipeline

Run the main pipeline script:
```bash
bash pipeline.sh
```
## What does the pipeline do

1. Run FastQC on raw FASTQ files
2. Trim primers using Cutadapt
3. Run DADA2 Analysis
4. Run Phyloseq Analysis

## Folder Structure

- `data/`: Raw and processed data.
- `src/`: Source code including R scripts and shell scripts.
- `output/`: Results and outputs of the pipeline.
- `sample_data/`: Metadata about samples

```

