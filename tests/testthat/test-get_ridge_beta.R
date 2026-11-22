testthat::test_that("Verifions que le nombre de beta est egal au nombre de colonnes du data frame en entré", {
  testthat::expect_equal(
    nrow(
      get_ridge_beta(
        X_input = RidgeLeonFokou::X,
        Y_input = RidgeLeonFokou::Y,
        lambda = 1
      )
    ),
    ncol(stats::model.matrix(~ ., data = as.data.frame(RidgeLeonFokou::X)))
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

  design_matrix <- stats::model.matrix(~ ., data = as.data.frame(X))
  expected <- matrix(0, nrow = ncol(design_matrix), ncol = 1)

  testthat::expect_equal(
    unname(get_ridge_beta(X_input = X, Y_input = Y, lambda = 1)),
    expected
  )
})