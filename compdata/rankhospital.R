rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }
  
  if (!state %in% unique(data$State)) {
    stop('invalid state')
  }
  
  stateData <- subset(data, data$State == state)
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
  stateData[, cnum] <- as.numeric(stateData[, cnum])
  stateData <- stateData[!is.na(stateData[, cnum]), ]
  orderedData <- stateData[order(stateData[, cnum], stateData[, 2]), ]
  
  ans <- NA
  len <- length(orderedData[, cnum])
  if (num == 'best') {
    ans <- orderedData$Hospital.Name[1]
  }
  else if (num == 'worst') {
    ans <- orderedData$Hospital.Name[len]
  }
  else {
    num <- as.integer(num)
    if (num <= len) {
      ans <- orderedData$Hospital.Name[num]
    }
  }
  ans
}