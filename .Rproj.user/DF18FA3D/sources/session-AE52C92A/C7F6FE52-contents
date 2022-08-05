# Recapitulando
library(palmerpenguins)

# Três maneiras de se referir a uma função

# Por referência

is_even <- function(n) {

  n %% 2 == 0

}

purrr::keep(1:10, is_even)

# Por lambda

purrr::keep(1:10, ~ .x %% 2 == 0)

# por função anônima

purrr::keep(1:10, function(paradinha) {

  paradinha %% 2 == 0

})


# keep e discard são opostas uma da outra

purrr::keep(1:10, is_even)
purrr::discard(1:10, is_even)

# Funções de alta ordem: funções que recebem como argumento
# outras funções

# Predicados de alta ordem: são funções que retornam
# verdadeiro ou falso
# e também recebem como argumento outras funções

purrr::every(1:10, is_even)

purrr::every(
  letters,
  ~ .x %in% c("a", "e", "i", "o", "u"))

purrr::some(1:10, is_even)

purrr::some(
  letters,
  ~ .x %in% c("a", "e", "i", "o", "u"))

purrr::none(1:10, is_even)

purrr::none(
  letters,
  ~ .x %in% c("a", "e", "i", "o", "u"))

# Aplicação de funções

# Situação problema: crie uma lista com os logs
# de valores de um vetor qualquer

vetor_original <- 1:10

vetor_resultado <- c()

for (i in 1:length(vetor_original)) {

  vetor_resultado[i] <- log(vetor_original[i])

}

# sem loops:

# não se modificam os argumentos

sequencia <- 1:10

purrr::map(sequencia, ~ log(.x))

# detalhe: map sempre retorna uma lista

# variantes tipadas de map

# map_dbl: para números reais
# map_int: para números inteiros
# map_chr: para texto
# map_lgl: para lógica/booleanos

purrr::map_dbl(1:10, ~ log(.x))

purrr::map_chr(letters, toupper)

purrr::map_lgl(1:10, is_even)

# Workflow Lista-Coluna
# dica: tem um capítulo no R for Data Science sobre isso

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::group_nest()

palmerpenguins::penguins %>%
  dplyr::group_by(species, island) %>%
  dplyr::group_nest()

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::group_split()

# um modelo de exemplo:

lm(
  body_mass_g ~ species + sex + bill_length_mm,
  data = palmerpenguins::penguins) ->
  modelo

# criando uma base de modelos

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::group_nest() %>%
  dplyr::mutate(
    models = purrr::map(
      data,
      ~ lm(
        body_mass_g ~ sex + bill_length_mm,
        data = .x)),
    graphs = purrr::map(
      data,
      function(data) {

        data %>%
          ggplot2::ggplot(
            ggplot2::aes(
              x = bill_length_mm,
              y = body_mass_g,
              color = island)) +
          ggplot2::geom_point() +
          ggplot2::labs(
            x = "Tamanho do bico (mm)",
            y = "Massa corporal (g)") +
          ggplot2::theme_minimal()
      }
    ))


# Outro exemplo: estimar a distribuição de um coeficiente
# por subset regressions

1:500 %>%
  purrr::map(
  ~ dplyr::sample_frac(palmerpenguins::penguins, .5)) %>%
  tibble::tibble(data = .) %>%
  dplyr::mutate(
    models = purrr::map(
      data,
      ~ lm(
        body_mass_g ~ sex + bill_length_mm,
        data = .x)),
    betas = purrr::map_dbl(
      models,
      ~ coefficients(.x) %>%
        purrr::pluck("bill_length_mm"))) ->
  experiment

experiment %>%
  ggplot2::ggplot(
    ggplot2::aes(x = betas)) +
  ggplot2::geom_histogram()

# Funções úteis: pluck e chuck

# entra uma lista com nomes e uma chave
# sai o valor da chave

list(
  A = 1,
  B = 2,
  C = 3) %>%
  purrr::pluck("F")

# Efeitos Colaterais e Walk

# o pipe de exposição

palmerpenguins::penguins %>%
  dplyr::pull(island) %>%
  table()

palmerpenguins::penguins %$%
  table(island, sex)

