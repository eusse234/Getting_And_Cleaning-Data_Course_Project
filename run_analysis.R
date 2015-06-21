### GETTING AND CLEANNING DATA COURSE PRJECT###
#=============================================#
# run_analysis.R:
# This script containing the 5 steps described in the course project of the
# Getting and Cleaning Data course.
#----------------------------------------------------------------------#


#STEP 0: "Preliminaries"
#======================#
# Set working directory
setwd("~/Documentos/WD_R/3_Getting_and_Cleanning_Data/Course_Project")

# Load libraries
library("plyr")
#----------------------------------------------------------------------#


#STEP 1: "Merge the training and the test sets to create one data set."
#======================================================================#

# Read the data, activity and subject in the train folder (training set)
# and bind in one data set.
x_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt", col.names=c("activity_id"))
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt", col.names=c("subject_id"))
train_data <- cbind(subject_train, y_train, x_train)

# Read the data, activity and subject in the test folder (test set).
# and bind in one data set.
x_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt", col.names=c("activity_id"))
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt", col.names=c("subject_id"))
test_data <- cbind(subject_test, y_test, x_test)

# Binding the data as an unique data set (test and training mergerd).
total_data <- rbind(train_data, test_data)
#----------------------------------------------------------------------#


#STEP 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
#================================================================================================#

# Read the features file
features <- read.table("UCI_HAR_Dataset/features.txt")

# Filter de features by names containing "mean()" and "std()" strings.
mean_std_features <- features[grepl("mean\\()", features$V2) | grepl("std\\()", features$V2),]

# Subset total_data using selected features 
# (remember that columns 1 and 2 contain the subject and activity id)
tidy_data <- total_data[, c(c(1, 2), mean_std_features$V1 + 2)]
#----------------------------------------------------------------------#


#STEP 3: "Uses descriptive activity names to name the activities in the data set"
#===============================================================================#

# Read the activity_labels file
activity_name <- read.table("UCI_HAR_Dataset/activity_labels.txt")

# Change the id number for activity names in "tidy_data$activity_id" column
tidy_data$activity_id <- activity_name[ match(tidy_data$activity_id, activity_name$V1), 'V2']
#----------------------------------------------------------------------#


# STEP 4: "Appropriately labels the data set with descriptive variable names."
#============================================================================#

# Clean the variable names (removing "()" and "-" characters)
mean_std_features$V2 <- gsub("\\()", "", mean_std_features$V2)
mean_std_features$V2 <- gsub("-", "_", mean_std_features$V2)

# Label the variable names in the tidy_data set
names(tidy_data) <- c("subject", "activity", mean_std_features$V2)
#----------------------------------------------------------------------#


# STEP 5: "From the data set in step 4, creates a second, independent tidy data 
#         set with the average of each variable for each activity and each subject."
#==================================================================================#

# Create a final data set containing the subject, the activity and the average for
# each variable measured.
ultimate_data <- ddply(tidy_data, .(subject, activity), function(x) colMeans(x[, 3:68]))

# Write the ultimate_data in a .txt file
write.table(ultimate_data, "final_tidy_data.txt", row.name=FALSE)
