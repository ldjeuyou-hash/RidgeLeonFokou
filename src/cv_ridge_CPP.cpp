#include <Rcpp.h>

#include <algorithm>
#include <cmath>
#include <vector>

using namespace Rcpp;

static std::vector<double> solve_ridge_system(
    const std::vector<double>& gram,
    const std::vector<double>& xty,
    int dimension,
    double lambda
) {
  std::vector<double> matrix(gram);
  std::vector<double> rhs(xty);
  for (int column = 0; column < dimension; ++column) {
    matrix[column * dimension + column] += lambda;
  }

  for (int pivot_column = 0; pivot_column < dimension; ++pivot_column) {
    int pivot_row = pivot_column;
    double pivot_size = std::fabs(
        matrix[pivot_row * dimension + pivot_column]
    );

    for (int row = pivot_column + 1; row < dimension; ++row) {
      const double candidate = std::fabs(
          matrix[row * dimension + pivot_column]
      );
      if (candidate > pivot_size) {
        pivot_size = candidate;
        pivot_row = row;
      }
    }

    if (pivot_size == 0.0 || !std::isfinite(pivot_size)) {
      stop("Le systeme ridge est singulier pour une valeur de lambda donnee.");
    }

    if (pivot_row != pivot_column) {
      for (int column = pivot_column; column < dimension; ++column) {
        std::swap(
            matrix[pivot_column * dimension + column],
            matrix[pivot_row * dimension + column]
        );
      }
      std::swap(rhs[pivot_column], rhs[pivot_row]);
    }

    const double pivot = matrix[pivot_column * dimension + pivot_column];
    for (int row = pivot_column + 1; row < dimension; ++row) {
      const double factor =
          matrix[row * dimension + pivot_column] / pivot;
      matrix[row * dimension + pivot_column] = 0.0;
      for (int column = pivot_column + 1; column < dimension; ++column) {
        matrix[row * dimension + column] -=
            factor * matrix[pivot_column * dimension + column];
      }
      rhs[row] -= factor * rhs[pivot_column];
    }
  }

  for (int row = dimension - 1; row >= 0; --row) {
    for (int column = row + 1; column < dimension; ++column) {
      rhs[row] -= matrix[row * dimension + column] * rhs[column];
    }
    const double diagonal = matrix[row * dimension + row];
    if (diagonal == 0.0 || !std::isfinite(diagonal)) {
      stop("Le systeme ridge est singulier pour une valeur de lambda donnee.");
    }
    rhs[row] /= diagonal;
  }

  return rhs;
}

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

  NumericVector cv_error(lambda_grid.size());

  for (R_xlen_t lambda_index = 0;
       lambda_index < lambda_grid.size();
       ++lambda_index) {
    const double lambda = lambda_grid[lambda_index];
    if (!std::isfinite(lambda) || lambda < 0.0) {
      stop("Les valeurs de lambda doivent etre finies et positives ou nulles.");
    }
  }

  std::fill(cv_error.begin(), cv_error.end(), 0.0);
  int total_n = 0;

  for (int fold = 1; fold <= nfolds; ++fold) {
    std::vector<int> test_rows;
    std::vector<double> gram(p * p, 0.0);
    std::vector<double> xty(p, 0.0);

    for (int row = 0; row < n; ++row) {
      if (folds[row] == fold) {
        test_rows.push_back(row);
        continue;
      }

      for (int column = 0; column < p; ++column) {
        const double x_column = x(row, column);
        xty[column] += x_column * Y[row];
        for (int other_column = 0; other_column < p; ++other_column) {
          gram[column * p + other_column] +=
              x_column * x(row, other_column);
        }
      }
    }

    const int test_n = static_cast<int>(test_rows.size());
    if (test_n == 0) {
      continue;
    }
    total_n += test_n;

    for (R_xlen_t lambda_index = 0;
         lambda_index < lambda_grid.size();
         ++lambda_index) {
      const double lambda = lambda_grid[lambda_index];
      const std::vector<double> coefficients =
          solve_ridge_system(gram, xty, p, lambda);

      double fold_error = 0.0;
      for (int row : test_rows) {
        double prediction = 0.0;
        for (int column = 0; column < p; ++column) {
          prediction += x(row, column) * coefficients[column];
        }
        const double residual = Y[row] - prediction;
        fold_error += residual * residual;
      }
      cv_error[lambda_index] += fold_error;
    }
  }

  if (total_n == 0) {
    stop("Aucune observation utilisee pour la validation.");
  }
  for (R_xlen_t lambda_index = 0;
       lambda_index < lambda_grid.size();
       ++lambda_index) {
    cv_error[lambda_index] /= total_n;
  }

  return DataFrame::create(
      Named("lambda") = lambda_grid,
      Named("cv_error") = cv_error
  );
}
