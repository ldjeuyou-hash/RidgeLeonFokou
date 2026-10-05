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
