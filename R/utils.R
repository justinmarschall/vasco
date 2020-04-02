#' @importFrom magrittr %>%

# these are all helper functions

get_numeric_vars <- function(df) {
  df %>%
    dplyr::select_if(is.numeric) %>%
    names()

}

character_factor <- function(x) {
  is.character(x) | is.factor(x)

}

get_categorical_vars <- function(df) {
  df %>%
    dplyr::select_if(character_factor) %>%
    names()

}

plot_check <- function(plot_vars, n) {
  if(length(plot_vars) > n) {
    stop(paste0("Number of plots (", length(plot_vars), ") is greater than threshold (", n, ").  Change value of n and try again."))
  }

}
