# Fonction permettant de générer les betas a partir de la regression ridge pour un dataframe et une reponse donnee

Fonction permettant de générer les betas a partir de la regression ridge
pour un dataframe et une reponse donnee

## Usage

``` r
get_ridge_beta(
  X_input = RidgeLeonFokou::X,
  Y_input = RidgeLeonFokou::Y,
  lambda = 2
)
```

## Arguments

- X_input:

  dataframe de données

- Y_input:

  Valeur reponse a modéliser

- lambda:

  Penalite a apporter sur la fonction de perte

## Value

les betas associés aux données d'entree permettant d'obtenir la valeur
reponse selon ridge
