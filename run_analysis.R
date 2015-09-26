## GETTING AND CLEANING DATA: COURSE PROJECT

## NOTE: This file reads a set of data found in a directory named "UCI HAR Dataset"
##
##       The code does the following:
##
##         * Reads in all the relevant datasets.
##         * Combines the separate datasets into a single dataset.
##         * Converts coded variables into their human-readable form.
##         * Renames the variables into more descriptive variables.
##         * Creates a subset of just the "mean()" and "std()" variables.
##             * This subset will be in your workspace named "mean_std_all"
##         * Aggregates the measurement columns in the "mean_std_all"
##           data according to the subject and the activity and writes
##           the aggregated data to a file in your working directory
##           named "gacd_tidy.txt".

library(readr)
library(dplyr)
library(data.table)
library(magrittr)

## Read in the activity labels and the features
## Activity labels (second column) will be used to match activity numbers
##   (first columns). Add names in with `setnames`. Needed for merging.
## Features will be used for the column names
activities <- setnames(fread("UCI HAR Dataset/activity_labels.txt"), 
                       c("activityNum", "activity"))
features   <- fread("UCI HAR Dataset/features.txt")

## Read in the "subject" data. These are single columns.
## Add the column name in with `setnames`.
testSubj   <- setnames(fread("UCI HAR Dataset/test/subject_test.txt"), "subject")
trainSubj  <- setnames(fread("UCI HAR Dataset/train/subject_train.txt"), "subject")

## Read in the "activity" data. These are single columns.
## Add the column name in with `setnames`.
testAct    <- setnames(fread("UCI HAR Dataset/test/y_test.txt"), "activityNum")
trainAct   <- setnames(fread("UCI HAR Dataset/train/y_train.txt"), "activityNum")

## Read in the measurement data. Each set has 561 variables, which matches the
##   number of rows in the features data.table.
## Add the column names in with `setnames`.
testData   <- setnames(fread("UCI HAR Dataset/test/X_test.txt"), features[[2]])
trainData  <- setnames(fread("UCI HAR Dataset/train/X_train.txt"), features[[2]])

## Combine the pieces into a single dataset.
## `rbind` to stack the test data and the train data.
allData <- rbind(cbind(testSubj, testAct, testData),    ## cbind the test data
                 cbind(trainSubj, trainAct, trainData)) ## cbind the train data

## Make a tidy dataset of just the columns we are interested in (which are:
##   the "subject", "activityNum", and the "mean()" and "std()" columns).

mean_std_all <- allData %>%
  ## Get the subjec, activityNum, mean(), and std() columns
  select(subject, activityNum, matches("mean\\(\\)|std\\(\\)")) %>%
  ## Replace the numeric values for activities with the human readable form
  mutate(activityNum = factor(activityNum, activities$activityNum, 
                              activities$activity)) %>%
  ## Rename the activityNum column to activity
  rename(activity = activityNum)

## Make nicer names

names(mean_std_all) <- gsub("\\(\\)-", "_", names(mean_std_all)) %>%
  gsub("\\(\\)", "", .) %>%              ## ^^ & here >>> remove brackets 
  gsub("-", "_", .) %>%                  ## >>> readability  
  gsub("^f", "freq_", .) %>%             ## f        = frequency
  gsub("^t", "time_", .) %>%             ## t        = time
  gsub("Acc", "Accelerometer_", .) %>%   ## Acc      = Accelerometer
  gsub("Gyro", "Gyroscope_", .) %>%      ## Gyro     = Gyroscope
  gsub("Mag", "Magnitude_", .) %>%       ## Mag      = Magnitude
  gsub("BodyBody", "Body", .) %>%        ## BodyBody = ? mistake in typing? :-)
  gsub("Body", "Body_", .) %>%           ## >>> readability
  gsub("Gravity", "Gravity_", .) %>%     ## >>> readability
  gsub("__", "_", .)                     ## >>> readability

## Dataset for step 5: "From the data set in step 4, creates a second, 
##   independent tidy data set with the average of each variable for each 
##   activity and each subject.

mean_std_all %>%
  group_by(subject, activity) %>%                        ## Grouping variables
  summarise_each(funs(mean)) %>%                         ## Aggregation function
  write.table(file = "gacd_tidy.txt", row.names = FALSE) ## Writing the output
