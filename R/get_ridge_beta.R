#' Fonction permettant de générer les betas a partir de la
#'  regression ridge pour un dataframe et une reponse donnee
#'
#' @param X_input dataframe de données
#' @param Y_input Valeur reponse a modéliser
#' @param lambda Penalite a apporter sur la fonction de perte
#' @returns les betas associés aux données d'entree permettant
#' d'obtenir la valeur reponse selon ridge
#'
get_ridge_beta <- function(
    X_input = RidgeLeonFokou::X,
    Y_input = RidgeLeonFokou::Y,
    lambda = 2
) {
  df <- stats::model.matrix(~ ., data = as.data.frame(X_input))
  solve(t(df) %*% df + lambda * diag(ncol(df))) %*% t(df) %*% Y_input
}