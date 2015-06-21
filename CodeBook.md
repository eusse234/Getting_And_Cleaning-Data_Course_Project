\name{Schneiedr Eusse}
\alias{Eusse234}

\title{CodeBook for Getting and Cleaning Data Project}

Description
===========

This file contain all the necessary information for about the data, variables and its trasformation used during the course project of the Johns Hopkins Getting and Cleaning Data course.

Data Source
===========
The data used for this is contained in the `r UCI_HAR_Dataset` folder in this repo, and was obteined from:

- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at: 

- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Variables
=========

The data consist in 561 variables measured from a Samsung Galaxy SII for 30 volunteers that performing six different activities. For each record was provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Note: the group was divided into two sets,  70% of the volunteers was selected for generating the training data and 30% the test data.


The most important variables used in `r run_analysis.R` file are:

- `r total_data`: variable for the dataset used for merge (train and test):
- `r ultimate_data`: variable used for the final dataset, containing the averages of each variable measured on the mean and standard deviation for each subject in each activity.

Transformation of variables
===========================

The `r run_analysis.R` file containg the transformation of the raw data into a tidy data that merge both data sets provided (train and test set) and identify appropiately the variables and activities carried out for the volunteers (laying, sitting, standing, walking, walking downstairs, walking upstairs). The variables selected were those measurements on the mean and standard deviation.

The procedure was the next:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
