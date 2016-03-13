cube <- function(x, n) {
        x^3
}

pow <- function(x = 4, n = 3) {
        x^n
}

f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}

