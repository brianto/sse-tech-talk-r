# Exploratory Data Analysis
#
# Author: Brian To

# Load Spring framework class name data into variable "spring"
spring <- read.csv('spring-data.csv')

# Examine class name lengths
spring$name.length

# Get summary statistics for class name lengths
summary(spring$name.length)

# Plot a histogram
hist(spring$name.length)

# Plot a boxplot
boxplot(spring$name.length)

# Plot a boxplot horizontally
boxplot(spring$name.length, horizontal=TRUE)

# Separate classes with methods from classes without methods into a dictionary.
# Retain only the name lengths.
length.by.methods <- list(
  without=subset(spring, methods == 0)$name.length,
  with=subset(spring, methods > 0)$name.length
)

# Summarize lengths for the two groups
lapply(length.by.methods, summary)

# Plot boxplots of the two groups side-by-side
boxplot(length.by.methods, horizontal=TRUE)

# 2-Sample t Test to compare samples (ignore normality)
with(length.by.methods, t.test(with, without))

# Plot SLOC against name length
with(spring, plot(name.length, lines))

# Correlate SLOC with name length
with(spring, cor(name.length, lines))