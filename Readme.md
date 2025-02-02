
# DADA2 Project

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

## Folder Structure

- `data/`: Raw and processed data.
- `src/`: Source code including R scripts and shell scripts.
- `results/`: Results and outputs of the pipeline.

### Detailed Folder Structure

```
dada2_project/
│
├── data/                      # Raw and processed data files
│   ├── raw/                   # Raw data files (e.g., fastq files)
│   └── processed/             # Processed data (e.g., cleaned sequences, analysis results)
│
├── docs/                      # Documentation for the project
│   ├── notes.md               # Your existing notes
│   └── project_description.md # Project overview and details
│
├── src/                       # Source code (scripts and R code)
│   ├── preprocessing/         # Preprocessing scripts
│   │   ├── cutadapt.sh        # Preprocessing script using Cutadapt
│   │   └── fastqc.sh          # Preprocessing script using FastQC
│   ├── pipeline.R             # Main R script for the DADA2 pipeline
│   ├── phyloseq.R             # Script for analyzing data with phyloseq
│   └── utils/                 # Helper functions and additional code
│       └── analysis_helpers.R # R helpers for data analysis
│
├── results/                   # Results of analyses and figures
│   ├── plots/                 # Graphs and visualizations
│   ├── tables/                # Tables of results (e.g., abundance tables)
│   └── final_output/          # Final results after pipeline execution
│
├── sample_data/               # Sample metadata and sample-related files
│   ├── samples.csv            # CSV file with sample information
│   └── samplefinal.txt        # Final list of samples
│
├── README.md                  # Main readme with project overview, installation, and usage
└── pipeline.sh                # Main pipeline script to run everything
```

