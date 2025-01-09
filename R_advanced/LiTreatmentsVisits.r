# install.packages("dplyr")
library(dplyr)
donnees <- read.delim("dataset-clinical_mod-visits_form-visit_tab-med_version-2.tsv", sep = "\t")

# Select the wanted columns
data_selected <- donnees %>%
  select("participant_id", "FORM_F_VISIT", "INN", "TOTDOSE", "UNIT", "FREQ")

write.csv(data_selected, "TreatmentVisits.csv")

