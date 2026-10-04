#' Fonction permettant de générer les betas a partir de la regression ridge pour un dataframe et une reponse donnee
#'
#' @param X dataframe de données
#' @param Y Valeur finale a modéliser
#' @param lambda
#'
#' @returns
#' @export
#'
#' @examples
get_ridge_beta <- function(
    X = X,
    Y = Y,
    lambda = 2
) {

  solve(t(X) %*% X + lambda * diag(ncol(X)))%*%t(X)%*%Y

}
