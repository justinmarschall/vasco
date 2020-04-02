#' Plot Density
#'
#' Plot a density distribution for all numeric variables.
#'
#' @param df A data frame.
#' @param n Threshold for number of plots passed to plot_check().  Defaults to 50.
#' @param ... Optional arguments passed to geom_density().
#'
#' @export
#'
#' @examples
#' plot_density(iris)
plot_density <- function(df, n = 50, ...) {
  plot_vars <- get_numeric_vars(df)

  plot_check(plot_vars, n)

  purrr::map(plot_vars, function(x) {
    x_en <- rlang::ensym(x)

    ggplot2::ggplot(df, ggplot2::aes(!!x_en)) +
      ggplot2::geom_density(...) +
      ggplot2::labs(y = "Density",
                    title = paste("Distribution of", x)) +
      ggplot2::theme_minimal()

  })

}
