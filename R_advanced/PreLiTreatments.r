# install.packages("dplyr")
library(dplyr)
donnees <- read.delim("dataset-clinical_mod-baseline_form-preLi_tab-med_version-2.tsv", sep = "\t")

# Select the wanted columns
data_selected <- donnees %>%
  select("participant_id", "INN", "TOTDOSE", "UNIT", "FREQ")

write.csv(data_selected, "TreatmentPreLI.csv")


