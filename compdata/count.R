count <- function(cause = NULL) {
  ## Check that "cause" is non-NULL; else throw error
  if (is.null(cause)) {
    stop("no cause specified")
  }
  
  ## Check that specific "cause" is allowed; else throw error
  if (!cause %in% c('asphyxiation', 'blunt force', 'other', 'shooting', 'stabbing', 'unknown')) {
    stop('incorrect cause')
  }
  
  ## Read "homicides.txt" data file
  homicides <- readLines("homicides.txt")
  
  ## Extract causes of death
  pat <- paste('<dd>cause: +', cause, '</dd>', sep = '')
  filtered <- grep(pat, homicides, ignore.case = TRUE)
  
  ## Return integer containing count of homicides for that cause
  length(filtered)
}