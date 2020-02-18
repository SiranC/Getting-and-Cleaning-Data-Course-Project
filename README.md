# Getting and Cleaning Data Course Project: Tidy Data Preparation
As a course project for data science certificate, the goal of this project is to prepare a tidy data that can be used for later analysis.

CodeBook-tidy data: describe the variables processed and exported by the run_analysis.R code, and explain the transformations I performed to clean up the data.

run_analysis.R: the R code clean the data.

tidy_data.txt: the final exported data in your local folder cleaned and created by the code.

## The Main Procedures of the code
1.Download the accelerometers’ data collected from the Samsung Galaxy S smartphone and unzip it. The data location is follows:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2.Read the interesting data sets. features.txt and activity_labels.txt from UCI HAR Dataset folder, the X_text.txt, y_text.txt, and subject_text.txt from text folder inside the UCI HAR Dataset folder, and the X_train.txt, y_train.txt, and subject_train.txt from train folder inside the UCI HAR Dataset folder. 

3.Merge the test and train groupset data together.

4.Extract only the measurements on the mean and standard deviation for each measurement.

5.Use descriptive activity names to replace the representative number showed in the CodeBook in the data set.

6.Appropriately labels the data set with descriptive variable names in the CodeBook.

7.Create a second, independent tidy data set with the average of each variable for each activity and each subject.
