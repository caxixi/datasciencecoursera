#this file: 1. download and unzip the relevant files from the internet
# 2. merges test and train data
#3. transform activities codes to activities names
#4. extract only mean and standtad deviation of each measure
#5. create an additional tidy data set with the average of each variable for each 
#activity and each subject.

# R packages that are used above the basic in this script are called:  

library(data.table)
library (dplyr) # use splyr package

#1.a download and unzip files:
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url, "y_test.txt")
unzip("y_test.txt")
download.file(url, "y_train.txt")
unzip("y_train.txt")
download.file(url, "subject_test.txt")
unzip("subject_test.txt")
download.file(url, "activity_labels.txt")
unzip("activity_labels.txt")
download.file(url, "x_test.txt")
unzip("x_test.txt")
download.file(url, "x_train.txt")
unzip("x_train.txt")
download.file(url, "features.txt")
unzip("features.txt")

#1.b read the files:
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
activity_labels<- read.table("UCI HAR Dataset/activity_labels.txt")
x_test<-read.table("UCI HAR Dataset/test/x_test.txt")
x_train<-read.table("UCI HAR Dataset/train/x_train.txt")
features<-read.table("UCI HAR Dataset/features.txt")

# 2.a merge the subjects and the activities data with the result data, so that each
#line contains the individual volunteer and the activity that resulted the data.

train<-cbind(subject_train, y_train)# merging the subject and the activity train files
train<-cbind(train, x_train)# merging subjects and activity with the train data
test<-cbind(subject_test, y_test)# merging the subject and the activity test files
test<-cbind(test, x_test)# merging subjects and activity with the test data

all_data<-rbind(test, train)#combine the test and the train data

#2.b adding the column names:

metrics <- as.vector(features$V2) # creating a vector of activities columns names 
col_name<-c("subject", "activity", metrics) # adding the subject and activity lables
colnames(all_data)<-col_name

#3.replace activity codes with activity name:

all_data$activity[which(all_data$activity=="1")]<-"walking"
all_data$activity[which(all_data$activity=="2")]<-"walking upstairs"
all_data$activity[which(all_data$activity=="3")]<-"walking downstairs"
all_data$activity[which(all_data$activity=="4")]<-"sitting"
all_data$activity[which(all_data$activity=="5")]<-"standing"
all_data$activity[which(all_data$activity=="6")]<-"laying"

#4. extract only mean and standtad deviation of each measure


all_data_dt <- tbl_dt(all_data) #coerce all data to data frame tbl

subj_act<-select(all_data_dt, subject, activity) # only the subject and activity data 
mean_std<-select(all_data_dt, contains("std"), contains ("mean")) #only the mean and 
#std columns
select_data<-cbind(subj_act,mean_std) # merging subjects, activities, and requested 
#columns.

#5. creating the additional tidy data set:

final_tidy<- select_data[, lapply(.SD, mean), by = c("subject","activity")]
                  
      
      


