# Jeu de données pour l'ajustement d'un modèle Ridge

Un jeu de données simulé utilisé pour illustrer les fonctions de la
librairie.

## Usage

``` r
X
```

## Format

Un data frame contenant 1000 observations et 4 variables :

- x1:

  Première variable explicative numérique genere par stats::rnorm(n,
  mean = 2, sd = 5)

- x2:

  Deuxième variable explicative numérique genere par stats::rnorm(n,
  mean = 4, sd = 20)

- x3:

  Troisième variable explicative numérique genere par stats::rpois(n,
  lambda = 4)

- x4:

  Quatrième variable explicative numérique genere stats::rgamma(n, shape
  = 4, rate = 1)

## Source

Données simulées.
