*Data source

The source data came from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
It´s about dates of Samsung smartphone

*Libraries used

library("read.table")
Create a directory using before the link
Extract the .zip archive 
Reading the .txt files
Reading the .csv files

Here are some examples:

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.act <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = " ")
train.sub <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = " ")

1-Merges the training and the test sets to create one data set.
I used the function rbind

data_a <- rbind(join, test.a)

2-Extracts only the measurements on the mean and standard deviation for each measurement.

meanstd <- grep('mean|std', data)

3-Uses descriptive activity names to name the activities in the data set
I named the variable like act.b 

act.a <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
act.a <- as.character(act.a[,2])
act.b <- act.a[data_x$activity]

4-Appropriately labels the data set with descriptive variable names.

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

5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data final with the subject´means

data.tidy <- aggregate(data_x[,3:81], by = list(activity = data_x$activity, subject = data_x$subject),FUN = mean)

*Save the data in .txt
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)

