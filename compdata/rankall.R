rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome is valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }
  
  ## For each state, find the hospital of the given rank
  cnum <- NA
  if (outcome == 'heart attack') {
    cnum <- 11
  }
  else if (outcome == 'heart failure') {
    cnum <- 17
  }
  else if (outcome == 'pneumonia') {
    cnum <- 23
  }
  
  # convert value to rank to numeric
  data[, cnum] <- as.numeric(data[, cnum])
  
  # remove NA
  data <- data[!is.na(data[, cnum]), ]
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  data <- data[order(
    data[, 7],             # order by state
    data[, cnum],          # then by outcome
    data[, 2]), ]          # then by hospital name
  
  data <- data.frame(state = data[, 7],
                     hospital = data[, 2],
                     outcome = data[, cnum])
  
  ans <- NA
  if (num == 'best') {
    data$rank <- ave(data$outcome, data$state, FUN = function(x) rank(x, ties.method= "first"))
    ans <- subset(data, data$rank == 1, select = c('state', 'hospital'))
  }
  else if (num == 'worst') {
    data$rank <- ave(data$outcome, data$state, FUN = function(x) rank(-x, ties.method= "first"))
    ans <- subset(data, data$rank == 1, select = c('state', 'hospital'))
  }
  else {
    num <- as.integer(num)
    data$rank <- ave(data$outcome, data$state, FUN = function(x) rank(x, ties.method= "first"))
    ans <- subset(data, data$rank == num, select = c('state', 'hospital'))
    if (length(ans[, 1]) == 0) {
      ans <- NA
    }
  }
  ans
}