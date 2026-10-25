testthat::test_that("cv_ridge_R retourne le meme nombre de valeurs que lambda_grid", {
  X <- as.matrix(data.frame(
    x = 1:5,
    zero = rep(0, 5)
  ))
  Y <- 2 * X[, 1]

  lambda_grid <- c(0.1, 1, 10)

  result <- cv_ridge_R(
    X = X,
    Y = Y,
    lambda_grid = lambda_grid,
    nfolds = 2,
    folds = Folds(nfolds = 2, n = nrow(X))
  )

  testthat::expect_equal(length(result$cv_error), length(lambda_grid))
})
