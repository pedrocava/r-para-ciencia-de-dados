

# sobras do dplyr

tibble::tibble(
  dates = lubridate::today() - lubridate::days(0:90),
  value = rnorm(length(dates))) %>%
  dplyr::mutate(
    lag1 = dplyr::lag(value, 1),
    lag5 = dplyr::lag(value, 5),
    lead1 = dplyr::lead(value, 2),
    normalizado_pelo_primeiro = value / dplyr::first(value))

tidyr::expand_grid(
  dates = lubridate::today() - lubridate::days(0:90),
  ticker = c("PETR3", "VALE3", "CURSOR5")) %>%
  dplyr::mutate(value = rnorm(length(dates))) %>%
  dplyr::group_by(ticker) %>%
  dplyr::summarise(
    primeiro = dplyr::first(dates),
    segundo = dplyr::last(dates))


# referência a nomes de colunas

palmerpenguins::penguins %>%
  dplyr::mutate(
    body_mass_norm = body_mass_g /
      sd(body_mass_g, na.rm = TRUE))

nova_penguins <- palmerpenguins::penguins

nova_penguins["body_mass_norm"] <- nova_penguins["body_mass_g"] /
  sd(nova_penguins["body_mass_g"], na.rm = TRUE)


# curl-curly: {{coluna}}, vem no pacote rlang

library(rlang)

how_many_NAs <- function(data, column) {

  objeto <- 2

  data %>%
    dplyr::filter(is.na({{column}})) %>%
    nrow()

}

how_many_NAs(
  palmerpenguins::penguins,
  body_mass_g)

# abstração de histograma


histogram <- function(data, column) {

  data %>%
    ggplot2::ggplot(
      ggplot2::aes(x = {{column}})) +
    ggplot2::geom_histogram() +
    ggplot2::theme_minimal()

}

palmerpenguins::penguins %>%
  histogram(body_mass_g) +
  ggplot2::labs(
    title = "Nosso histograma gerado com o curly curly",
    x = "Massa corporal (g)",
    caption = "olha só que legal")

scatterplot <- function(data, x, y) {

  data %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = {{x}},
        y = {{y}})) +
    ggplot2::geom_point() +
    ggplot2::theme_minimal()

}

palmerpenguins::penguins %>%
  r4ds::graph_factory("scatterplot")(., bill_length_mm, body_mass_g)


# rlang::enexpr transforma símbolos (código) em strings usáveis


mean_by <- function(data, grouping, var) {

  data %>%
    dplyr::group_by({{grouping}}) %>%
    dplyr::summarise(
      {{var}} := mean({{var}}, na.rm = TRUE))

}

# := é o operador para usar símbolos como nomes de argumentos

palmerpenguins::penguins %>%
  mean_by(species, body_mass_g)


dotdotdot <- function(...) {

  list(...)

}

dotdotdot(a = 1, b = 2, 3)

summarise_by <- function(data, grouping, ...) {

  data %>%
    dplyr::group_by({{grouping}}) %>%
    dplyr::summarise(...)

}

palmerpenguins::penguins %>%
  summarise_by(
    species,
    peso_medio = mean(body_mass_g, na.rm = TRUE),
    sd_peso = sd(body_mass_g, na.rm = TRUE))

