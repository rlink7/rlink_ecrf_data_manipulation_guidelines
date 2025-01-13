library(openxlsx)

# %% Set path to inout data and output results according to your local configuration

INPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/data/"
OUTPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/outputs/"

# 1. Read and manipulate data
# ===========================

# 1.1 Variables from file "dataset-clinical_mod-inclusion_version-2.tsv"

vars <- c("participant_id", "AGE", "SEX")
df1 <- read.csv(paste0(INPUT, "dataset-clinical_mod-inclusion_version-2.tsv"), 
                sep = "\t", header = TRUE, na.strings = "ND")
df1 <- df1[, vars]
stopifnot(nrow(df1) == 168, ncol(df1) == 3) # Optional check

# 1.2 Variables from file "dataset-clinical_mod-baseline_version-2.tsv"

vars <- c("participant_id", "WHOA1A_PLI", "HEIGHT_PRELI", "WEIGHT_PRELI",
          "MARS1_PRELI", "MARS2_PRELI", "MARS3_PRELI", "MARS4_PRELI", 
          "MARS5_PRELI", "MARS6_PRELI", "MARS7_PRELI", "MARS8_PRELI", "MARS9_PRELI", 
          "MARS10_PRELI", "QIDSTSC_PRELI", "BRMSTSC_PRELI")
df2 <- read.csv(paste0(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"),
                sep = "\t", header = TRUE, na.strings = "ND")

df2 <- df2[, vars]
df2$BMI <- df2$WEIGHT_PRELI / (df2$HEIGHT_PRELI^2) * 100^2
stopifnot(nrow(df2) == 168, ncol(df2) == 17) # Optional check

# 1.3 Variables from file "dataset-clinical_mod-visits_form-visit_version-2.tsv"

vars <- c("participant_id", "FORM_F_VISIT", "WHOA2A", "PLIMRI", "ERYLIMRI", "PLI", 
          "ERYLI", "PLI2", "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", 
          "MARS6V", "MARS7V", "MARS8V", "MARS9V", "MARS10V")
df3 <- read.csv(paste0(INPUT, "dataset-clinical_mod-visits_form-visit_version-2.tsv"),
                sep = "\t", header = TRUE, na.strings = "ND")
df3 <- df3[, vars]
# Select visits at month 3 => FORM_F_VISIT == 'F_VISIT_1'
df3 <- df3[df3$FORM_F_VISIT == "F_VISIT_1", ]
df3 <- df3[, !names(df3) %in% "FORM_F_VISIT"]

# Optional, rename columns: MARS1V => MARS1_M03
colnames(df3)[grep("MARS", colnames(df3))] <- sub("V$", "_M03", colnames(df3)[grep("MARS", colnames(df3))])
stopifnot(nrow(df3) == 142, ncol(df3) == 17) # Optional check

# 1.4 Variables from file "dataset-clinical_version-2_outcome.tsv"

vars <- c("participant_id", "Response.Status.at.end.of.follow.up")
df4 <- read.csv(paste0(INPUT, "dataset-clinical_version-2_outcome.tsv"), 
                  sep = "\t", header = TRUE, na.strings = "ND")
df4 <- df4[, vars]
df4$participant_id <- paste0("sub-", df4$participant_id)
stopifnot(nrow(df4) == 159, ncol(df4) == 2) # Optional check

# 2. Merge tables
# ===============

table <- merge(merge(merge(df1, df2), df3), df4)
stopifnot(nrow(table) == 141, ncol(table) == 36) # Optional check

# 3. Save to Excel
# ================

write.xlsx(table, file.path(OUTPUT, "data_demoSmokLiMarsResponse_r.xlsx"), overwrite = TRUE)

