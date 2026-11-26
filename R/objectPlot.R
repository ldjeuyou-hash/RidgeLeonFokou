#' Fonction permettant de tracer un graphe des
#' erreurs de validation croisée pour la regression ridge
#' pour chaque valeur de pénalité en parametre
#'
#' @param x un objet de classe ridge
#'
#' @param ... paramètres supplémentaires pour la fonction plot
#'
#' @export
plot.ridge <- function(
    x
    , ...
) {
  stopifnot(
    inherits(x, "ridge")
  )

  re <- x$cv_results

  return(plot_errors(cv_error = re$cv_error, lambda_grid = re$lambda))

}
