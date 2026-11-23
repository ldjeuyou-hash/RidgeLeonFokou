#' @export
predict.ridge <- function(
    object
    , X = object$X
    , ...
) {
    stopifnot(
        inherits(object, "ridge"),
        is.matrix(X) || is.data.frame(X) || is.vector(X) || is.numeric(X)
    )
    
    beta <- object$betas
    return(get_ridge_prediction(X_input = X, beta = beta))
  
}