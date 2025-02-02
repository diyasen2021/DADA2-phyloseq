# Load required libraries
library(phyloseq)
library(vegan)

# Extract the OTU/ASV table from the phyloseq object
asv_table_data <- as(otu_table(physeq), "matrix")

# Vegan expects samples as rows, so transpose if taxa are rows
if (taxa_are_rows(physeq)) {
    asv_table_data <- t(asv_table_data)
}

# Create rarefaction curves
rarecurve(
    asv_table_data, 
    step = 100, # Step size for rarefaction
    sample = min(rowSums(asv_table_data)), # Minimum sequencing depth
    col = "blue", # Color for the curves
    label = TRUE, # Add sample labels
    main = "Rarefaction Curves", # Title
    ylab = "Species Richness", # Y-axis label
    xlab = "Sequencing Depth" # X-axis label
)
