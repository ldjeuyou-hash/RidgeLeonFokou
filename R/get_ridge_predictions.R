#' Fonction Permettant de generer des predictions pour les betas generes par la regression ridge
#'
#' @param X_input dataframe de données
#' @param beta les betas associés aux données d'entree permettant d'obtenir la valeur reponse selon ridge
#'
#' @returns La prediction associee aux donnees en entre
#' @export
#'
#' @examples
#'   get_ridge_prediction(X_input = matrix(c(1.2, 3.4, 1, 4.5, 0.7), nrow = 5, ncol = 1), beta = matrix(1:5, nrow = 5, ncol = 1))
get_ridge_prediction <- function(
    X_input,
    beta
){

}
