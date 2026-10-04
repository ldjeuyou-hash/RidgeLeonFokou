#' Fonction permettant de générer les betas a partir de la regression ridge pour un dataframe et une reponse donnee
#'
#' @param X_input dataframe de données
#' @param Y_input Valeur reponse a modéliser
#' @param lambda Penalite a apporter sur la fonction de perte
#'
#' @returns les betas associés aux données d'entree permettant d'obtenir la valeur reponse selon ridge
#' @export
#'
#' @examples
#'   get_ridge_beta (X_input = X, Y_input = Y, lambda = 1)
get_ridge_beta <- function(
    X_input = X,
    Y_input = Y,
    lambda = 2
) {

  solve(t(X_input) %*% X_input + lambda * diag(ncol(X_input))) %*% t(X_input) %*% Y_input

}
