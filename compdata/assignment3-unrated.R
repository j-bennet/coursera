outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## 1 Plot the 30-day mortality rates for heart attack
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11], main='Heart Attack 30-day Death Rate', xlab='30-day Death Rate')
graphics.off()

## 2 Plot the 30-day mortality rates for heart attack, heart failure,
##  and pneumonia

par(mfrow = c(3, 1))
outcome[, 17] <- as.numeric(outcome[, 17])
outcome[, 23] <- as.numeric(outcome[, 23])

m1 <- mean(outcome[, 11], na.rm = TRUE)
hist(outcome[, 11], main=bquote(paste('Heart Attack (', bar(X), ' = ', .(m1), ')')), xlab='30-day Death Rate', xlim=c(0, 22), prob = TRUE)
abline(v = median(outcome[, 11], na.rm = TRUE), col = 'blue')
lines(density(outcome[, 11], na.rm = TRUE), col = 'red')

m2 <- mean(outcome[, 17], na.rm = TRUE)
hist(outcome[, 17], main=bquote(paste('Heart Failure (', bar(X), ' = ', .(m2), ')')), xlab='30-day Death Rate', xlim=c(0, 22), prob = TRUE)
abline(v = median(outcome[, 17], na.rm = TRUE), col = 'blue')
lines(density(outcome[, 17], na.rm = TRUE), col = 'red')

m3 <- mean(outcome[, 23], na.rm = TRUE)
hist(outcome[, 23], main=bquote(paste('Pneumonia (', bar(X), ' = ', .(m3), ')')), xlab='30-day Death Rate', xlim=c(0, 22), prob = TRUE)
abline(v = median(outcome[, 23], na.rm = TRUE), col = 'blue')
lines(density(outcome[, 23], na.rm = TRUE), col = 'red')

graphics.off()

## 3 Plot 30-day death rates by state
states <- table(outcome$State)
states20 <- subset(states, states >= 20)
states20names <- names(states20)
outcome2 <- subset(outcome, outcome$State %in% states20names)

death <- outcome2[, 11]
state <- outcome2$State
boxplot(death ~ state, ylab='30-day Death Rate', main='Heart Attack 30-day Death Rate by State', las=2)

graphics.off()

## Plot 30-day death rates and numbers of patients

hospital <- read.csv("hospital-data.csv", colClasses = "character")
outcome.hospital <- merge(outcome, hospital, by = "Provider.Number")

death <- as.numeric(outcome.hospital[, 11])
npatient <- as.numeric(outcome.hospital[, 15])
owner <- factor(outcome.hospital$Hospital.Ownership)

library(lattice)
p <- xyplot(death ~ npatient | owner,
            xlab='Number of Patients Seen',
            ylab='30-day Death Rate',
            main='Heart Attack 30-day Death Rate by Ownership',
            layout=c(3, 3),
            panel = function(x, y, ...) {
              panel.xyplot(x, y, ...)
              panel.lmline(x, y, col = 2)
            }
          )
print(p)
