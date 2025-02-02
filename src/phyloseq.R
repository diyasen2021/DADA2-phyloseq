# Load required libraries
library(phyloseq)
library(ggplot2)
library(DECIPHER)

# Step 1: Import DADA2 Results

# Load ASV count table
asv_table <- read.table("output/ASVs_counts.tsv", header=TRUE, row.names=1, sep="\t")
otu_table <- otu_table(asv_table, taxa_are_rows=TRUE)  # Create OTU table

# Load taxonomy table
taxonomy <- read.table("output/ASVs_taxonomy.tsv", header=TRUE, row.names=1, sep="\t")
tax_table <- tax_table(as.matrix(taxonomy))  # Create taxonomy table (convert to matrix)

# Step 2: Import Sample Metadata
metadata <- read.csv("output/metadata.csv", header=TRUE, row.names=1)  # Replace with your metadata file
sample_data <- sample_data(metadata)

# Step 3: Combine into a Phyloseq Object
physeq <- phyloseq(otu_table, tax_table, sample_data)
physeq

# Prune ASVs : Remove unwanted taxa

# Add Phylogenetic Tree (Optional)
# scripts/phylogenetic.R

# Barplots
pdf("Barplots.pdf")
top20 <- names(sort(taxa_sums(physeq), decreasing=TRUE))[1:20]
ps.top20 <- transform_sample_counts(physeq, function(OTU) OTU/sum(OTU))
ps.top20 <- prune_taxa(top20, ps.top20)
plot_bar(ps.top20, x="Group", fill="Family") + facet_wrap(~Group, scales="free_x")
dev.off()

# Alpha Diversity 
# scripts/Alphadiversity.R

# Beta Diversity
#scripts/BetaDiversity.R

# Rarefaction
# scripts/rarefaction.R


# Heatmap of ASVs
pdf("ASV_Heatmap.pdf")
plot_heatmap(physeq, method="NMDS", distance="bray", taxa.label="Genus") +
    ggtitle("ASV Heatmap Bray-Curtis NMDS")

dev.off()


# Step 4: Save Phyloseq Object
saveRDS(physeq, file="phyloseq_object.rds")




