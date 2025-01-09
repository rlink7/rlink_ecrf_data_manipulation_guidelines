library(openxlsx)

# Set paths
INPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/data/"
OUTPUT <- "/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/outputs/"

# Read and manipulate data
vars <- c("participant_id", "AGE", "SEX")
df1 <- read.csv(paste0(INPUT, "dataset-clinical_mod-inclusion_version-2.tsv"), 
                sep = "\t", header = TRUE, na.strings = "ND")
df1 <- df1[, vars]
stopifnot(nrow(df1) == 168, ncol(df1) == 3)

vars <- c("participant_id", "WHOA1A_PLI", "HEIGHT_PRELI", "WEIGHT_PRELI")
df2 <- read.csv(paste0(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"),
                sep = "\t", header = TRUE, na.strings = "ND")

df2 <- df2[, vars]
df2$BMI <- df2$WEIGHT_PRELI / (df2$HEIGHT_PRELI^2)
stopifnot(nrow(df2) == 168, ncol(df2) == 5)

vars <- c("participant_id", "FORM_F_VISIT", "WHOA2A", "PLIMRI", "ERYLIMRI", "PLI", 
          "ERYLI", "PLI2", "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", 
          "MARS6V", "MARS7V", "MARS8V", "MARS9V", "MARS10V")
df3 <- read.csv(paste0(INPUT, "dataset-clinical_mod-visits_form-visit_version-2.tsv"),
                sep = "\t", header = TRUE, na.strings = "ND")

df3 <- df3[, vars]
df3 <- df3[df3$FORM_F_VISIT == "F_VISIT_1", ]
df3 <- df3[, !names(df3) %in% "FORM_F_VISIT"]
colnames(df3)[grep("MARS", colnames(df3))] <- sub("V$", "_M03", colnames(df3)[grep("MARS", colnames(df3))])
stopifnot(nrow(df3) == 142, ncol(df3) == 17)

vars <- c("participant_id", "MARS1_PRELI", "MARS2_PRELI", "MARS3_PRELI", "MARS4_PRELI", 
          "MARS5_PRELI", "MARS6_PRELI", "MARS7_PRELI", "MARS8_PRELI", "MARS9_PRELI", 
          "MARS10_PRELI", "QIDSTSC_PRELI", "BRMSTSC_PRELI")
df4 <- read.csv(paste0(INPUT, "dataset-clinical_mod-baseline_version-2.tsv"), 
                sep = "\t", header = TRUE, na.strings = "ND")

df4 <- df4[, vars]
stopifnot(nrow(df4) == 168, ncol(df4) == 13)

vars <- c("participant_id", "Response.Status.at.end.of.follow.up")
df5 <- read.csv(paste0(INPUT, "dataset-clinical_version-2_outcome.tsv"), 
                  sep = "\t", header = TRUE, na.strings = "ND")
df5 <- df5[, vars]
df5$participant_id <- paste0("sub-", df5$participant_id)
stopifnot(nrow(df5) == 159, ncol(df5) == 2)

# Merge tables
table <- merge(merge(merge(merge(df1, df2, by = "participant_id"), df3, by = "participant_id"), 
                     df4, by = "participant_id"), df5, by = "participant_id")
stopifnot(nrow(df5) == 141, ncol(df5) == 36)

# Save to Excel
write.xlsx(table, file.path(OUTPUT, "data_demoSmokLiMarsResponse_r.xlsx"), overwrite = TRUE)

