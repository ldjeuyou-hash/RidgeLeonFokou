#' Title
#'
#' @param nfolds
#' @param n
#'
#' @returns
#' @export
#'
#' @examples
Folds <- function(
    nfolds = 5
    , n
){
    sample(rep(seq_len(nfolds), length.out = n))
}

#' Fonction permettant de réaliser la validation croisée pour la regression ridge
#'
#' @param X dataframe de données
#' @param Y valeur réponse à modéliser
#' @param lambda_grid vecteur de valeurs de pénalité à tester
#' @param nfolds nombre de folds pour la validation croisée
#'
#' @returns les erreurs de validation croisée pour chaque valeur de pénalité
#' @export
#'
#' @examples
#'  cv_ridge_R(X = RidgeLeonFokou:::X, Y = RidgeLeonFokou:::Y, lambda_grid = 10^seq(from = -5, to = 5, by = 0.1), nfolds = 5)
cv_ridge_R <- function(
    X
    , Y
    , lambda_grid = 10^seq(from = -5, to = 5, by = 0.1)
    , nfolds
    , folds
) {

  cv_error <- numeric(length(lambda_grid))

  # Boucle sur les valeurs de lambda
  for (j in seq_along(lambda_grid)) {

    total_error <- 0
    total_n <- 0

    # Boucle sur les folds
    for (k in seq_len(nfolds)) {
      
      test <- folds == k
      train <- !test

      # Ajustement sur les données d'entraînement
      beta <- get_ridge_beta(
        X = X[train, ]
        , Y = Y[train]
        , Lambda = lambda_grid[j]
      )

      # Prédiction sur le fold de validation
      pred <- get_ridge_prediction(
        X_input = X[test, ]
        , beta = beta
      )

      # Erreur quadratique
      total_error <- total_error +
        sum((Y[test] - pred)^2)

      total_n <- total_n + sum(test)
    }

    cv_error[j] <- total_error / total_n
  }

  data.frame(
    lambda = lambda_grid,
    cv_error = cv_error
  )
}