# Fonction permettant de générer un objet de classe "ridge" à partir d'un dataframe et d'une valeur réponse donnée

Fonction permettant de générer un objet de classe "ridge" à partir d'un
dataframe et d'une valeur réponse donnée

## Usage

``` r
ridge(
  X_input = RidgeLeonFokou::X,
  Y_input = RidgeLeonFokou::Y,
  lambda_grid = 10^seq(from = -5, to = 5, by = 0.1),
  n_folds = 5,
  name = "Object Ridge"
)
```

## Arguments

- X_input:

  données d'entrée

- Y_input:

  valeur réponse à modéliser

- lambda_grid:

  vecteur des valeurs de pénalité

- n_folds:

  nombre de plis pour la validation croisée

- name:

  nom de l'objet

## Value

un objet de classe "ridge"

## Examples

``` r
ridge(X_input = RidgeLeonFokou::X
,  Y_input = RidgeLeonFokou::Y
, lambda_grid = 10^seq(from = -5, to = 5, by = 0.1)
, n_folds = 5
, name = "Object Ridge")
#> Object Ridge
#> Nom: Object Ridge 
#> Nombre de predicteurs: 4 
#> Nombre d'observations: 1000 
#> Domaine de Lambda : [1e-05, 1e+05]  avec 101 valeurs et pas de 990.099
#> Lambda optimal obtenu par validation croisee: 1.584893 
#> Erreur de validation croisee minimale: 0.4439006 
#> Nombre de folds pour la validation croisee: 5 
```
