complete <- function(directory, id = 1:332) {
	completefor <- function(x) {
		sum(complete.cases(getmonitor(x, directory)))
	}
	data.frame(id = id, nobs = sapply(id, completefor))	
}
