testthat::test_that("cv_ridge_cpp retourne les memes erreurs que cv_ridge_R", {
  X <- cbind(
    x1 = c(1, 2, 4, 5, 7, 8),
    x2 = c(2, 1, 3, 6, 5, 9),
    x3 = rep(1, 6)
  )
  Y <- c(2, 1, 5, 4, 8, 7)
  lambda_grid <- c(0.1, 1, 10)
  folds <- c(1L, 2L, 3L, 1L, 2L, 3L)

  expected <- cv_ridge_R(
    X_input = X,
    Y_input = Y,
    lambda_grid = lambda_grid,
    nfolds = 3,
    folds = folds
  )
  result <- RidgeLeonFokou:::cv_ridge_cpp(
    X = X,
    Y = Y,
    lambda_grid = lambda_grid,
    nfolds = 3,
    folds = folds
  )

  testthat::expect_equal(result$lambda, expected$lambda)
  testthat::expect_equal(result$cv_error, expected$cv_error, tolerance = 1e-10)
})
