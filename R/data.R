#' Jeu de données pour l'ajustement d'un modèle Ridge
#'
#' Un jeu de données simulé utilisé pour illustrer les fonctions
#' de la librairie.
#'
#' @format Un data frame contenant 1000 observations et 4 variables :
#' \describe{
#'   \item{x1}{Première variable explicative numérique genere par stats::rnorm(n, mean = 2, sd = 5)}
#'   \item{x2}{Deuxième variable explicative numérique genere par stats::rnorm(n, mean = 4, sd = 20)}
#'   \item{x3}{Troisième variable explicative numérique genere par stats::rpois(n, lambda = 4)}
#'   \item{x4}{Quatrième variable explicative numérique genere stats::rgamma(n, shape = 4, rate = 1)}
#' }
#'
#' @source Données simulées.
"X"



#' Variable finale a calculer
#'
#' Variable finale a générer en utilisant la regression ridge.
#'
#' @format Un data frame contenant 1000 observations :
#' \describe{
#'   \item{Y}{Variable réponse numérique genere par par 4.5 * X1 + 2.7 * X2 + sin(X3)+ 0.7 * X4}
#' }
#' @source Données Calculées à partir de la matrice "X" et des coefficients 4.5, 2.7, sin et 0.7. 
"Y"
