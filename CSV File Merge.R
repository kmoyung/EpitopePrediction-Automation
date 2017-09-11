setwd("C:/Users/kmoyung/SharePoint/IMBD - Documents/Epitope Prediction/Prediction Databases/Survivin Prediction Database")

files <- list.files(pattern = '\\.csv')

tables <- lapply(files, read.csv, header = TRUE, stringsAsFactors=FALSE)

combined.df <- do.call(rbind, tables)

write.csv(combined.df, file = "Survivin EpitopePrediction Merged.csv", row.names=FALSE)
