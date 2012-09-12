# R-rated playing

# Functions and higher order operations
fibonacci <- function(index) {
  if (index %in% 0:1) {
    return(1)
  }
  
  fibonacci(index - 1) + fibonacci(index - 2)
}

values <- sapply(1:10, fibonacci)

values <- sapply(values, function(e) {
  e + rpois(1, lambda=2) - 1
})

Filter(function(e) {
  e %% 2 == 0
}, values)

Reduce(`+`, values, 0)

# S3 Object Model
hook <- function(obj) UseMethod("hook")

hook.character <- function(obj) {
  sprintf("My, what an interesting message: %s", obj)
}

hook.list <- function(obj) {
  obj.message <- paste(names(obj), obj, sep=" = ", collapse=", ")
  
  sprintf("Organized, aren't we: [%s]", obj.message)
}

hook("I love lucy!")

hook(list(
  carrots=2,
  bacon=5,
  cheese=1))

# S4 Object Model
setClass("person",

  representation(
    name="character",
    age="numeric"),

  prototype(
    name="john doe",
    age=-1))

# OMG OMG HOW WORK?
age <- function(self) self
setReplaceMethod("age", "person", function(self) {
  self@age <- self@age + 1
  
  self
})

new("person")
new("person", name="Brian To", age=20)

p <- new("person")
p@name