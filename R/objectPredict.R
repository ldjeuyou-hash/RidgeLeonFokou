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