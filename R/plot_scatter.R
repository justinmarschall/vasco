#' Plot Scatter
#'
#' Scatter plots for all combinations of numeric variables.
#'
#' @param df A data frame.
#' @param plot_reduce Boolean.  Deduplicate variable list before plotting?  Defaults to TRUE.  See Details below for more information.
#' @param n Threshold for number of plots passed to plot_check().  Defaults to 50.
#' @param ... Optional arguments passed to geom_point().
#'
#' @details The plot_reduce argument serves to deduplicate the variables plotted by plot_scatter().  For instance, when set to TRUE (default), plot_scatter() will return the (x, y) plot, but not (y, x).  This is determined alphabetically.  In no case will the (x, x) plot be produced.
#'
#' @return
#' @export
#'
#' @examples
#' plot_scatter(iris)
#'
#' plot_scatter(iris, plot_reduce = TRUE, n = 50, ggplot2::aes(color = Species))
plot_scatter <- function(df, plot_reduce = TRUE, n = 50, ...) {
  plot_vars <- get_numeric_vars(df)

  if(plot_reduce) {
    plot_vars <-
      expand.grid(plot_vars, plot_vars) %>%
      dplyr::mutate(Var1 = as.character(Var1),
                    Var2 = as.character(Var2),
                    check = Var1 == Var2,
                    min = pmin(Var1, Var2),
                    max = pmax(Var1, Var2),
                    combine_vars = paste(min, max),
                    dup = duplicated(combine_vars)) %>%
      dplyr::filter(check != TRUE,
                    dup != TRUE) %>%
      dplyr::select(min, max) %>%
      dplyr::rename(var1 = min,
                    var2 = max)

  } else {
    plot_vars <-
      expand.grid(plot_vars, plot_vars) %>%
      dplyr::mutate(Var1 = as.character(Var1),
                    Var2 = as.character(Var2),
                    check = Var1 == Var2) %>%
      dplyr::filter(check != TRUE) %>%
      dplyr::rename(var1 = Var1,
                    var2 = Var2)

  }

  plot_check(plot_vars$var1, n)

  purrr::map2(plot_vars$var1, plot_vars$var2, function(x, y) {
    x_en <- rlang::ensym(x)
    y_en <- rlang::ensym(y)

    ggplot2::ggplot(df, ggplot2::aes(!!x_en, !!y_en)) +
      ggplot2::geom_point(...) +
      ggplot2::labs(title = paste("Distribution of", x, "and", y)) +
      ggplot2::theme_minimal()

  })

}
