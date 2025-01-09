library(dplyr)
library(readr)
library(stringr)  # Pour str_detect

# Liste des fichiers TSV dans le répertoire courant
fichiers_tsv <- list.files(pattern = "*.tsv", full.names = TRUE)

# Obtenir les noms des colonnes
variables_disponibles <- colnames(fichiers_tsv)

# Initialiser un vecteur pour stocker les noms de colonnes
noms_colonnes <- character()

# Lire chaque fichier et extraire les noms des colonnes
for (fichier in fichiers_tsv) {
  data <- read.delim(fichier)
  noms_colonnes <- unique(c(noms_colonnes, colnames(data)))
}

# Afficher les noms de colonnes disponibles
#cat("Colonnes disponibles :\n")
#print(noms_colonnes)

# Fonction pour demander des colonnes à ajouter
demander_colonnes <- function() {
  choix <- readline(prompt = "Enter the names of the columns you want to add, separated by comma, and then click Enter: ")
  choix <- strsplit(choix, ",")[[1]]
  choix <- trimws(choix)  # Supprimer les espaces superflus
  return(choix)
}

choix <- demander_colonnes()

print(choix)

# Ajoute les choix à colonnes_additionnelles
colonnes_additionnelles <- c("AGE", choix)


# Définir le nom de la colonne participant_id
colonne_participant_id <- "participant_id"

# Lire et combiner les fichiers tout en sélectionnant les colonnes d'intérêt
donnees_combinees <- lapply(fichiers_tsv, function(fichier) {
  # Lire le fichier TSV
  data <- suppressWarnings(read_tsv(fichier, show_col_types = FALSE))
  
  # Vérifier les colonnes disponibles
  #print(paste("Fichier:", fichier))
  #print(colnames(data))  # Afficher les noms de colonnes
  
  # Sélectionner uniquement les colonnes qui contiennent "CTQ" et participant_id
  # colonnes_ctq <- grep("CTQ", colnames(data), value = TRUE)
  
  # Ajouter participant_id aux colonnes sélectionnées
  colonnes_presentes <- unique(c(colonne_participant_id, colonnes_additionnelles))
  
  # Vérifier si les colonnes présentes existent dans le DataFrame
  colonnes_presentes <- intersect(colonnes_presentes, colnames(data))
  
  
  if (length(colonnes_presentes) > 0) {
    return(data[colonnes_presentes])  # Retourner le DataFrame avec les colonnes d'intérêt
  } else {
    warning(paste("Aucune des colonnes d'intérêt n'est présente dans", fichier))
    return(NULL)  # Retourner NULL si aucune colonne n'existe
  }
})

# Retirer les NULLs de la liste
donnees_combinees <- Filter(Negate(is.null), donnees_combinees)

# Combiner tous les DataFrames en un seul
resultat_final <- bind_rows(donnees_combinees)

# Regrouper par participant_id et résumer
resultat_groupé <- resultat_final %>%
  group_by(participant_id) %>%
  summarise(across(everything(), ~ first(na.omit(.)), .names = "{col}"), .groups = 'drop')

print(resultat_groupé)

# Exporter les données combinées et regroupées en fichier CSV
#write_csv(resultat_groupé, "DataRLiNK.csv")