#' Plot Check
#'
#' A helper function to avoid plotting more than you'd prefer.
#'
#' @param plot_vars A vector of variables to be plotted.
#' @param n Plot threshold as set in plot_*() function.
#'
#' @details Function will fail if length(plot_vars) > n.
#'
#' @return
#' @export
#'
#' @examples
plot_check <- function(plot_vars, n) {
  if(length(plot_vars) > n) {
    stop(paste0("Number of plots (", length(plot_vars), ") is greater than plot_check() threshold (", n, ").  Change value of n and try again."))
  }

}
