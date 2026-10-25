testthat::test_that("La prediction est nulle si les betas sont nuls", {
  X <- matrix(c(1, 2,
                3, 4), ncol = 2, byrow = TRUE)

  beta <- matrix(0, nrow = 2, ncol = 1)

  expected <- matrix(c(0, 0), nrow = 2, ncol = 1)

  testthat::expect_equal(
    get_ridge_prediction(X_input = X, beta = beta),
    expected
  )
})

testthat::test_that("La prediction correspond bien au produit X * beta", {
  X <- matrix(
    c(1, 2, 3,
      4, 5, 6),
    nrow = 3,
    byrow = TRUE
  )

  beta <- matrix(c(1, -1), nrow = 2, ncol = 1)

  expected <- X %*% beta

  testthat::expect_equal(
    get_ridge_prediction(X_input = X, beta = beta),
    expected
  )
})