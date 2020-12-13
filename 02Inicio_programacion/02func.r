rm(list = ls())
# install.packages("here")

# creacion de vectores 

c1 <- c(12, 12, 3, 8, 20)

c1[5]

c2 <- c("letras", "none", "todo")

c2[3]

print("Hola mundo")

paste("hola mundo", 12)

nombre <- "Jhon"

paste("Hola mundo", "soy John")

paste("Hola mundo, soy", nombre)

# crear una funcion

mi_paste_mundo <- function(x){
  paste("Hola mundo", x)
}

mi_paste_mundo("Jhon")

mi_suma <- function(x, y){
  x + y
}

mi_suma(12, 12)

# 4 + 3 + 2 + 1 

sum_recursiva <- function(n){
  (n)*(n+1)/2
}
sum_recursiva(10)

variables <- function(n){
  multi <- n*(n+1)
  division <- 2
  resultado <- multi / division
  paste(multi, division, resultado)
}

var1 <- function(x, y, z = 1){
  a <- x + y
  b <- x * y 
  c <- a * z
  paste(a, b, c)
}

var1(y = 5, x = 4, z = 12)

var1(z = 4, x = 7, y = 2)
