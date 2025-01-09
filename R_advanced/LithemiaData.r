# install.packages("dplyr")
library(dplyr)
donnees <- read.delim("dataset-clinical_mod-visits_form-visit_version-2.tsv", sep = "\t")

# Select the wanted columns
data_selected <- donnees %>%
  select("participant_id", "FORM_F_VISIT", "DATBIOMRI", "BIOMRIYN", "PLIMRI", "ERYLIMRI", "DATBIO", "PLI", "ERYLI", "DATBIO2", "PLI2", "ERYLI2")

write.csv(data_selected, "LithemiaData.csv")

