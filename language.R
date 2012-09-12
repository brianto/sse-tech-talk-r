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
setClass("string.builder",
  representation(
    parts="character"))

setGeneric('add<-', function(self, value) standardGeneric('add<-'))
setReplaceMethod('add', 'string.builder', function(self, value) {
  self@parts <- c(self@parts, value)
  self
})

setGeneric('build', function(self) standardGeneric('build'))
setMethod('build', 'string.builder', function(self) {
  paste(self@parts, collapse=' ')
})

s <- new('string.builder')

add(s) <- 'hey, i just met you'
add(s) <- 'and this is crazy,'
add(s) <- 'but here\'s my number,'
add(s) <- 'so call me maybe?'

build(s)