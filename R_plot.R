data <- read.csv("C:/Users/FanJinyang/Dropbox/NewsList_Reuters_co_jp.csv", header = T);
data$retweets <- c(1:length(data$date));
data$date <- as.POSIXlt(data$date);

qplot(data$date,data$retweets, main="Cumulative times of retweet", xlab="Time", ylab="Cumulative times of retweets", geom=c("line", "point"))
data$num <- rep(1, length(data$date));

every1minutes <- aggregate(data$num, list(cut(data$date, breaks = "1 mins")), FUN = sum);
qplot(x=Group.1, y=x,data=every1minutes, geom="bar", stat="identity", xlab="Time", ylab="Times of retweets",main="Times of retweet in every 1 minutes") + theme(axis.text.x=element_text(angle=45))

every2minutes <- aggregate(data$num, list(cut(data$date, breaks = "2 mins")), FUN = sum);
qplot(x=Group.1, y=x,data=every2minutes, geom="bar", stat="identity", xlab="Time", ylab="Times of retweets",main="Times of retweet in every 2 minutes") + theme(axis.text.x=element_text(angle=45))

every3minutes <- aggregate(data$num, list(cut(data$date, breaks = "3 mins")), FUN = sum);
qplot(x=Group.1, y=x,data=every3minutes, geom="bar", stat="identity", xlab="Time", ylab="Times of retweets",main="Times of retweet in every 3 minutes") + theme(axis.text.x=element_text(angle=45))


every5minutes <- aggregate(data$num, list(cut(data$date, breaks = "5 mins")), FUN = sum);
qplot(x=Group.1, y=x,data=every5minutes, geom="bar", stat="identity", xlab="Time", ylab="Times of retweets",main="Times of retweet in every 5 minutes") + theme(axis.text.x=element_text(angle=45))

