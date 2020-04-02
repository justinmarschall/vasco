#' Plot Bar
#'
#' Plot a distribution for all categorical variables.
#'
#' @param df A data frame.
#' @param n Threshold for number of plots passed to plot_check().  Defaults to 50.
#' @param ... Optional arguments passed to geom_bar().
#'
#' @return
#' @export
#'
#' @examples
#' plot_bar(iris)
plot_bar <- function(df, n = 50) {
  plot_vars <- get_categorical_vars(df)

  plot_check(plot_vars, n)

  purrr::map(plot_vars, function(x) {
    x_en <- rlang::ensym(x)

    ggplot2::ggplot(df, ggplot2::aes(!!x_en)) +
      ggplot2::geom_bar(...) +
      ggplot2::labs(y = "Frequency",
                    title = paste("Distribution of", x)) +
      ggplot2::theme_minimal()

  })

}
