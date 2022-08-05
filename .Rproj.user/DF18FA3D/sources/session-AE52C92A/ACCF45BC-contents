library(tidyverse)
library(magrittr)
library(stringi)

fake_user <- function() {

  tibble::tibble(
    user_id = stringi::stri_rand_strings(n = 1, length = 16),
    context_device_id = stringi::stri_rand_strings(n = 1, length = 16),
    context_device_os = sample(c("Android", "OSX"), size = 1),
    context_device_appversion = glue::glue("2.{sample(1:10, size = 1)}"))

}

# Desafio: Conseguimos fazer o campo `event_properties` variar de acordo com
# o tipo de evento?

fake_event <- function(
    device_id,
    event = sample(c("login", "deposit", "cashout"), size = 1)) {

  tibble::tibble(
    device_id = device_id,
    event_name = event,
    event_id = stringi::stri_rand_strings(n = 1, length = 16),
    event_received_at = lubridate::now() -
      lubridate::days(purrr::rdunif(1, 100)) -
      lubridate::hours(purrr::rdunif(1, 48)) -
      lubridate::minutes(purrr::rdunif(1, 60)) -
      lubridate::seconds(purrr::rdunif(1, 60)),
    event_properties = list(
      amount = runif(1, min = 10, max = 500)))

}

fake_user %$%
  fake_event(context_device_id)
