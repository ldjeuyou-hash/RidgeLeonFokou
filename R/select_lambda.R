#' Selectionne le meilleur lambda en fonction des parametres entrés
#'
#' @param X_input dataframe de données
#' @param Y_input valeur réponse à modéliser
#' @param lambda_grid vecteur des valeurs de pénalité
#' @param n_folds nombre de plis pour la validation croisée
#'
#' @returns le meilleur lambda sélectionné avec
#'  l'erreur de validation croisée correspondante
#' @export
#'
#' @examples
#' select_lambda(X_input = RidgeLeonFokou:::X
#'  , Y_input = RidgeLeonFokou:::Y
#' )
select_lambda <- function(
    X_input = X
    , Y_input = Y
    , lambda_grid = 10^seq(from = -5, to = 5, by = 0.1)
    , n_folds = 5
){
  folds <- Folds(nfolds = n_folds, n = nrow(X_input))

  cv_results <- cv_ridge_R(
    X_input = X_input,
    Y_input = Y_input,
    lambda_grid = lambda_grid,
    nfolds = n_folds,
    folds = folds
  )

  best_lambda <- cv_results[which.min(cv_results$cv_error), ]

  return(best_lambda)
}