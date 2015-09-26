---
title: "CodeBook"
author: "Ananda Mahto"
date: "26 September 2015"
output: html_document
---

# Overview

This script processes the ["Human Recognition Using Smartphones"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset.

The raw dataset comprises several text files. For the purspose of this activitiy, the following files were used during the data processing phase:

Directory | File | Description
-----------|--------|---------
Root|`activity_labels.txt`|Codebook to convert the numeric activity values to human-readable labels.
Root|`features.txt`|A list of all the variables in the dataset.
`./test`|`subject_test.txt`|A single-column list of the subjects.
`./test`|`X_test.txt`|The main data for the "test" group.
`./test`|`y_test.txt`|A single-column list of the activities.
`./train`|`subject_train.txt`|A single-column list of the subjects.
`./train`|`X_train.txt`|The main data for the "train" group.
`./train`|`y_train.txt`|A single-column list of the activities.

The script uses the following packages:

* data.table: Particularly for `fread`.
* dplyr: For convenience of chaining commands and aggregation.
* magrittr: For chaining the nested `gsub` commands used to convert the column names to a more readable format.

The script ends with three outputs:

Output | Location | Description
-----|----------|----------
`allData`|Current R workspace|The fully combined dataset. 10299 observations of 563 variables.
`allData`|Current R workspace|The subsetted dataset. 10299 observations of 68 variables.
`gacd_tidy.txt`|Current R working directory|The aggregated values of the subsetted variables. 180 observations of 68 variables.

# Processing steps

These were the steps involved in processing the data:

1. `fread` was used to read all the relevant datasets into R. This created 6 objects that needed to be merged into 1.
2. Since the number of observations by group (test, train) were uniform, the "merging" was done using `cbind` for each group of data, and `rbind` to make the master dataset. This was stored in the workspace as `allData`.
3. "dplyr" was used to subset the relevant columns for this assignment. The final dataset was named `mean_std_all` and is found in the R workspace.
4. `grep` was used to make the column names more human-readable. The "magrittr" package was used to chain the nested `grep` commands in a more convenient manner.
5. All intermediate objects created in step 1 were removed from the workspace.
6. The `mean` function was used inside a "dplyr" expression to aggregate all measured variables grouped by "subject" and "activity". The output of this aggregation was sent directly to a file named `gacd_tidy.txt` in the current working directory.

# Codebook

The final dataset contains the following 68 variables:

* `subject`
* `activity`
* `time_Body_Accelerometer_mean_X`
* `time_Body_Accelerometer_mean_Y`
* `time_Body_Accelerometer_mean_Z`
* `time_Body_Accelerometer_std_X`
* `time_Body_Accelerometer_std_Y`
* `time_Body_Accelerometer_std_Z`
* `time_Gravity_Accelerometer_mean_X`
* `time_Gravity_Accelerometer_mean_Y`
* `time_Gravity_Accelerometer_mean_Z`
* `time_Gravity_Accelerometer_std_X`
* `time_Gravity_Accelerometer_std_Y`
* `time_Gravity_Accelerometer_std_Z`
* `time_Body_Accelerometer_Jerk_mean_X`
* `time_Body_Accelerometer_Jerk_mean_Y`
* `time_Body_Accelerometer_Jerk_mean_Z`
* `time_Body_Accelerometer_Jerk_std_X`
* `time_Body_Accelerometer_Jerk_std_Y`
* `time_Body_Accelerometer_Jerk_std_Z`
* `time_Body_Gyroscope_mean_X`
* `time_Body_Gyroscope_mean_Y`
* `time_Body_Gyroscope_mean_Z`
* `time_Body_Gyroscope_std_X`
* `time_Body_Gyroscope_std_Y`
* `time_Body_Gyroscope_std_Z`
* `time_Body_Gyroscope_Jerk_mean_X`
* `time_Body_Gyroscope_Jerk_mean_Y`
* `time_Body_Gyroscope_Jerk_mean_Z`
* `time_Body_Gyroscope_Jerk_std_X`
* `time_Body_Gyroscope_Jerk_std_Y`
* `time_Body_Gyroscope_Jerk_std_Z`
* `time_Body_Accelerometer_Magnitude_mean`
* `time_Body_Accelerometer_Magnitude_std`
* `time_Gravity_Accelerometer_Magnitude_mean`
* `time_Gravity_Accelerometer_Magnitude_std`
* `time_Body_Accelerometer_JerkMagnitude_mean`
* `time_Body_Accelerometer_JerkMagnitude_std`
* `time_Body_Gyroscope_Magnitude_mean`
* `time_Body_Gyroscope_Magnitude_std`
* `time_Body_Gyroscope_JerkMagnitude_mean`
* `time_Body_Gyroscope_JerkMagnitude_std`
* `freq_Body_Accelerometer_mean_X`
* `freq_Body_Accelerometer_mean_Y`
* `freq_Body_Accelerometer_mean_Z`
* `freq_Body_Accelerometer_std_X`
* `freq_Body_Accelerometer_std_Y`
* `freq_Body_Accelerometer_std_Z`
* `freq_Body_Accelerometer_Jerk_mean_X`
* `freq_Body_Accelerometer_Jerk_mean_Y`
* `freq_Body_Accelerometer_Jerk_mean_Z`
* `freq_Body_Accelerometer_Jerk_std_X`
* `freq_Body_Accelerometer_Jerk_std_Y`
* `freq_Body_Accelerometer_Jerk_std_Z`
* `freq_Body_Gyroscope_mean_X`
* `freq_Body_Gyroscope_mean_Y`
* `freq_Body_Gyroscope_mean_Z`
* `freq_Body_Gyroscope_std_X`
* `freq_Body_Gyroscope_std_Y`
* `freq_Body_Gyroscope_std_Z`
* `freq_Body_Accelerometer_Magnitude_mean`
* `freq_Body_Accelerometer_Magnitude_std`
* `freq_Body_Accelerometer_JerkMagnitude_mean`
* `freq_Body_Accelerometer_JerkMagnitude_std`
* `freq_Body_Gyroscope_Magnitude_mean`
* `freq_Body_Gyroscope_Magnitude_std`
* `freq_Body_Gyroscope_JerkMagnitude_mean`
* `freq_Body_Gyroscope_JerkMagnitude_std`

## Description of measurements

Partial Variable Name | Description
----------|---------
`freq` or `time`|Based on time or frequency measurements.
`Body`|Related to body movement.
`Gravity`|Acceleration of gravity.
`Accelerometer`|Accelerometer measurement.
`Gyroscope`|Gyroscopic measurements.
`Jerk`|Sudden movement acceleration.
`Magnitude`|Magnitude of movement.
`mean` and `std`|Calculations for each subject for each activity for each mean and SD measurements.

The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.
