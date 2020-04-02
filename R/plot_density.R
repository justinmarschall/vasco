#' Plot Density
#'
#' Plot a density distribution for all numeric variables.
#'
#' @param df A data frame.
#' @param n Threshold for max number of plots.  Defaults to 50.
#' @param ... Optional arguments passed to geom_density().
#'
#' @details The argument n sets the max number of plots allowed by the plotting function.
#' This is done to prevent producing a large number of plots by accident.
#' Change this value to override the default of 50.
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
