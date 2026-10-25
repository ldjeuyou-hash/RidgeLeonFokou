#' Selectionne le meilleur lambda en fonction des parametres entrés
#'
#' @param X_input
#' @param Y_input
#' @param lambda_grid
#' @param n_folds
#'
#' @returns
#' @export
#'
#' @examples
select_lambda <- function(
    X_input = X,
    Y_input = Y,
    lambda_grid = seq(0, 10, length.out = 100),
    n_folds = 5
){
  folds <- Folds(nfolds = n_folds, n = nrow(X_input))

  cv_results <- cv_ridge_R(
    X = X_input,
    Y = Y_input,
    lambda_grid = lambda_grid,
    nfolds = n_folds,
    folds = folds
  )

  best_lambda <- cv_results[which.min(cv_results$cv_error), ]

  return(best_lambda)
}
