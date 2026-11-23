#' @export
plot.ridge <- function(
    x
    , ...
) {
  stopifnot(
    inherits(x, "ridge")
  )

  re <- cv_ridge_R(
    X_input = x$X
    , Y_input = x$Y
    , lambda_grid = x$lambda_grid
    , nfolds = x$n_folds
  )

  return(plot_errors(cv_error = re$cv_error, lambda_grid = re$lambda))

}