
# Coursera Getting & Cleaning Data, Week 4 
# by Lon Lieberman
# Created on a MAC OS 10.11.16 | RStudio Version 0.99.902
# Submitted August, 14 2016
###############################################################################
getwd()
setwd("Documents/R/Assignments/Data_Cleaning_Coursera/Week 4/")

# Libraries
library(dplyr)
library(stats)


# Sources 
# Create a file called data if one does not exist. point R & download data
# to the data file.
if(!file.exists("./data")){dir.create("./data")}
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,destfile = "./data/dataset",method = "curl", mode = "wb")
 
# Open files
# TRAIN 
trainsubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
traindata <- read.table("data/UCI HAR Dataset/train/X_train.txt")
trainactivity <- read.table("data/UCI HAR Dataset/train/y_train.txt")

# TEST
testsubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
testdata <- read.table("data/UCI HAR Dataset/test/X_test.txt")
testactivity <- read.table("data/UCI HAR Dataset/test/y_test.txt")

# FEATURES
features <- read.table("data/UCI HAR Dataset/features.txt")

# ACTIVITY LABELS
actlabels <- read.table("data/UCI HAR Dataset/activity_labels.txt")

# Part 1  # Merge train & test files, rename & then create a single data set
# Combine test data
testactivity <- full_join(testactivity, actlabels) %>% 
                rename(subject = V1, activity = V2) 
testsubject <- rename(testsubject, subject = V1)
names(testdata) <- features$V2
testdata <- bind_cols(testdata, testsubject) 
testdata1 <- bind_cols(testactivity, testdata)

# Combine train data
trainactivity <- full_join(trainactivity, actlabels) %>% 
        rename(subject = V1, activity = V2) 
trainsubject <- rename(trainsubject, subject = V1)
names(traindata) <- features$V2
traindata <- bind_cols(traindata, trainsubject) 
traindata1 <- bind_cols(trainactivity, traindata)

# Combine merged test & train data into 1 set
allmerged <- bind_rows(testdata1, traindata1)

# Part 2  # Extracts only measurements on mean & std for each measurement.
m <- select(allmerged, contains("mean"))
m1 <- select(allmerged, contains("std"))
m3 <- select(allmerged, contains("subject"))
m4 <- select(allmerged, contains("activity"))
subjectandactivity <- bind_cols(m3, m4)
meanandstd <- bind_cols(m, m1)
newallmerged <- bind_cols(subjectandactivity, meanandstd)

# Part 3  # Use descriptive activity names to name the activities in the data set
relabel <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", 
             "STANDING", "LAYING")
newallmerged$subject <- relabel[newallmerged$subject]

# Part 4  # Appropriately label the data set with descriptive variable names.
names(newallmerged) <- gsub("^t", "time: ", names(newallmerged))
names(newallmerged) <- gsub("^f", "frequency: ", names(newallmerged))
names(newallmerged) <- gsub("Acc", "accelerometer: ", names(newallmerged))
names(newallmerged) <- gsub("BodyBody", "body: ", names(newallmerged))
names(newallmerged) <- gsub("Gyro", "gyroscope: ", names(newallmerged))
names(newallmerged) <- gsub("Mag", "magnitude: ", names(newallmerged))
names(newallmerged) <- gsub("-mean()", "mean", names(newallmerged))
names(newallmerged) <- gsub("-freq()", "freq", names(newallmerged))
names(newallmerged) <- gsub("-std()", "std", names(newallmerged))
names(newallmerged) <- gsub("tBody", "timebody", names(newallmerged))

# names(newallmerged)  # Check to see if names changed

# Part 5
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
tidyfinal <- newallmerged %>% 
                group_by(activity, subject) %>% 
                        summarise_each(funs(mean))
# View(tidyfinal)  # Look over new df to make sure I have what I want

write.table(tidyfinal, file = "Tidy.txt", row.names = FALSE)  # write a tidy set

# housekeeping  # remove all files imported
rm("data/UCI HAR Dataset/test/subject_test.txt")
rm("data/UCI HAR Dataset/test/X_test.txt")
rm("data/UCI HAR Dataset/test/y_test.txt")
rm("data/UCI HAR Dataset/test/Inertial Signals/")
rm("data/UCI HAR Dataset/train/subject_train.txt")
rm("data/UCI HAR Dataset/train/X_train.txt")
rm("data/UCI HAR Dataset/train/y_train.txt")
rm("data/UCI HAR Dataset/activity_labels.txt")
rm("data/UCI HAR Dataset/features_info.txt")
rm("data/UCI HAR Dataset/features.txt")
rm("data/UCI HAR Dataset/README.txt")


















