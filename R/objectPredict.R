#' @export
predict.ridge <- function(
    obj
    , X = obj$X
    , ...
) {
    stopifnot(
        inherits(obj, "ridge"),
        is.matrix(X) || is.data.frame(X) || is.vector(X) || is.numeric(X)
    )
    
    beta <- obj$betas
    return(get_ridge_prediction(X_input = X, beta = beta))
  
}