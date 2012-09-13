library(Rook)
library(rjson)
library(brew)

s <- Rhttpd$new()

template.body <- function(template.name, vars) {
  template.path <- file.path(getwd(), 'templates', template.name)
  
  out <- textConnection(
    object='brew string',
    open='w')
  
  brew(
    file=template.path,
    output=out,
    envir=list2env(vars))
  
  output <- textConnectionValue(out)
  
  close(out)
  
  return(output)
}

s$add(
  name='test',
  app=Builder$new(
    Static$new(
      urls=c('/boxplot.png'),
      root=tempdir()),
    App$new(
      app=function(env) {
        hn.data <- readLines('http://api.ihackernews.com/page')
        hn.data <- fromJSON(hn.data)
        
        hn.data[['helper']] <- Request$new(env)
        
        comments <- sapply(hn.data[['items']], '[[', 'commentCount')
        
        png(filename=file.path(tempdir(), 'boxplot.png'),
            height=240, width=320)
        
        hist(comments)
        
        dev.off()
        
        body <- template.body('index.html', hn.data)
        
        response <- Response$new(
          body=body)
        
        response$finish()
    })))

s$start()
s$browse('test')
# s$stop()