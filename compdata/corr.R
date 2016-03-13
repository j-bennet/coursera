corr <- function(directory, threshold = 0) {
	result <- rep(as.numeric(NA), 332)
	is_threshold <- function(data){
		sum(complete.cases(data)) > threshold
	}
	corrfor <- function(data) {
		cor(x = data$sulfate, y = data$nitrate, use = 'complete.obs')
	}

	for (id in 1:332) {
		x <- getmonitor(id, directory)
		if (is_threshold(x)) {
			result[id] <- corrfor(x)
		}
	}
	result[!is.na(result)]
}