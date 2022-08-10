# teste

# alguma mudança bem boba

#' @export

fibonacci <- function(n) {

  if (n == 1 | n == 2) {

    return(1)

  } else {

    return(fibonacci(n-1) + fibonacci(n-2))

  }

}

#' @export
# fatorial de um número

factorial <- function(n) {

  if (n == 0) {

    return(1)

  } else {

    return(n*factorial(n-1))

  }

}

# máximo divisor comum

#' @export

gcd <- function(x, y) {

  if ((! x >= 0) | (! y >= 0)) {

    rlang::abort("X and y must be positive integers.")

  }

  if (y == 0) {

    return(x)

  } else {

    gcd(y, x %% y)

  }

}