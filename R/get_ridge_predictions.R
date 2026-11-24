#' Fonction Permettant de generer des predictions pour les betas generes par la regression ridge
#'
#' @param X_input dataframe de données
#' @param beta les betas associés aux données d'entree permettant d'obtenir la valeur reponse selon ridge
#'
#' @returns La prediction associee aux donnees en entre
#'
get_ridge_prediction <- function(
    X_input = RidgeLeonFokou::X,
    beta = get_ridge_beta(X_input = RidgeLeonFokou::X, Y_input = RidgeLeonFokou::Y, lambda = 1)
){
    df <- stats::model.matrix(~ ., data = as.data.frame(rbind(X_input)))
    return(as.matrix(df) %*% beta)
}