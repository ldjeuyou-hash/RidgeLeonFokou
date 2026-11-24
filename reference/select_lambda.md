# Selectionne le meilleur lambda en fonction des parametres entrés

Selectionne le meilleur lambda en fonction des parametres entrés

## Usage

``` r
select_lambda(
  X_input = RidgeLeonFokou::X,
  Y_input = RidgeLeonFokou::Y,
  lambda_grid = 10^seq(from = -5, to = 5, by = 0.1),
  n_folds = 5
)
```

## Arguments

- X_input:

  dataframe de données

- Y_input:

  valeur réponse à modéliser

- lambda_grid:

  vecteur des valeurs de pénalité

- n_folds:

  nombre de plis pour la validation croisée

## Value

le meilleur lambda sélectionné avec l'erreur de validation croisée
correspondante

## Examples

``` r
select_lambda(X_input = RidgeLeonFokou::X
 , Y_input = RidgeLeonFokou::Y
)
#>      lambda  cv_error
#> 53 1.584893 0.4391325
```
