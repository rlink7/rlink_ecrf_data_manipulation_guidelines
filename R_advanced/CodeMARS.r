# install.packages("dplyr")
library(dplyr)
donnees <- read.delim("dataset-clinical_mod-visits_form-visit_version-2.tsv", sep = "\t")

# Select the wanted columns
data_selected <- donnees %>%
  select("participant_id", "FORM_F_VISIT", "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", "MARS6V", "MARS7V", "MARS8V", "MARS9V", "MARS10V")

write.csv(data_selected, "MARSScore.csv")

