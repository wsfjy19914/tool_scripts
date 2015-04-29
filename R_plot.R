data <- read.csv("/home/fjy/Documents/NewsList_Reuters_co_jp.csv", header = T);
data$retweets <- c(1:length(data$date));
plot(data$date, data$retweets, main="Cumulative retweet number", xlab="Time", ylab="number", type="l")
every2minutes <- aggregate(data$num, list(groups <- cut(data$date, breaks = "2 mins")), FUN = sum)
plot(every2minutes, type="l")