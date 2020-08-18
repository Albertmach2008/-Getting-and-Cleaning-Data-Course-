file<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI HAR Dataset.zip"))
{
  download.file(file,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

data <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
data <- as.character(data[,2])

train <- read.table('./UCI HAR Dataset/train/X_train.txt')
train.act <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train.sub <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

join <-  data.frame(train.sub, train.act, train)
names(join) <- c(c('subject', 'activity'),data)

test <- read.table('./UCI HAR Dataset/test/X_test.txt')
test.act <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test.sub <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

test.a <-  data.frame(test.sub, test.act, test)
names(test.a) <- c(c('subject', 'activity'), data)

data_a <- rbind(join, test.a)
meanstd <- grep('mean|std', data)
data_x <- data.all[,c(1,2,meanstd + 2)]

act.a <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
act.a <- as.character(act.a[,2])
act.b <- act.a[data_x$activity]

name <- names(data_x)
name <- gsub("[(][)]", "", name)
name <- gsub("^t", "TimeDomain_", name)
name <- gsub("^f", "FrequencyDomain_", name)
name <- gsub("Acc", "Accelerometer", name)
name <- gsub("Gyro", "Gyroscope", name)
name <- gsub("Mag", "Magnitude", name)
name <- gsub("-mean-", "_Mean_", name)
name <- gsub("-std-", "_StandardDeviation_", name)
name <- gsub("-", "_", name)
names(data_x) <- name

data.tidy <- aggregate(data_x[,3:81], by = list(activity = data_x$activity, subject = data_x$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
