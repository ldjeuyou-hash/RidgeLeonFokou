#' genere un graphique des erreurs de validation croisée
#'  en fonction de la valeur de pénalité lambda
#'
#' @param cv_error vecteur des erreurs de validation croisée
#' @param lambda_grid vecteur des valeurs de pénalité
#'
#' @returns un graphique des erreurs de validation croisée
#'  en fonction de la valeur de pénalité lambda
#' @export
#'
#' @examples
#'  plot_errors(cv_error = c(0.3, 0.4, 0.5), lambda_grid = c(0.1, 1, 10))
plot_errors <- function(
    cv_error
    , lambda_grid
) {
    ggplot2::ggplot(mapping = ggplot2::aes(x = lambda_grid, y = cv_error)) +
    ggplot2::geom_line() +
    ggplot2::scale_x_log10() +
    ggplot2::labs(x = "Lambda", y = "Cross-Validation Error") +
    ggplot2::theme_minimal()

}