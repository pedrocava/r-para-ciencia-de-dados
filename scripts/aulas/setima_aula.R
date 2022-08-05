# Aplicação parcial

palmerpenguins::penguins %>%
  dplyr::group_by(species) %>%
  dplyr::summarise(
    dplyr::across(
      tidyselect::ends_with("mm"),
      ~ mean(.x, na.rm = TRUE)))

minha_media <- purrr::partial(mean, na.rm = TRUE)

  palmerpenguins::penguins %>%
    dplyr::group_by(species) %>%
    dplyr::summarise(
      dplyr::across(
        tidyselect::ends_with("mm"),
        purrr::partial(mean, na.rm = TRUE)))

  lobstr::ast(
    palmerpenguins::penguins %>%
      dplyr::group_by(species) %>%
      dplyr::summarise(
        dplyr::across(
          tidyselect::ends_with("mm"),
          minha_media)))

# SQL usando o basedosdados

basedosdados::set_billing_id("basedd-cava")


## A query mais básica

consulta1 <- "
SELECT
  `basedosdados.br_ibge_pib.municipio`.id_municipio
FROM `basedosdados.br_ibge_pib.municipio`"

basedosdados::read_sql(consulta1)

consulta2 <- "
SELECT
  pib.id_municipio
FROM `basedosdados.br_ibge_pib.municipio` AS pib"

basedosdados::read_sql(consulta2)

consulta3 <- "
SELECT
  *
FROM `basedosdados.br_ibge_pib.municipio` AS pib"

basedosdados::read_sql(consulta3)


consulta4 <- "
SELECT
  *
FROM `basedosdados.br_ibge_pib.municipio` AS pib
WHERE pib.ano >= 2010"

basedosdados::read_sql(consulta4)

"SELECT
  id_municipio
FROM `basedosdados.br_ibge_pib.municipio`" %>%
  basedosdados::read_sql()

consulta5 <- "
SELECT
  *
FROM `basedosdados.br_ibge_pib.municipio` AS pib
WHERE pib.ano >= 2010
  OR pib.id_municipio LIKE '%11'"

consulta5 %>%
  basedosdados::read_sql()

consulta6 <- "
SELECT
  *
FROM `basedosdados.br_ibge_pib.municipio` AS pib
LEFT JOIN `basedosdados.br_ibge_populacao.municipio` as pop
ON pib.id_municipio = pop.id_municipio
  AND pib.ano = pop.ano

WHERE pib.ano >= 2010
  OR pib.id_municipio LIKE '%11'"

consulta6 %>%
  basedosdados::read_sql()

# Exercícios

# 10 sector

r4ds::url_10sector() %>%
  r4ds::get_raw_10sector() %T>%
  r4ds::save_raw_10sector() %>%
  r4ds::clean_10sector() %T>%
  r4ds::save_clean_10sector() ->
  data

data %>%
  ...
