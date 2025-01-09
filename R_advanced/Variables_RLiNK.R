library(dplyr)
library(readr)
library(stringr)  # For str_detect

# List of TSV files in the working directory
tsv_files <- list.files(pattern = "*.tsv", full.names = TRUE)

# To define the name of the column "participant_id". The columns_additionnal is the one you can modify to get the data you want
column_participant_id <- "participant_id"
columns_additional <- c("AGE", "SEX", "HEIGHT_PRELI", "WEIGHT_PRELI", "WHOA1A_PLI", "DATTRQ_PLI", "TRQ3_PLI", "DATBIOMRI", "PLIMRI", "DATBIO", "PLI", "DATMARS", "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", "MARS6V", "MARS7V", "MARS8V", "MARS9V", "MARS10V", "DATINC", "AGEONSET", "MDE2_PLI", "HYPOE2_PLI", "MANE2_PLI", "MOODYN_PRELI", "TYPEP_PRELI", "QIDSTSC_PRELI", "DATBRMS_PRELI", "BRMSTSC_PRELI", "SCHOOL_PRELI")

# To read and combine the files and to select the columns of interest
data_combined <- lapply(tsv_files, function(fichier) {
  # To read the files
  data <- read_tsv(fichier, show_col_types = FALSE)
  
  # To select all the columns containing "CTQ" in their names
  # ctq_columns <- grep("CTQ", colnames(data), value = TRUE)

  # To add participant_id at the selected columns. If you want to have the CTQ data, add "ctq_columns" in the function, after the "columns_additional"
  columns_present <- unique(c(column_participant_id, columns_additional))
  
  # To verify if the columns exist in the DataFrame
  columns_present <- intersect(columns_present, colnames(data))
  cat(fichier, columns_present, '\n')
  
  if (length(columns_present) > 0) {
    return(data[columns_present])  # To return the DataFrame with the columns of interest
  } else {
    warning(paste("None of the columns of interest are present in", fichier))
    return(NULL)  # Return NULL is none of the columns exist
  }
})

# To remove Nulls of the list
data_combined <- Filter(Negate(is.null), data_combined)

# Combine all DataFrames into one
final_result <- bind_rows(data_combined)

# To group by participant_id and summarise
grouped_results <- final_result %>%
  group_by(participant_id) %>%
  summarise(across(everything(), ~ first(na.omit(.)), .names = "{col}"), .groups = 'drop')

# To export combined and grouped data as a CSV file
write_csv(grouped_results, "DataRLiNK.csv")