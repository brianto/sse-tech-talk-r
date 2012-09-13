dyn.load('native.so')

fibonacci <- function(index) {
  call <- .C('fibonacci',
    index=as.integer(index),
    result=as.integer(0))
  
  return(call$result)
}

fibonacci(0)