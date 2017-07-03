# EpitopePrediction: https://github.com/jtextor/epitope-prediction
# Manual: http://johannes-textor.name/R/epitope-prediction-using-r.html

# Set the working directory
setwd("C:/Users/kmoyung/OneDrive for Business/Epitope Prediction for Mesothelin")

# Load the EpitopePrediction library
library(EpitopePrediction)

# Input the full protein sequence. The following sequence is from Mesothelin.
hcv.core <- paste("MALPTARPLLGSCGTPALGSLLFLLFSLGWVQPSRTLAGETGQEAAPLDGVLANPPNISSLSPRQLLGFPCAEVSGLSTERVRELAVALAQKNVKLSTEQLRCLAHRLSEPPEDLDALPLDLLLFLNPDAFSGPQACTRFFSRITKANVDLLPRGAPERQRLLPAALACWGVRGSLLSEADVRALGGLACDLPGRFVAESAEVLLPRLVSCPGPLDQDQQEAARAALQGGGPPYGPPSTWSVSTMDALRGLLPVLGQPIIRSIPQGIVAAWRQRSSRDPSWRQPERTILRPRFRREVEKTACPSGKKAREIDESLIFYKKWELEACVDAALLATQMDRVNAIPFTYEQLDVLKHKLDELYPQGYPESVIQHLGYLFLKMSPEDIRKWNVTSLETLKALLEVNKGHEMSPQAPRRPLPQVATLIDRFVKGRGQLDKDTLDTLTAFYPGYLCSLSPEELSSVPPSSIWAVRPQDLDTCDPRQLDVLYPKARLAFQNMNGSEYFVKIQSFLGGAPTEDLKALSQQNVSMDLATFMKLRTDAVLPLTVAEVQKLLGPHVEGLKAEERHRPVRDWILRQRQDDLDTLGLGLQGGIPNGYLVLDLSMQEALSGTPCLLGPGPVLTVLALLLASTLA")

# Set the peptide length (mer)
nmer <- 9

# Read input of supported alleles from EpitopePrediction
HLAfile <- "Supported HLA Alleles.txt"
conn <- file(HLAfile, open="r")
linn <- readLines(conn)

# Loop through 9-11mers for every allele
while (nmer < 12)
{
  for (i in 1:length(linn)) 
  {
    allele <- linn[i]
    allele <- gsub(" ", "", allele)
    
    # Save the allele name for export to file
    allelename <- gsub(":","-", allele)
    allelefilename <- paste(allelename, "-",nmer,"mer.csv", sep="")
    
    # Run the prediction algorithm
    t <- try(data <- binders(hcv.core, allele, nmer), silent=TRUE)
    
    # Write the results to a csv file if no error occurs
    if(!("try-error" %in% class(t))) 
    {
      write.csv(data, allelefilename, row.names=FALSE)
    }
  }
  
  nmer <- nmer + 1
}
close(conn)
