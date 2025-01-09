library(readr)
library(dplyr)
library(openxlsx)

# Parameters
INPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/data"
OUTPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/outputs"

# Read Data
vars <- c("participant_id", "AGE", "SEX")
df1 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-inclusion_version-2.tsv"), na = "ND") %>%
  select(all_of(vars))
stopifnot(nrow(df1) == 168, ncol(df1) == 3)

vars <- c("participant_id", "WHOA1A_PLI", "HEIGHT_PRELI", "WEIGHT_PRELI")
df2 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"), na = "ND") %>%
  select(all_of(vars)) %>%
  mutate(BMI = WEIGHT_PRELI / (HEIGHT_PRELI^2))
stopifnot(nrow(df2) == 168, ncol(df2) == 5)

vars <- c(
  "participant_id", "FORM_F_VISIT", "WHOA2A", "PLIMRI", "ERYLIMRI", "PLI", "ERYLI", "PLI2",
  "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", "MARS6V", "MARS7V", "MARS8V",
  "MARS9V", "MARS10V"
)
df3 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-visits_form-visit_version-2.tsv"), na = "ND") %>%
  select(all_of(vars)) %>%
  filter(FORM_F_VISIT == "F_VISIT_1") %>%
  select(-FORM_F_VISIT) %>%
  rename_with(~ gsub("V", "_M03", .), starts_with("MARS"))
stopifnot(nrow(df3) == 142, ncol(df3) == 17)

vars <- c(
  "participant_id", "MARS1_PRELI", "MARS2_PRELI", "MARS3_PRELI", "MARS4_PRELI", "MARS5_PRELI",
  "MARS6_PRELI", "MARS7_PRELI", "MARS8_PRELI", "MARS9_PRELI", "MARS10_PRELI",
  "QIDSTSC_PRELI", "BRMSTSC_PRELI"
)
df4 <- read_tsv(file.path(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"), na = "ND") %>%
  select(all_of(vars))
stopifnot(nrow(df4) == 168, ncol(df4) == 13)

vars <- c("participant_id", "Response.Status.at.end.of.follow.up")
df5 <- read_tsv(file.path(INPUT, "dataset-clinical_version-2_outcome.tsv"), na = "ND") %>%
  select(all_of(vars)) %>%
  mutate(participant_id = paste0("sub-", participant_id))
stopifnot(nrow(df5) == 159, ncol(df5) == 2)

# Merge tables using "participant_id"
#table <- reduce(list(df1, df2, df3, df4, df5), left_join, by = "participant_id")
table <- merge(merge(merge(merge(df1, df2), df3), df4), df5)


# Export to Excel
write.xlsx(table, file.path(OUTPUT, "data_demoSmokLiMarsResponse_rtidyverse.xlsx"), overwrite = TRUE)