purrr::map2(
  .x = 1:10,
  .y = 1:10,
  .f = ~ .x + .y)

penguins %>%
  dplyr::group_by(species) %>%
  dplyr::group_nest() %$%
  purrr::walk2(
    .x = species,
    .y = data,
    .f = ~ readr::write_csv2(
      .y,
      glue::glue("data/penguins/{.x}.csv")))

fs::dir_ls("data/penguins/") %>%
  purrr::map(readr::read_csv2)

# Reduce e accumulate

# como lidamos com uma lista de dataframes?

fs::dir_ls("data/penguins/") %>%
  purrr::map(readr::read_csv2)


# alguns exemplos de reduce

letters %>%
  purrr::reduce(~ glue::glue("{.x}, {.y}"))

1:10 %>%
  purrr::reduce(~ .x + .y)

letters %>%
  purrr::accumulate(~ glue::glue("{.x}, {.y}"))

1:10 %>%
  purrr::accumulate(~ .x + .y)

# bind_rows e empilhamento

A <- tibble::tibble(
  chave = 1,
  valor = "alguma coisa")

B <- tibble::tibble(
  chave = 2,
  valor = "outra coisa")

dplyr::bind_rows(A, B)

# como lidamos com uma lista de dataframes?

"data/penguins/" %>%
  fs::dir_ls() %>%
  purrr::map(readr::read_csv2) %>%
  purrr::reduce(dplyr::bind_rows)

fs::dir_ls("data/penguins/") %>%
  purrr::map_dfr(readr::read_csv2)

purrr::map_dfc(1:3, ~ rnorm(100))

# Fábrica de Funções

# Definição: são funções cujo retorno são outras funções

linear_function <- function(a, b) {

  function(x) {

    a + x*b

  }

}

saudacoes <- function(horario, nome) {

  glue::glue("{horario}, {nome}!")

  }

saudacoes("Tarde", "Fulano")

saudacoes2 <- function(horario) {

  function(nome) {

    glue::glue("{horario}, {nome}!")

  }

}

saudacoes2("Tarde")("Fulano")

# a curva de exemplo é a função f(x) = 2 + 2x

curva_exemplo <- linear_function(2, 2)

tidyr::expand_grid(
  a = 1:10,
  b = -5:5) %>%
  dplyr::mutate(
    fns = purrr::map2(
      .x = a,
      .y = b,
      .f = linear_function))

curva_exemplo(5)

# Currying:

# usar parênteses seguidos

sum(2, 2, 2)
`+`(2, 2)

`%>%`(2, log) # a mesma coisa que 2 %>% log()

`<-` %>% is.function()
# currying: usar parênteses seguidos

linear_function(2, 2)(5)

power <- function(n) {

  function(x) {x^n}

  }

square <- power(2)
cube <- power(3)

square(2)
cube(2)

power(2)(3)

power2 <- function(n) {

  function(x) {

    function() {

      x^n

      }
  }

}

power2(2)(3)()

# Advérbios funcionais


consulta_api <- function() {

  if (runif(1) < .1) {

    rlang::abort("Houve uma falha no processamento da função.")

  } else {

    tibble::tibble(
      user_id = stringi::stri_rand_strings(n = 1, length = 16),
      context_device_id = stringi::stri_rand_strings(n = 1, length = 16),
      context_device_os = sample(c("Android", "OSX"), size = 1),
      context_device_appversion = glue::glue("2.{sample(1:10, size = 1)}")) %>%
      return()

  }

}

tibble::tibble(
  dados = purrr::map(1:100, ~ consulta_api()))

# Fábricas de funções que modificam o comportamento de funções que já existem

consulta_api_segura <- purrr::possibly(consulta_api, otherwise = NA)

tibble::tibble(
  dados = purrr::map(1:100, ~ consulta_api_segura())) %>%
  dplyr::filter(purrr::map_lgl(dados, ~ !length(.x) == 1)) %$%
  purrr::reduce(dados, dplyr::bind_rows)

purrr::keep(1:10, purrr::negate(is_even))

purrr::discard(1:10, purrr::negate(is_even))

is_odd <- purrr::negate(is_even)