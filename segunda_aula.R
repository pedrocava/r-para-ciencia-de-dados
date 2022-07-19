## Primeiro passo:
## Instalar palmerpenguins

install.packages("palmerpenguins")
library(palmerpenguins)

palmerpenguins::penguins

## dplyr

install.packages("dplyr")
install.packages("tidyselect")

library(dplyr)

palmerpenguins::penguins %>%
  dplyr::select(species, island, year)

palmerpenguins::penguins %>%
  dplyr::select(
    tidyselect::starts_with("bill"),
    tidyselect::ends_with("g"))

#--

palmerpenguins::penguins %>%
  dplyr::select(-island)

#--

palmerpenguins::penguins %>%
  dplyr::select(-tidyselect::starts_with("bill"))

#--

palmerpenguins::penguins %>%
  dplyr::select(
    year,
    dplyr::everything())

#--

palmerpenguins::penguins %>%
  dplyr::select(island:year)

# Tambem é possível realizar seleçoes com índices.
palmerpenguins::penguins %>%
  dplyr::select(2)

###--- Realizando filtros com dplyr::filter

palmerpenguins::penguins %>%
  dplyr::filter(bill_length_mm < 39.2)

palmerpenguins::penguins %>%
  dplyr::filter(bill_length_mm == 39.2)

palmerpenguins::penguins %>%
  dplyr::filter(bill_length_mm %in% c(39.2, 36.6))

palmerpenguins::penguins %>%
  dplyr::filter(island == "Dream" | island == "Torgersen",
                bill_length_mm > 40)

## Uma combinaçao mais complexa de condiçoes:
palmerpenguins::penguins %>%
  dplyr::filter(
    island == "Dream" |
    (island == "Torgersen" &
       bill_length_mm > 40))

### Mutate - Cria ou altera colunas.
## Mutate preserva a quantidade de linhas de um dataframe.
palmerpenguins::penguins %>%
  dplyr::mutate(bill_length_cm = bill_length_mm/10,
                island = stringr::str_to_upper(island),
                island_minuscula = stringr::str_to_lower(island)) %>%
  dplyr::select(c(species, island, bill_length_cm, island_minuscula))

palmerpenguins::penguins %>%
  dplyr::mutate(
    diff_peso_medio = body_mass_g - mean(body_mass_g, na.rm = TRUE),
    abaixo_media = diff_peso_medio < 0) %>%
  dplyr::select(species, island, diff_peso_medio, abaixo_media)


## Slice - Fatia uma coluna baseada

palmerpenguins::penguins %>%
  dplyr::slice(3:17)

palmerpenguins::penguins %>%
  dplyr::slice(94)


## Arrange - Reordena colunas!

palmerpenguins::penguins %>%
  dplyr::select(species, island, body_mass_g) %>%
  dplyr::arrange(body_mass_g)

palmerpenguins::penguins %>%
  dplyr::select(species, island, body_mass_g) %>%
  dplyr::arrange(desc(body_mass_g))

### summarise (sem grupo) - Resumindo dados.
## Nao preserva o número de linhas de um dataframe.
palmerpenguins::penguins %>%
  dplyr::summarise(
    body_mass_mean = mean(body_mass_g, na.rm = TRUE),
    body_mass_max = max(body_mass_g, na.rm = TRUE),
    body_mass_min = min(body_mass_g, na.rm = TRUE),
    body_mass_dp = sd(body_mass_g, na.rm = TRUE),
    body_mass_median = median(body_mass_g, na.rm = TRUE))

#----------- group_by e grupos!

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::summarise(
    body_mass_mean = mean(body_mass_g, na.rm = TRUE),
    body_mass_max = max(body_mass_g, na.rm = TRUE),
    body_mass_min = min(body_mass_g, na.rm = TRUE),
    body_mass_dp = sd(body_mass_g, na.rm = TRUE),
    body_mass_median = median(body_mass_g, na.rm = TRUE))


palmerpenguins::penguins %>%
  dplyr::group_by(species, island) %>%
  dplyr::summarise(
    body_mass_mean = mean(body_mass_g, na.rm = TRUE),
    body_mass_max = max(body_mass_g, na.rm = TRUE),
    body_mass_min = min(body_mass_g, na.rm = TRUE),
    body_mass_dp = sd(body_mass_g, na.rm = TRUE),
    body_mass_median = median(body_mass_g, na.rm = TRUE),
    .groups = "drop")


## Como o group_by muda o comportamento de funçoes:

palmerpenguins::penguins %>%
  dplyr::slice(1)


palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::slice(1) %>%
  dplyr::ungroup()

#-----------

palmerpenguins::penguins %>% nrow()
palmerpenguins::penguins %>% ncol()

#----------

### Exercícios:

# 1. Fazer um predicado (uma funçao) que retornará `TRUE` se o DataFrame (tibble) possuir
# o número de colunas igual ao número de linhas.


# 2. Encontre a altura média de todos os personagens de Star Wars que possuem
# olho azul.
## Os dados estao em: dplyr::starwars
dplyr::starwars

# 3. Calcule o desvio padrao (sd) do peso para cada planeta natal (homeworld). Ainda utilizando
# o dataset de Star Wars (dplyr::starwars).

