getmonitor <- function(id, directory, summarize = FALSE) {
	filename <- sprintf('%s/%03i.csv', directory, as.numeric(id))
	data <- read.csv(filename)        
        
	if (summarize) {
		print(summary(data))
	}
	data
}
