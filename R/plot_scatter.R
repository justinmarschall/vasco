#' Plot Scatter
#'
#' Scatter plots for all combinations of numeric variables.
#'
#' @param df A data frame.
#' @param plot_reduce Boolean.  Deduplicate variable list before plotting?  Defaults to TRUE.  See Details below for more information.
#' @param n Threshold for max number of plots.  Defaults to 50.
#' @param ... Optional arguments passed to geom_point().
#'
#' @details The plot_reduce argument serves to deduplicate the variables plotted by plot_scatter().
#' For instance, when set to TRUE (default), plot_scatter() will return the (x, y) plot, but not (y, x).
#' This is determined alphabetically.  In no case will the (x, x) plot be produced.
#'
#' The argument n sets the max number of plots allowed by the plotting function.  This is done to prevent producing a large number of plots by accident.
#' Change this value to override the default of 50.
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
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
      dplyr::mutate(Var1 = as.character(.data$Var1),
                    Var2 = as.character(.data$Var2),
                    check = .data$Var1 == .data$Var2,
                    min = pmin(.data$Var1, .data$Var2),
                    max = pmax(.data$Var1, .data$Var2),
                    combine_vars = paste(.data$min, .data$max),
                    dup = duplicated(.data$combine_vars)) %>%
      dplyr::filter(.data$check != TRUE,
                    .data$dup != TRUE) %>%
      dplyr::select(.data$min, .data$max) %>%
      dplyr::rename(var1 = .data$min,
                    var2 = .data$max)

  } else {
    plot_vars <-
      expand.grid(plot_vars, plot_vars) %>%
      dplyr::mutate(Var1 = as.character(.data$Var1),
                    Var2 = as.character(.data$Var2),
                    check = .data$Var1 == .data$Var2) %>%
      dplyr::filter(.data$check != TRUE) %>%
      dplyr::rename(var1 = .data$Var1,
                    var2 = .data$Var2)

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
