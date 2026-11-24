# Fonction permettant de réaliser la validation croisée pour la regression ridge

Fonction permettant de réaliser la validation croisée pour la regression
ridge

## Usage

``` r
cv_ridge_R(
  X_input = RidgeLeonFokou::X,
  Y_input = RidgeLeonFokou::Y,
  lambda_grid = 10^seq(from = -5, to = 5, by = 0.1),
  nfolds = 5,
  folds = Folds(nfolds = nfolds, n = nrow(RidgeLeonFokou::X))
)
```

## Arguments

- X_input:

  dataframe de données

- Y_input:

  valeur réponse à modéliser

- lambda_grid:

  vecteur de valeurs de pénalité à tester

- nfolds:

  nombre de folds pour la validation croisée

- folds:

  vecteur de longueur n contenant les indices des folds pour chaque
  observation

## Value

les erreurs de validation croisée pour chaque valeur de pénalité
