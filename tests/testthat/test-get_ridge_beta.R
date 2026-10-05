testthat::test_that("Verifions que le nombre de beta est egal au nombre de colonnes du data frame en entré", {
  testthat::expect_equal(
    nrow(
      get_ridge_beta(
        X_input = RidgeLeonFokou:::X,
        Y_input = RidgeLeonFokou:::Y,
        lambda = 1
      )
    ),
    ncol(RidgeLeonFokou:::X)
  )
})

testthat::test_that("Si Y est nul, les betas sont nuls", {
  X <- matrix(
    c(1, 2,
      3, 4,
      5, 6),
    nrow = 3,
    byrow = TRUE
  )

  Y <- c(0, 0, 0)

  expected <- matrix(0, nrow = ncol(X), ncol = 1)

  testthat::expect_equal(
    get_ridge_beta(X_input = X, Y_input = Y, lambda = 1),
    expected
  )
})