# Create a DNAStringSet from ASVs
#dna <- Biostrings::DNAStringSet(taxa_names(physeq))

# Align sequences
#alignment <- DECIPHER::AlignSeqs(dna, anchor=NA)

# Create a phylogenetic tree
#phangorn::phyDat(alignment) -> phangorn_data
#tree <- phangorn::upgma(dist.ml(phangorn_data))

# Add the tree to the phyloseq object
#physeq <- merge_phyloseq(physeq, phy_tree(tree))
