#' Jeu de données pour l'ajustement d'un modèle Ridge
#'
#' Un jeu de données simulé utilisé pour illustrer les fonctions
#' de la librairie.
#'
#' @format Un data frame contenant 1000 observations et 4 variables :
#' \describe{
#'   \item{x0}{Variable correspondant a Beta0}
#'   \item{x1}{Première variable explicative numérique genere par stats::rnorm(n, mean = 2, sd = 5)}
#'   \item{x2}{Deuxième variable explicative numérique genere par stats::rnorm(n, mean = 4, sd = 20)}
#'   \item{x3}{Troisième variable explicative numérique genere par stats::rpois(n, lambda = 4)}
#'   \item{x4}{Troisième variable explicative numérique genere stats::rgamma(n, shape = 4, rate = 1)}
#' }
#'
#' @source Données simulées.
#' @keywords internal
#' @name X



#' Variable finale a calculer
#'
#' Variable finale a générer en utilisant la regression ridge.
#'
#' @format Un data frame contenant 1000 observations :
#'
#' @source Données générée par 4.5 x X[,2] + 2.7 x X[,3] + sin(X[,4])+ 0.7 x X[,5]
#' @keywords internal
#' @name Y
