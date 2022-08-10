

testthat::test_that("Fábrica de gráficos funciona", {

  r4ds::graph_factory("histogram") %>%
    rlang::is_function() %>%
    testthat::expect_true()

})
