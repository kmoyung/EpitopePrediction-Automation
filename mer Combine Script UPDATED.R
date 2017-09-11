# This script works in conjunction with the EpitopePrediction software/script. However, it can be used independently to merge all subfiles in .csv format.

# Set working directory
setwd("C:/Users/kmoyung/SharePoint/IMBD - Documents/Epitope Prediction/TP53 Prediction from EpitopePrediction")

# This library is used to remove empty csv files at the end.
library(R.utils)

# Read input of supported alleles from EpitopePrediction
HLAfile <- "C:/Users/kmoyung/SharePoint/IMBD - Documents/Epitope Prediction/Supported HLA Alleles.txt"
conn <- file(HLAfile, open="r")
linn <- readLines(conn)

# Combine all nmer files of the same allele derived from EpitopePrediction/Script
for (i in 1:length(linn))
{
    prefix <- linn[i]
    prefix <- gsub(":", "-", prefix)
  
    prefix <- paste(prefix,"*", sep=" ")
    
    prefixfiles <- list.files(pattern = prefix)
      
    tables <- try(lapply(prefixfiles, read.csv, header = TRUE, stringsAsFactors=FALSE), silent = TRUE)
  
    t <- try(combined.df <- do.call(rbind, tables), silent = TRUE)
  
    if(!("try-error" %in% class(t)))
    {
      filename <- gsub(" ","", prefix)
      filename <- gsub("[*]",".csv", filename)
      write.csv(combined.df, file = filename, row.names=FALSE)
    }
    
}

close(conn)

# Remove all empty csv files (Empty files are sometimes generated)
lapply(Filter(function(x) countLines(x)==1, list.files(pattern='.csv')), unlink)


