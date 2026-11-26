#' Fonction permettant de prédire les valeurs de
#' la variable réponse pour un objet de classe ridge
#' 
#' @param object un objet de classe ridge
#'
#' @param dt les données pour lesquelles faire des prédictions
#' 
#' @param ... paramètres supplémentaires pour la fonction predict
#'
#' @export
predict.ridge <- function(
    object
    , dt = object$X
    , ...
) {
    stopifnot(
        inherits(object, "ridge"),
        is.matrix(dt) || is.data.frame(dt) || is.vector(dt) || is.numeric(dt)
    )

    beta <- object$betas
    return(get_ridge_prediction(X_input = dt, beta = beta))

}
