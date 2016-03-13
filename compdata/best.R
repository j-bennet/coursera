best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }
  
  if (!state %in% unique(data$State)) {
    stop('invalid state')
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  stateData <- subset(data, data$State == state)
  if (outcome == 'heart attack') {
    stateData[, 11] <- as.numeric(stateData[, 11])
    minv <- min(stateData[, 11], na.rm = TRUE)
    hospital <- na.omit(stateData$Hospital.Name[stateData[, 11] == minv])[1]
    hospital
  }
  else if (outcome == 'heart failure') {
    stateData[, 17] <- as.numeric(stateData[, 17])
    minv <- min(stateData[, 17], na.rm = TRUE)
    hospital <- na.omit(stateData$Hospital.Name[stateData[, 17] == minv])[1]
    hospital
  }
  else if (outcome == 'pneumonia') {
    stateData[, 23] <- as.numeric(stateData[, 23])
    minv <- min(stateData[, 23], na.rm = TRUE)
    hospital <- na.omit(stateData$Hospital.Name[stateData[, 23] == minv])[1]
    hospital
  }
}