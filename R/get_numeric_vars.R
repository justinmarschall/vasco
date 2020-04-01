#' Get Numeric Variables
#'
#' A helper function.
#'
#' @param df A data frame.
#'
#' @return
#' @importFrom magrittr %>%
#'
#' @examples
get_numeric_vars <- function(df) {
  df %>%
    dplyr::select_if(is.numeric) %>%
    names()

}
