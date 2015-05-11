library(ggplot2)
library(xts)

data <- read.csv("/home/fjy/Documents/twitter_2011/csv/NewsList_nhk_news_5.csv", header = T);
data$retweets <- c(1:length(data$date));
data$date <- as.POSIXlt(data$date);

qplot(data$date,data$retweets, main="Cumulative times of retweet", xlab="Time", ylab="Cumulative times of retweets", geom=c("line", "point"),);
data$num <- rep(1, length(data$date));

RawDataSeries <- xts(rep(1, length(data$date)), order.by = data$date);

timeSeries1 <- seq(data$date[1], tail(data$date, 1), by = 1);
BlankTimeSeries <- xts((rep(0, length(timeSeries1))), order.by = timeSeries1);

tmp <- tail(data$date, 1) - data$date[1];

MergedTimeSeries <- merge(RawDataSeries, BlankTimeSeries);

every1minutes <- period.apply(MergedTimeSeries, endpoints(MergedTimeSeries, "minutes", 30), sum, na.rm = TRUE);
retweet <- data.frame(date=index(every1minutes), num=every1minutes[,1]);
retweet$num[1] <- retweet$num[1] - 1;
retweet$date <- as.numeric(retweet$date - retweet$date[1]) / 3600 + 0.5;
breaks <- seq(0,13,0.5);
qplot(date, num, data=retweet, geom=c("line", "point"), xlab="Time after release",ylim=c(0,30), ylab="Times of retweets in 30 minutes",main="News A") +
  scale_x_continuous(breaks=breaks,labels=paste(breaks,"h")) +
  geom_vline(xintercept=c(0,retweet$date[18]), linetype="dotted", color="red") +
  geom_point(aes(retweet$date[19],0),color="red", size=3) +
  theme(text=element_text(size=15));

--------------------------------------------------------------------------------------------

data <- read.csv("/home/fjy/Documents/twitter_2011/csv/NewsList_nhk_news_6.csv", header = T);
data$retweets <- c(1:length(data$date));
data$date <- as.POSIXlt(data$date);

qplot(data$date,data$retweets, main="Cumulative times of retweet", xlab="Time", ylab="Cumulative times of retweets", geom=c("line", "point"))
data$num <- rep(1, length(data$date));

RawDataSeries <- xts(rep(1, length(data$date)), order.by = data$date)

timeSeries <- seq(data$date[1], data$date[1] + tmp, by = 1)
BlankTimeSeries <- xts((rep(0, length(timeSeries))), order.by = timeSeries)

MergedTimeSeries <- merge(RawDataSeries, BlankTimeSeries);

every1minutes <- period.apply(MergedTimeSeries, endpoints(MergedTimeSeries, "minutes", 30), sum, na.rm = TRUE);
retweet <- data.frame(date=index(every1minutes), num=every1minutes[,1]);
retweet$num[1] <- retweet$num[1] - 1;
retweet$date <- as.numeric(retweet$date - retweet$date[1]) / 3600 + 0.5;
breaks <- seq(0,13,0.5);
qplot(date, num, data=retweet, geom=c("line", "point"), xlab="Time after release",xlim=c(0,13.0),ylim=c(0,5), ylab="Times of retweets in 30 minutes",main="News B") +
 scale_x_continuous(breaks=breaks,labels=paste(breaks,"h")) +
 geom_vline(xintercept=c(0), linetype="dotted", color="red") +
 theme(text=element_text(size=15));

-----------------------------------------------------------------------------------------
  
data <- read.csv("/home/fjy/Documents/twitter_2011/csv/NewsList_nhk_news_2.csv", header = T);
data$retweets <- c(1:length(data$date));
data$date <- as.POSIXlt(data$date);

qplot(data$date,data$retweets, main="Cumulative times of retweet", xlab="Time", ylab="Cumulative times of retweets", geom=c("line", "point"))
data$num <- rep(1, length(data$date));

RawDataSeries <- xts(rep(1, length(data$date)), order.by = data$date)

timeSeries <- seq(data$date[1], data$date[1] + tmp, by = 1)
BlankTimeSeries <- xts((rep(0, length(timeSeries))), order.by = timeSeries)

tmp <- tail(data$date, 1) - data$date[1]  

MergedTimeSeries <- merge(RawDataSeries, BlankTimeSeries);

every1minutes <- period.apply(MergedTimeSeries, endpoints(MergedTimeSeries, "minutes", 30), sum, na.rm = TRUE);
retweet <- data.frame(date=index(every1minutes), num=every1minutes[,1]);
retweet$num[1] <- retweet$num[1] - 1;
retweet$date <- as.numeric(retweet$date - retweet$date[1]) / 3600 + 0.5;
breaks <- seq(0,13,0.5);
qplot(date, num, data=retweet, geom=c("line", "point"), xlab="Time after release",xlim=c(0,13.0),ylim=c(0,100), ylab="Times of retweets in 30 minutes",main="News C") +
  scale_x_continuous(breaks=breaks,labels=paste(breaks,"h")) +
  geom_vline(xintercept=c(0,retweet$date[7]), linetype="dotted", color="red") +
  geom_point(aes(retweet$date[8],0),color="red", size=3) +
  theme(text=element_text(size=15));

-----------------------------------------------------------------------------------------
every5minutes <- aggregate(data$num, list(cut(data$date, breaks = "5 mins")), FUN = sum);
qplot(x=Group.1, y=x,data=every5minutes, geom="bar", xlab="Time", ylab="Times of retweets",main="Times of retweet in every 5 minutes") + theme(axis.text.x=element_text(angle=45))

