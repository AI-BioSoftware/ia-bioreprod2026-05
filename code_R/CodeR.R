# Chargement des packages nécessaires
library(readxl)
library(dplyr)
library(pheatmap)

# Étape 1: Chargement des données
# Spécifiez le chemin vers votre fichier Excel
file_path <- "../article.source/pgen.1006453.s002.xlsx"

# Lire toutes les feuilles du fichier Excel pour inspection
data <- read_excel(file_path, sheet = 1, col_names = TRUE, skip = 2)

# Inspecter les premières lignes des données pour vérifier la structure
head(data)

# Supposons que les colonnes pertinentes sont les colonnes numériques représentant les points temporels
numeric_columns <- sapply(data, is.numeric)
expression_data <- data[ , numeric_columns]

# Inspecter les données nettoyées
head(expression_data)

# Étape 2: Normalisation (si nécessaire)
# Appliquer une normalisation z-score à chaque ligne (gène)
normalize_data <- function(data) {
  apply(data, 1, scale)
}

normalized_data <- as.data.frame(normalize_data(expression_data))

# Étape 3: Visualisation
# Créer la heatmap
pheatmap(
  mat = normalized_data,
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  scale = "none",
  show_rownames = TRUE,
  show_colnames = TRUE,
  main = "Heatmap d'expression de gènes au cours du temps"
)
