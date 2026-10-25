
#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
DataFrame cv_ridge_cpp(
    DataFrame X,
    NumericVector Y,
    NumericVector lambda_grid,
    int nfolds,
    IntegerVector folds
) {
  int n = X.nrows();

  // Recuperation des fonctions R existantes
  Environment env = Environment::global_env();

  Function get_ridge_beta = env["get_ridge_beta"];
  Function get_ridge_prediction = env["get_ridge_prediction"];

  // Initialisation des erreurs CV
  NumericVector cv_error(lambda_grid.size());

  // Boucle sur les valeurs de lambda
  for (int j = 0; j < lambda_grid.size(); ++j) {

    double total_error = 0.0;
    int total_n = 0;

    // Boucle sur les folds
    for (int k = 1; k <= nfolds; ++k) {

      // Indices des observations de test et train
      LogicalVector test(n);
      LogicalVector train(n);

      for (int i = 0; i < n; ++i) {
        test[i] = (folds[i] == k);
        train[i] = !test[i];
      }

      // Extraction des donnees d'entrainement
      DataFrame X_train = X[train, _];
      NumericVector Y_train = Y[train];

      // Ajustement Ridge avec la fonction R
      SEXP beta = get_ridge_beta(
        Named("X_input") = X_train,
        Named("Y_input") = Y_train,
        Named("lambda") = lambda_grid[j]
      );

      // Extraction des donnees de test
      DataFrame X_test = X[test, _];
      NumericVector Y_test = Y[test];

      // Prediction avec la fonction R
      NumericVector pred = get_ridge_prediction(
        Named("X_input") = X_test,
        Named("beta") = beta
      );

      // Calcul de l'erreur quadratique
      for (int i = 0; i < Y_test.size(); ++i) {
        double residual = Y_test[i] - pred[i];
        total_error += residual * residual;
      }

      total_n += Y_test.size();
    }

    if (total_n == 0) {
      stop("Aucune observation utilisee pour la validation.");
    }

    cv_error[j] = total_error / total_n;
  }

  return DataFrame::create(
    Named("lambda") = lambda_grid,
    Named("cv_error") = cv_error
  );
}
