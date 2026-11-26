#' Fonction permettant d'afficher les informations sur un objet de classe ridge
#'
#' @param x un objet de classe ridge
#'
#' @param ... paramètres supplémentaires pour la fonction print
#'
#' @export
print.ridge <- function(
    x
    , ...
) {
   cat("Object Ridge\n")
   cat("Nom:", x$name, "\n")
   cat("Nombre de predicteurs:", ncol(x$X), "\n")
   cat("Nombre d'observations:", nrow(x$X), "\n")
   cat(
    "Domaine de Lambda : [",
    min(x$lambda_grid),
    ", ",
    max(x$lambda_grid),
    "] ",
    " avec ", length(x$lambda_grid), " valeurs",
    " et pas de ", (max(x$lambda_grid) - min(x$lambda_grid)) / length(x$lambda_grid),
    "\n",
    sep = ""
  )
   cat("Lambda optimal obtenu par validation croisee:", x$ideal_lambda, "\n")
   cat("Erreur de validation croisee minimale:", x$min_cv_error, "\n")
   cat("Nombre de folds pour la validation croisee:", x$n_folds, "\n")

   invisible(x)
}
