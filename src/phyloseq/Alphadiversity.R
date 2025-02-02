# Rarefy the data to normalize sequencing depth
set.seed(123)  # For reproducibility
physeq_rarefied <- rarefy_even_depth(physeq, sample.size = min(sample_sums(physeq)), rngseed = TRUE, verbose = FALSE)

# Calculate alpha diversity (Shannon and Simpson indices)
alpha_diversity <- estimate_richness(physeq_rarefied, measures = c("Shannon", "Simpson"))

# Add sample metadata to the alpha diversity data
alpha_diversity$Group <- sample_data(physeq_rarefied)$Group

# Save alpha diversity plot as a PDF
pdf("Alpha_Diversity.pdf")

# Visualize alpha diversity
library(ggplot2)
ggplot(alpha_diversity, aes(x = Group, y = Shannon, fill = Group)) +
    geom_boxplot() +
    theme_minimal() +
    ggtitle("Alpha Diversity (Shannon Index)") +
    xlab("Group") +
    ylab("Shannon Diversity Index") +
    scale_fill_brewer(palette = "Set2")

dev.off()
