

testthat::test_that("Fibonacci funciona", {

  r4ds::fibonacci(1) %>%
    testthat::expect_length(1)

  r4ds::fibonacci(1) %>%
    testthat::expect_gt(0)

  r4ds::fibonacci(1) %>%
    testthat::expect_lt(2)

  r4ds::fibonacci(5) %>%
    testthat::expect_equal(5)

  # como exemplo:

  # expect_true, expect_false, expect_error

})


testthat::test_that("Fibonacci funciona", {

  r4ds::gcd(-2, 2) %>%
    testthat::expect_error()

  r4ds::gcd(100, 15) %>%
    testthat::expect_equal(5)

})


