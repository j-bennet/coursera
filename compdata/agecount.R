agecount <- function(age = NULL) {
  ## Check that "age" is non-NULL; else throw error
  if (is.null(age)) {
    stop("no age specified")
  }
  
  ## Read "homicides.txt" data file
  homicides <- readLines("homicides.txt")
  
  ## Extract ages of victims; ignore records where no age is
  ## given
  pat <- paste(age, ' *year', sep = '')
  filtered <- grep(pat, homicides, ignore.case = TRUE)
  
  ## Return integer containing count of homicides for that age
  length(filtered)
}
