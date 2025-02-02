# Load required library
library(phyloseq)

# Extract ASV sequences from the phyloseq object
asv_sequences <- taxa_names(physeq)  # This retrieves the ASV sequences

# Calculate lengths of each ASV sequence
asv_lengths <- nchar(asv_sequences)

# Plot the distribution of ASV lengths
hist(
    asv_lengths,
    breaks = 15, # Number of bins
    col = "skyblue",
    main = "Distribution of ASV Lengths",
    xlab = "ASV Length (bp)",
    ylab = "Frequency"
)

# Optionally, print some statistics
summary(asv_lengths)
