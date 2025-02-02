# Load required libraries
library(phyloseq)
library(ggplot2)

# Transform data to relative abundances
physeq.prop <- transform_sample_counts(physeq, function(otu) otu/sum(otu))

# Perform NMDS ordination using Bray-Curtis distances
ord.nmds.bray <- ordinate(physeq.prop, method="NMDS", distance="bray")

# Plot ordination with customization
nmds_plot <- plot_ordination(physeq.prop, ord.nmds.bray, color = "Group", title = "Bray-Curtis NMDS") +
    geom_point(size = 3) +              # Customize point size
    theme_minimal() +                  # Apply a minimal theme
    theme(legend.position = "right")   # Adjust legend position

# Display the plot
print(nmds_plot)