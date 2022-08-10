#' @export

graph_factory <- function(graph) {

  list(
    "histogram" = function(data, column) {

      data %>%
        ggplot2::ggplot(
          ggplot2::aes(x = {{column}})) +
        ggplot2::geom_histogram() +
        ggplot2::theme_minimal()

    },
    "scatterplot" = function(data, x, y) {

      data %>%
        ggplot2::ggplot(
          ggplot2::aes(
            x = {{x}},
            y = {{y}})) +
        ggplot2::geom_point() +
        ggplot2::theme_minimal() +
        ggplot2::labs(
          title = glue::glue("Gráficos de dispersão entre {rlang::enexpr(x)} e {rlang::enexpr(y)}"))

    }) %>%
    purrr::pluck(graph)

}
