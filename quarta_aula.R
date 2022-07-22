

# Joins e pareamento de dados

(A <- tibble::tibble(
  chave = sample(letters, 10),
  valor = rnorm(10)))

(B <- tibble::tibble(
  chave = sample(letters, 10),
  valor2 = rnorm(10),
  valor3 = rnorm(10)))


dplyr::left_join(A, B, by = "chave") ->
  feito_sem_tidylog

dplyr::right_join(A, B, by = "chave")

dplyr::inner_join(A, B, by = "chave")

dplyr::full_join(A, B, by = "chave")


# tidylog é um wrapper em torno do tidyverse que emite logs

tidylog::left_join(A, B, by = "chave") ->
  feito_com_tidylog

tidylog::full_join(A, B, by = "chave") ->
  feito_com_tidylog_full


# waldo compara objetos
waldo::compare(feito_sem_tidylog, feito_com_tidylog)

waldo::compare(feito_sem_tidylog, feito_com_tidylog_full)

palmerpenguins::penguins %>%
  dplyr::group_by(species) ->
  penguins_agrupado

waldo::compare(palmerpenguins::penguins, penguins_agrupado)

# Joins com dados mais interessantes


# Pergunta: quantos voos cada fabricante fez?

nycflights13::flights %>%
  tidylog::left_join(
    nycflights13::planes,
    by = "tailnum") %>%
  tidylog::group_by(manufacturer) %>%
  tidylog::summarise(numero_voos = dplyr::n()) %>%
  dplyr::arrange(dplyr::desc(numero_voos))

# nomes diferentes no join


(C <- tibble::tibble(
  identificador = sample(letters, 10),
  valor = rnorm(10)))

(D <- tibble::tibble(
  id = sample(letters, 10),
  valor2 = rnorm(10),
  valor3 = rnorm(10)))


# isso aqui funciona e não é proibido

C %>%
  dplyr::rename(id = identificador) %>%
  dplyr::left_join(D)

C %>%
  dplyr::left_join(
    D,
    by = c("identificador" = "id"))

C %>%
  dplyr::left_join(
    D,
    by = c(
      "identificador" = "id",
      "outra_varialvel" = "essa varivel"))

# existem outros joins: anti_join e semi_join


tibble::tibble(
  A = 1:2,
  B = 2:3)

tidyr::expand_grid(
  A = 1:2,
  B = 2:3)


# pivotar tabelas

tidyr::expand_grid(
  municipio = sample(letters, size = 10),
  year = 2010:2015) %>%
  dplyr::mutate(valor = rnorm(60)) %>%
  tidyr::pivot_wider(
    names_from = year,
    values_from = valor) ->
  base_wide

base_wide %>%
  tidyr::pivot_longer(
    cols = `2010`:`2015`,
    names_to = "year",
    values_to = "var")

palmerpenguins::penguins %>%
  dplyr::group_by(species, sex) %>%
  dplyr::summarise(
    N = dplyr::n(),
    .groups = "drop") %>%
  tidyr::pivot_wider(
    names_from = sex,
    values_from = N) %>%
  dplyr::select(- `NA`) %>%
  tidyr::pivot_longer(
    cols = female:male,
    values_to = "N",
    names_to = "sex")

palmerpenguins::penguins %>%
  dplyr::group_by(species, sex) %>%
  dplyr::summarise(
    N = dplyr::n(),
    .groups = "drop") %>%
  tidyr::pivot_wider(
    names_from = sex,
    values_from = N,
    values_fill = 0) %>%
  dplyr::select(- `NA`) %>%
  tidyr::pivot_longer(
    cols = female:male,
    values_to = "N",
    names_to = "sex")

palmerpenguins::penguins %>%
  dplyr::group_by(species, sex) %>%
  dplyr::summarise(
    N = dplyr::n(),
    .groups = "drop") %>%
  tidyr::pivot_wider(
    names_from = sex,
    values_from = N,
    values_fill = 0)

palmerpenguins::penguins %>%
  dplyr::group_by(species, sex) ->
  penguins_agrupados

penguins_agrupados %>%
  dplyr::summarise(
    N = dplyr::n(),
    .groups = "drop") %>%
  dplyr::mutate(sex = as.character(sex)) %>%
  tidyr::replace_na(
    list(
      sex = "non-identified",
      N = 0))

# Começando programação funcional

# Funções de Alta Ordem
# Definição: é qualquer função que recebe
# como argumento outras funções


# processar vetores e listas com prog funcional

is_even <- function(n) {

  n %% 2 == 0

}

is_even(2)
is_even(3)

# keep e discard

purrr::keep(
  1:10,
  is_even)

purrr::discard(
  1:10,
  is_even)


is_vowel <- function(x) {

  x %in% c("a", "e", "i", "o", "u")

}

is_vowel("a")
is_vowel("b")

purrr::keep(
  letters,
  is_vowel)

# Maneiras de se referir a uma função

# 1- Por referência
# é quando se passa um objeto contendo uma função

purrr::keep(
  letters,
  is_vowel)

# 2- por Lambda

# quando o corpo da função é um comando muito simples
# o lambda só comporta um comando

purrr::keep(
  letters,
  ~ .x %in% c("a", "e", "i", "o", "u"))

purrr::keep(
  1:10,
  ~ .x %% 2 == 0)

# 3- por função anônima

purrr::keep(
  letters,
  function(x) {

    vowels <- c("a", "e", "i", "o", "u")

    x %in% vowels

  })

# purrr::keep(
#   letters,
#   function(x) {
#
#     vowels <- c("a", "e", "i", "o", "u")
#
#     list(
#       result = x %in% vowels,
#       vowels = vowels)
#
#   })


# Predicados de alta ordem
# Definição: funções de alta ordem que retornam verdadeiro/falso


purrr::some(
  1:10,
  is_even)

purrr::none(
  1:10,
  is_even)

purrr::every(
  1:10,
  is_even)


# um exemplo bobinho

tibble::tibble(
  id = rep(
    sample(letters, size = 10),
    times = 100),
  valor_transacao = rnorm(1000, mean = 35, sd = 10)) ->
  fake_transactions

fake_transactions %>%
  dplyr::group_by(id) %>%
  dplyr::filter(purrr::some(valor_transacao, ~ .x > 60)) %>%
  dplyr::summarise()


# across

# where seleciona colunas de acordo

palmerpenguins::penguins %>%
  dplyr::mutate(
    dplyr::across(
      tidyselect:::where(is.factor),
      as.character),
    dplyr::across(
      tidyselect::ends_with("mm"),
      ~ .x / 10,
      .names = "{.col}_to_cm")) %>%
  dplyr::select(- tidyselect::ends_with("mm"))

processa_pengins <- function(data) {

  data %>%
    dplyr::mutate(
      dplyr::across(
        tidyselect:::where(is.factor),
        as.character),
      dplyr::across(
        tidyselect::ends_with("mm"),
        ~ .x / 10,
        .names = "{.col}_to_cm")) %>%
    dplyr::select(- tidyselect::ends_with("mm"))

}

palmerpenguins::penguins %>%
  processa_pengins()


# o jeito esquisito de manipular dados no R


base <- palmerpenguins::penguins

base$species <- as.character(base$species)
base$island <- as.character(base$island)
base$sex <- as.character()

base$bill_length_cm <- base$bill_length_mm / 10











