library(tidyverse)
library(palmerpenguins)

## Começando um gráfico com ggplot2.

## Forma ótima.
ggplot2::ggplot(
  data = palmerpenguins::penguins,
  aes(x = bill_length_mm, y = flipper_length_mm)) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(method = "loess")


## Pontos com cores

ggplot2::ggplot(
  data = palmerpenguins::penguins,
  aes(x = bill_length_mm, y = flipper_length_mm, color = island)) +
  ggplot2::geom_point()

## Forma sub-ótima.
ggplot2::ggplot(data = palmerpenguins::penguins) +
  ggplot2::geom_point(
    aes(x = bill_length_mm, y = flipper_length_mm)) +
  ggplot2::geom_smooth(
    aes(x = bill_length_mm, y = flipper_length_mm),
    method = "lm")

## Boxplot

ggplot2::ggplot(data = palmerpenguins::penguins) +
  ggplot2::geom_boxplot(aes(y = body_mass_g))

## Histograma

# Ajusta a quantidade de bins.
ggplot2::ggplot(data = palmerpenguins::penguins) +
  ggplot2::geom_histogram(aes(
    x= body_mass_g,
    fill = sex,
    bins = 40))

## Ajusta tamanho dos bins.
ggplot2::ggplot(data = palmerpenguins::penguins) +
  ggplot2::geom_histogram(aes(
    x= body_mass_g,
    fill = sex),
    binwidth = 50)

ggplot2::ggplot(data = palmerpenguins::penguins) +
  ggplot2::geom_histogram(aes(
    x= body_mass_g,
    fill = sex),
    alpha = 0.7,
    position = "identity")


## Observando a estrutura do nosso DataFrame

View(palmerpenguins::penguins) ## Ver DataFrame como "planilha"

str(palmerpenguins::penguins) ## Ver estrutura do DataFrame

dplyr::glimpse(palmerpenguins::penguins) ## Ver estrutura do DataFrame (mais bonito)

#- Ambas as funções abaixo retornam o mesmo gráfico.

palmerpenguins::penguins %>%
  ggplot2::ggplot(aes(x = species)) +
  ggplot2::geom_bar()

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::summarise(n = dplyr::n()) %>%
  ggplot2::ggplot(aes(x = species, y = n)) +
  ggplot2::geom_bar(stat = "identity") +
  ggplot2::labs(
    title = "Número de penguins por espécie",
    subtitle = "Mediçoes feitas na Antártida",
    x = "Espécie",
    y = "Quantidade",
    caption = "Dados do dataset Palmer Penguins") +
  ggplot2::theme_classic()

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::summarise(n = dplyr::n()) %>%
  ggplot2::ggplot(aes(x = species, y = n)) +
  ggplot2::geom_bar(stat = "identity") +
  ggplot2::labs(
    title = "Número de penguins por espécie",
    subtitle = "Mediçoes feitas na Antártida",
    x = "Espécie",
    y = "Quantidade",
    caption = "Dados do dataset Palmer Penguins") +
  ggthemes::theme_stata()


## Facets! Divide um gráfico em multiplos com base em variável selecionada.
palmerpenguins::penguins %>%
  ggplot2::ggplot(aes(x = species)) +
  ggplot2::geom_bar() +
  ggplot2::facet_grid(~ island)

#-----------

# install.packages("nycflights13")
library(nycflights13)

nycflights13::flights %>%
  dplyr::mutate(
    date = lubridate::make_date(
      year = year,
      month = month,
      day = day)) %>%
  dplyr::filter(month == 1) %>%
  dplyr::group_by(date) %>%
  dplyr::summarise(n = dplyr::n()) %>%
  ggplot2::ggplot(aes(x = date, y = n)) +
  ggplot2::geom_line(size = 1.1, color = "#b5124b")

#------------

palmerpenguins::penguins %>%
  ggplot2::ggplot(aes(y = body_mass_g, fill = sex)) +
  ggplot2::geom_boxplot() +
  ggplot2::facet_wrap(~ species)


#------- Exercicios

# 1.  Fazer um grafico de pontos (geom_point), que cruza o comprimento do bico dos penguins
# com a massa deles. E adicionar uma reta de regressao linear ('lm').

grafico <- palmerpenguins::penguins %>%
  ggplot2::ggplot(
    ggplot2::aes(
      x = bill_length_mm,
      y = body_mass_g)) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(method = 'lm')


grafico +
  ggplot2::labs(
    title = "Relação tamanho de bico x massa",
    caption = "Fonte: Horst (2021)",
    x = "Comprimento do bico (mm)",
    y = "Massa corporal (g)") +
  ggplot2::theme_minimal()


# 2. Incrementar o gráfico anterior, modificando-o para que cada espécie possua uma
# reta de regressão. Se possível, de forma que a cor da reta e dos pontos sejam
# a mesma por espécie.


grafico2 <- palmerpenguins::penguins %>%
  ggplot2::ggplot(
    ggplot2::aes(
      x = bill_length_mm,
      y = body_mass_g,
      color = species)) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(method = 'lm')

palmerpenguins::penguins %>%
  ggplot2::ggplot(
    ggplot2::aes(
      x = bill_length_mm,
      y = body_mass_g,
      color = species)) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(method = 'lm') ->
  grafico2

grafico2 +
  ggplot2::labs(
    title = "Relação tamanho de bico x massa",
    caption = "Fonte: Horst (2021)",
    x = "Comprimento do bico (mm)",
    y = "Massa corporal (g)",
    color = "Espécie") +
  ggplot2::theme_minimal()


# 3. Fazer um boxplot de tamanho de bico, colorido de acordo com a espécie,
# e facetando (facet_wrap) de acordo com o sexo.

palmerpenguins::penguins %>%
  ggplot2::ggplot(
    ggplot2::aes(
      y = bill_length_mm,
      color = species)) +
  ggplot2::geom_boxplot() +
  ggplot2::facet_wrap(~ sex)


## DESAFIO:
## Faça uma funçao que receba como argumento um gráfico de ggplot2,
## e retorne ele com a legenda (caption) "Eu fiz o gráfico!".

adiciona_legenda <- function(graph) {

  graph +
    ggplot2::labs(
      caption = "Eu fiz o gráfico!")

}

grafico %>%
  adiciona_legenda()
