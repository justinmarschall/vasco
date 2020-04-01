#' Get Categorical Variables
#'
#' A helper function.
#'
#' @param df A data frame.
#'
#' @return
#' @importFrom magrittr %>%
#'
#' @examples
character_factor <- function(x) {
  is.character(x) | is.factor(x)

}

get_categorical_vars <- function(df) {
  df %>%
    dplyr::select_if(character_factor) %>%
    names()

}
