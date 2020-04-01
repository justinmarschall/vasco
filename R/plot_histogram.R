#' Plot Histogram
#'
#' Plot a histogram distribution for all numeric variables.
#'
#' @param df A data frame.
#' @param n_bins Number of bins to pass to geom_histogram().  Defaults to 30.
#' @param n Threshold for number of plots passed to plot_check().  Defaults to 50.
#'
#' @return
#' @export
#'
#' @examples
#' plot_histogram(iris)
plot_histogram <- function(df, n_bins = 30, n = 50) {
  plot_vars <- get_numeric_vars(df)

  plot_check(plot_vars, n)

  purrr::map(plot_vars, function(x) {
    x_en <- rlang::ensym(x)

    ggplot2::ggplot(df, ggplot2::aes(!!x_en)) +
      ggplot2::geom_histogram(bins = n_bins) +
      ggplot2::labs(y = "Frequency",
                    title = paste("Distribution of", x)) +
      ggplot2::theme_minimal()

  })

}
