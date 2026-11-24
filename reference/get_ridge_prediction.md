# Fonction Permettant de generer des predictions pour les betas generes par la regression ridge

Fonction Permettant de generer des predictions pour les betas generes
par la regression ridge

## Usage

``` r
get_ridge_prediction(
  X_input = RidgeLeonFokou::X,
  beta = get_ridge_beta(X_input = RidgeLeonFokou::X, Y_input = RidgeLeonFokou::Y, lambda
    = 1)
)
```

## Arguments

- X_input:

  dataframe de données

- beta:

  les betas associés aux données d'entree permettant d'obtenir la valeur
  reponse selon ridge

## Value

La prediction associee aux donnees en entre
