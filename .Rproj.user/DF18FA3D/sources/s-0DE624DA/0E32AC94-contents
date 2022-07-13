
library(glue)

# R como uma calculadora
# sintaxe: são as regras de escrita da linguagem

2 + 2
3 - 2
3 * 2
3 / 2
3 %% 2

3294672349875623489756 * 238476238746

# funcao(argumento)

log(2)
log(2, base = 10)
log(2, 10)
exp(5)

# atribuição & sessões

a <- 2
b <- "esse texto aqui"
# vale também para a direita: 4 -> a

## não façam isso: a = 2

# testes lógicos

## Igualdade

a == 2
a != 2

a + 2 == 4

a > 2
a >= 2
a < 2
a <= 2

! TRUE

! a == 2

# operador de pertencimento

"texto" %in% letters
"a" %in% letters

2 %in% 1:10

# funções de sorteio e vetorização

rnorm(10)
rpois(10, lambda = 1)

rnorm(10) < 0

rnorm(10) == 0

log(rpois(10, lambda = 15))
exp(rpois(10, lambda = 15))

# listas e vetores

c(1, 2, 3)
c("texto", 2, TRUE)

2 + "true"

c(1, TRUE, FALSE, "texto")

c(TRUE, FALSE)

c(1, TRUE, FALSE)

list(1, 2, "texto", TRUE)

base::list(base::list(1,2), "texto", TRUE)

## manipulação de texto

glue::glue("2 + 2 = {2 + 2}")


log(rpois(10, lambda = 15))

10 %>%
  rpois(lambda = 15) %>%
  log()

# detecção de padrão
"Pedro" %>%
  stringr::str_detect("e")

# subset de string
# "pegar um pedaço" da string

"João Pedro" %>%
  stringr::str_sub(
    start = 5,
    end = 10)

# concatenação de strings
stringr::str_c("abc", "def", sep = ", ")

# manipular capitalização do texto

frase <- "o rato roeu a roupa do rei de Roma"

frase %>%
  stringr::str_to_lower()

frase %>%
  stringr::str_to_upper()

frase %>%
  stringr::str_to_title()

# trocar texto

brasil_limpo <- "brazil" %>%
  stringr::str_replace(
    pattern = "z",
    replacement = "s") %>%
  stringr::str_to_title()

# para subsituir todas as ocorrências
# usar stringr::str_replace_all()

"brazil" %>%
  stringr::str_replace(
    pattern = "z",
    replacement = "s") %>%
  stringr::str_to_title() ->
  brasil_limpo


# contar ocorr6encias

stringr::fruit %>%
  stringr::str_count("ll")

# detectar local de ocorrência

"Texto" %>%
  stringr::str_locate("x")

stringr::fruit %>%
  stringr::str_locate("ll")

# criação de funções

termometro <- function(x) {

  if (x > 18) {

    mensagem <- glue::glue("Está muito quente, faz {x} graus.")

  } else if (x < 18) {

    mensagem <- glue::glue("Está muito frio, faz {x} graus.")

  } else if (x == 18) {

    mensagem <- glue::glue("Ahhhh, perfeito.")
  }

  mensagem

}

#termometro <- function(x) {

#  if (x > 18) {

#    glue::glue("Está muito quente, faz {x} graus.") %>%
#      return()

 # } else {

  #  glue::glue("Está muito frio, faz {x} graus.") %>%
 #     return()
#
  #}

#}

termometro(18)


termometro2 <- function(x = 24, alvo = 18) {

  if (x > alvo) {

    mensagem <- glue::glue("Está muito quente, faz {x} graus.")

  } else if (x < alvo) {

    mensagem <- glue::glue("Está muito frio, faz {x} graus.")

  } else if (x == 18) {

    mensagem <- glue::glue("Ahhhh, perfeito.")
  }

  mensagem

}


termometro2(12, 15)
termometro2(28, 30)
termometro2(32, 32)
termometro2(12)
termometro2()


# Exercícios

# 1- Cebolinha
# Crie uma função que recebe uma string chamada `frase`
# e retorna os "r" invertidos por "l"

# 2- FizzBuzz
# Crie uma função que recebe um número e:
# caso seja divisível por 3, retorne "fizz"
# caso seja divisível por 5, retorne "buzz"
# caso seja divísivel por 15, retorne "fizzbuzz"
# caso não seja nem 3, nem 5, nem 15, retorne o próprio número

# 3- número par
# crie uma função chamada `is_even` que recebe um argumento
# `n` e retorna TRUE caso n seja par, FALSE caso não