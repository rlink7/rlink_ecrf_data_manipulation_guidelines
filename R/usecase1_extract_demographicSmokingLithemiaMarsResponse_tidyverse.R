library(dplyr)
library(readr)
library(openxlsx)

# Set paths
INPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/data/"
OUTPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/outputs/"

# 1. Read and manipulate data
# ===========================

# 1.1 Inclusion data
df1 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-inclusion_version-2.tsv"), na = "ND") %>%
  select(participant_id, AGE, SEX)
stopifnot(nrow(df1) == 168, ncol(df1) == 3) # Optional check

# 1.2 Baseline data
df2 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"), na = "ND") %>%
  select(participant_id, WHOA1A_PLI, HEIGHT_PRELI, WEIGHT_PRELI,
         MARS1_PRELI:MARS10_PRELI, QIDSTSC_PRELI, BRMSTSC_PRELI) %>%
  mutate(BMI = WEIGHT_PRELI / (HEIGHT_PRELI^2) * 100^2)
stopifnot(nrow(df2) == 168, ncol(df2) == 17) # Optional check

# 1.3 Visit data
df3 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-visits_form-visit_version-2.tsv"), na = "ND") %>%
  select(participant_id, FORM_F_VISIT, WHOA2A, PLIMRI, ERYLIMRI, PLI, ERYLI, PLI2, 
         MARS1V:MARS10V) %>%
  filter(FORM_F_VISIT == "F_VISIT_1") %>%
  select(-FORM_F_VISIT) %>%
  rename_with(~ sub("V$", "_M03", .), starts_with("MARS"))
stopifnot(nrow(df3) == 142, ncol(df3) == 17) # Optional check

# 1.4 Outcome data
df4 <- read_tsv(file.path(INPUT, "dataset-clinical_version-2_outcome.tsv"), na = "ND") %>%
  select(participant_id, Response.Status.at.end.of.follow.up) %>%
  mutate(participant_id = paste0("sub-", participant_id))
stopifnot(nrow(df4) == 159, ncol(df4) == 2) # Optional check

# 2. Merge tables
# ===============

table <- df1 %>%
  inner_join(df2, by = "participant_id") %>%
  inner_join(df3, by = "participant_id") %>%
  inner_join(df4, by = "participant_id")
stopifnot(nrow(table) == 141, ncol(table) == 36) # Optional check

# 3. Save to Excel
# ================

write.xlsx(table, file.path(OUTPUT, "data_demoSmokLiMarsResponse_rtidyverse.xlsx"), overwrite = TRUE)
