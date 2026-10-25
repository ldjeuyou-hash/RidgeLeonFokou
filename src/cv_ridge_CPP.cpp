#include <Rcpp.h>

#include <cmath>

using namespace Rcpp;

// [[Rcpp::export]]
DataFrame cv_ridge_cpp(
    DataFrame X,
    NumericVector Y,
    NumericVector lambda_grid,
    int nfolds,
    IntegerVector folds
) {
  const int n = X.nrows();
  const int p = X.size();

  if (p == 0) {
    stop("X doit contenir au moins une colonne numerique.");
  }
  if (Y.size() != n || folds.size() != n) {
    stop("X, Y et folds doivent contenir le meme nombre d'observations.");
  }
  if (nfolds < 1) {
    stop("nfolds doit etre strictement positif.");
  }

  NumericMatrix x(n, p);
  for (int column = 0; column < p; ++column) {
    SEXP x_column = X[column];
    if (!Rf_isNumeric(x_column) || Rf_isFactor(x_column)) {
      stop("Toutes les colonnes de X doivent etre numeriques et non factorielles.");
    }

    for (int row = 0; row < n; ++row) {
      double value;
      if (TYPEOF(x_column) == REALSXP) {
        value = REAL(x_column)[row];
      } else if (TYPEOF(x_column) == INTSXP) {
        const int integer_value = INTEGER(x_column)[row];
        if (integer_value == NA_INTEGER) {
          stop("X ne doit pas contenir de valeurs manquantes.");
        }
        value = integer_value;
      } else {
        stop("Toutes les colonnes de X doivent etre numeriques.");
      }

      if (!std::isfinite(value)) {
        stop("X ne doit pas contenir de valeurs non finies.");
      }
      x(row, column) = value;
    }
  }

  for (int row = 0; row < n; ++row) {
    if (!std::isfinite(Y[row])) {
      stop("Y ne doit pas contenir de valeurs manquantes ou non finies.");
    }
    if (folds[row] == NA_INTEGER || folds[row] < 1 || folds[row] > nfolds) {
      stop("Chaque valeur de folds doit etre comprise entre 1 et nfolds.");
    }
  }

  Environment package_env = Environment::namespace_env("RidgeLeonFokou");
  Function get_ridge_beta = package_env["get_ridge_beta"];
  Function get_ridge_prediction = package_env["get_ridge_prediction"];

  NumericVector cv_error(lambda_grid.size());

  for (R_xlen_t lambda_index = 0;
       lambda_index < lambda_grid.size();
       ++lambda_index) {
    const double lambda = lambda_grid[lambda_index];
    if (!std::isfinite(lambda) || lambda < 0.0) {
      stop("Les valeurs de lambda doivent etre finies et positives ou nulles.");
    }

    double total_error = 0.0;
    int total_n = 0;

    for (int fold = 1; fold <= nfolds; ++fold) {
      int train_n = 0;
      int test_n = 0;
      for (int row = 0; row < n; ++row) {
        if (folds[row] == fold) {
          ++test_n;
        } else {
          ++train_n;
        }
      }
      if (test_n == 0) {
        continue;
      }

      NumericMatrix x_train(train_n, p);
      NumericVector y_train(train_n);
      NumericMatrix x_test(test_n, p);
      NumericVector y_test(test_n);
      int train_row = 0;
      int test_row = 0;

      for (int row = 0; row < n; ++row) {
        if (folds[row] == fold) {
          y_test[test_row] = Y[row];
          for (int column = 0; column < p; ++column) {
            x_test(test_row, column) = x(row, column);
          }
          ++test_row;
        } else {
          y_train[train_row] = Y[row];
          for (int column = 0; column < p; ++column) {
            x_train(train_row, column) = x(row, column);
          }
          ++train_row;
        }
      }

      SEXP beta = get_ridge_beta(
          Named("X_input") = x_train,
          Named("Y_input") = y_train,
          Named("lambda") = lambda
      );

      NumericMatrix predictions = get_ridge_prediction(
          Named("X_input") = x_test,
          Named("beta") = beta
      );

      if (predictions.nrow() != test_n || predictions.ncol() != 1) {
        stop("get_ridge_prediction doit retourner une prediction par observation.");
      }

      for (int row = 0; row < test_n; ++row) {
        const double residual = y_test[row] - predictions(row, 0);
        total_error += residual * residual;
      }
      total_n += test_n;
    }

    if (total_n == 0) {
      stop("Aucune observation utilisee pour la validation.");
    }
    cv_error[lambda_index] = total_error / total_n;
  }

  return DataFrame::create(
      Named("lambda") = lambda_grid,
      Named("cv_error") = cv_error
  );
}
