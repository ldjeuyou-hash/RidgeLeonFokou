#' @export
plot.ridge <- function(
    x
    , ...
) {
  stopifnot(
    inherits(x, "ridge")
  )

  re <- x$cv_results

  return(plot_errors(cv_error = re$cv_error, lambda_grid = re$lambda))

}