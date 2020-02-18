## set your own working directory
# setwd(dir='/Users/...')

## Download the dataset and unzip it
library(data.table)
fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileUrl,destfile = './UCI HAR Dataset.zip')
        unzip("UCI HAR Dataset.zip")
}

## Read datasets
features <- read.delim2('./UCI HAR Dataset/features.txt', 
                        header = FALSE, 
                        sep = ' ', 
                        stringsAsFactors = FALSE)
features[,2] <- make.unique(features[,2]) # mutate the column names as unique
test_data <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_activities <- read.delim2('./UCI HAR Dataset/test/y_test.txt', 
                               header = FALSE, 
                               sep = ' ')
test_subject <- read.delim2('./UCI HAR Dataset/test/subject_test.txt', 
                            header = FALSE, 
                            sep = ' ')
train_data <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_activities <- read.delim2('./UCI HAR Dataset/train/y_train.txt', 
                                   header = FALSE, 
                                   sep = ' ')
train_subject <- read.delim2('./UCI HAR Dataset/train/subject_train.txt',
                             header = FALSE, 
                             sep = ' ')

## task 1. merge the datasets together
library(dplyr)
test_subject <- mutate(test_subject,'groupset'='test')
test_all <- data.frame(test_subject,test_activities,test_data)
names(test_all) <- c(c('subject','groupset','activities'),features[,2])

train_subject <- mutate(train_subject,'groupset'='train')
train_all <- data.frame(train_subject,train_activities,train_data)
names(train_all) <- c(c('subject','groupset','activities'),features[,2])

data_all <- rbind(test_all, train_all)

## task 2. extrats the measurements on the mean and std for each measurement
sub_data1 <- select(data_all, contains('mean'))
sub_data2 <- select(data_all, contains('std'))
sub_data <- data.frame(data_all[,1:3],sub_data1, sub_data2)

## task 3. Uses descriptive activity names to replase the number in the data set
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt',
                               header = FALSE)
sub_data$activities <- factor(sub_data$activities,
                              labels = activity_labels[,2])

## task 4. Appropriately labels the data set with descriptive variable names
names(sub_data) <- gsub('mean','Mean',names(sub_data))
names(sub_data) <- gsub('std','StandatdDeviation',names(sub_data))
names(sub_data) <- gsub('^t','TimeDomain.',names(sub_data))
names(sub_data) <- gsub('^f','FrequencyDomain.',names(sub_data))
names(sub_data) <- gsub('Acc','Acceleration',names(sub_data))
names(sub_data) <- gsub('Gyro','Gryoscope',names(sub_data))
names(sub_data) <- gsub('Mag','Magnitude',names(sub_data))
names(sub_data) <- gsub('Freq','Frequency',names(sub_data))
names(sub_data) <- gsub('..X','X',names(sub_data))
names(sub_data) <- gsub('..Y','Y',names(sub_data))
names(sub_data) <- gsub('..Z','Z',names(sub_data))

## task 5. From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject
len <- length(sub_data[1,])
tidy_data <- aggregate(sub_data[,4:len],
                       by = list(subject = sub_data$subject,activities = sub_data$activities), 
                       FUN = mean)
write.table(x = tidy_data, file = 'tidy_data.txt', row.names = FALSE)
