
#' Fonction permettant de générer un objet de classe "ridge" à partir
#' d'un dataframe et d'une valeur réponse donnée
#'
#' @param X_input données d'entrée
#' @param Y_input valeur réponse à modéliser
#' @param lambda_grid vecteur des valeurs de pénalité
#' @param n_folds nombre de plis pour la validation croisée
#' @param name nom de l'objet
#'
#' @returns un objet de classe "ridge"
#' @export
#' @examples ridge(X_input = RidgeLeonFokou::X,  Y_input = RidgeLeonFokou::Y, lambda_grid = 10^seq(from = -5, to = 5, by = 0.1), n_folds = 5, name = "Object Ridge")
#'
ridge <- function(
    X_input = RidgeLeonFokou::X
    ,Y_input = RidgeLeonFokou::Y
    ,lambda_grid = 10^seq(from = -5, to = 5, by = 0.1)
    ,n_folds = 5
    ,name = "Object Ridge"
) {

  stopifnot(
    is.matrix(X_input) || is.data.frame(X_input),
    is.numeric(Y_input),
    nrow(X_input) == length(Y_input),
    is.numeric(lambda_grid),
    length(name) == 1
  )

  selection <- select_lambda(
    X_input = X_input,
    Y_input = Y_input,
    lambda_grid = lambda_grid,
    n_folds = n_folds
  )

  structure(
    list(
      X = X_input
      , Y = Y_input
      , lambda_grid = lambda_grid
      , n_folds = n_folds
      , ideal_lambda = selection$lambda
      , min_cv_error = selection$cv_error
      , betas = get_ridge_beta(
          X_input = X_input,
          Y_input = Y_input,
          lambda = selection$lambda
        )
      , name = name
    ),
    class = "ridge"
  )
}

