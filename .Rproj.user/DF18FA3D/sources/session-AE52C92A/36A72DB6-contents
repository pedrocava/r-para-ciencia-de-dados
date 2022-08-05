#' @export

url_10sector <- function() {

  "https://www.rug.nl/ggdc/docs/10sd_jan15_2014.xlsx"

}

#' @export
#' @name get_raw_10sector
#' @param file o endereço do arquivo ou link da base

get_raw_10sector <- function(file = url_10sector()) {

  file %>%
    rio::import(
      setclass = "tibble",
      which = 2)

}

#' @export
#'

save_raw_10sector <- function(data = r4ds::get_raw_10sector()) {

  data %>%
    readr::write_csv2("data/10sector/raw_data.csv")

}

#' @export
#'

save_clean_10sector <- function(data = r4ds::clean_10sector()) {

  data %>%
    readr::write_csv2("data/10sector/clean_data.csv")

}

#' @export
#' @name clean_10sector

clean_10sector <- function(data = r4ds::get_raw_10sector()) {

  data %>%
    tidyr::pivot_longer(
      cols = .data$Agriculture:.data$`Summation of sector GDP`,
      names_to = "sector") %>%
    tidyr::pivot_wider(
      values_from = .data$value,
      names_from = .data$Variable) %>%
    janitor::clean_names()

}