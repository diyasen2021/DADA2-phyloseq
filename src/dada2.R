# Load required libraries
library(dada2)

## Reference: https://benjjneb.github.io/dada2/tutorial.html

# Set file paths
path <- "Data"  # Set your path to the FASTQ files
fnFs <- sort(list.files(path, pattern = "_R1_001.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern = "_R2_001.fastq", full.names = TRUE))
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
sample.names

# Inspect read quality profiles
pdf("QualityProfiles.pdf")
plotQualityProfile(fnFs[1:2])
plotQualityProfile(fnRs[1:2])
dev.off()

# Filter and Trim Reads
filt_path <- file.path(path, "filtered")
filtFs <- file.path(filt_path, paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(filt_path, paste0(sample.names, "_R_filt.fastq.gz"))
names(filtFs) <- sample.names
names(filtRs) <- sample.names
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs,
                     truncLen=c(240,160),  # Adjust truncation based on quality profiles
                     maxN=0, maxEE=c(2,2), truncQ=2,
                     rm.phix=TRUE, compress=TRUE, multithread=TRUE)
# Learn Error Rates
errF <- learnErrors(filtFs, multithread=TRUE)
errR <- learnErrors(filtRs, multithread=TRUE)
errF
# Plot error rates for forward and reverse reads
pdf("ErrorRates.pdf")
plotErrors(errF, nominalQ=TRUE)
plotErrors(errR, nominalQ=TRUE)
dev.off()

# Denoise Sequences
dadaFs <- dada(filtFs, err=errF, multithread=TRUE)
dadaRs <- dada(filtRs, err=errR, multithread=TRUE)
dadaFs[[1]]
# Merge Paired Reads
mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, verbose=TRUE)
head(mergers[[1]])
# Construct ASV Table
seqtab <- makeSequenceTable(mergers)

# Remove Chimeras
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE, verbose=TRUE)

# Track read statistics
getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names
write.csv(track, file="output/ReadProcessingStats.csv")

# Assign Taxonomy
taxa <- assignTaxonomy(seqtab.nochim, "silva/silva_nr_v132_train_set.fa.gz", multithread=TRUE)
taxa <- addSpecies(taxa, "silva/silva_species_assignment_v132.fa.gz")

# Extract sequences
asv_seqs <- colnames(seqtab.nochim)
asv_seqs

# Create ASV headers (e.g., ASV1, ASV2, ...)
asv_headers <- paste0(">ASV", seq_len(length(asv_seqs)))
asv_headers

# Write ASV sequences to a FASTA file
asv_fasta <- file("output/ASVs.fasta", "w")
writeLines(paste0(asv_headers, "\n", asv_seqs), asv_fasta)

# count table:
asv_tab <- t(seqtab.nochim)
row.names(asv_tab) <- sub(">", "", asv_headers)
write.table(asv_tab, "output/ASVs_counts.tsv", sep="\t", quote=F, col.names=NA)


# tax table:
asv_tax <- taxa
row.names(asv_tax) <- sub(">", "", asv_headers)
write.table(asv_tax, "output/ASVs_taxonomy.tsv", sep="\t", quote=F, col.names=NA)


