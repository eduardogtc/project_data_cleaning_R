suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(dplyr))

## Create a sub folder (IF NOT EXISTS) to store the data
sub_dir <- "project_data"
output_dir <- file.path(getwd(), sub_dir)

if (!dir.exists(output_dir)){
    dir.create(output_dir)
}

## Download and unzip the zip file
zip_file <- file.path( output_dir, "raw_data.zip")
url_target <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url_target, zip_file)
unzip(zipfile=zip_file, exdir = output_dir)


## Read data
data_path <- file.path( output_dir, "UCI HAR Dataset")

dt_train_subject <- fread(file.path( data_path, "train", "subject_train.txt"))
dt_train_x <- fread(file.path( data_path, "train", "X_train.txt"))
dt_train_y <- fread(file.path( data_path, "train", "y_train.txt"))

dt_test_subject <- fread(file.path( data_path, "test", "subject_test.txt"))
dt_test_x <- fread(file.path( data_path, "test", "X_test.txt"))
dt_test_y <- fread(file.path( data_path, "test", "y_test.txt"))

dt_features <- fread(file.path(data_path, "features.txt"))

dt_activities <- fread(file.path(data_path, "activity_labels.txt"))

#------------------------------------------------------------------------------------------------------------------#
# TASK 1 - Merges the training and the test sets to create one data set.
#------------------------------------------------------------------------------------------------------------------#

# Combine the columns
dt_train <- cbind(dt_train_subject, dt_train_x, dt_train_y )
dt_test <- cbind(dt_test_subject, dt_test_x, dt_test_y )

# Combine the rows
dt_work_data <- rbind( dt_train, dt_test)

# change the column names
names(dt_work_data) <- c("subject", dt_features[[2]], "activity")

# Clean the working objects
rm( dt_train_subject,
    dt_train_x,
    dt_train_y,
    dt_train,
    dt_test_subject,
    dt_test_x,
    dt_test_y,
    dt_test,
    dt_features)

#------------------------------------------------------------------------------------------------------------------#
# TASK 2 - Extracts only the measurements on the mean and standard deviation for each measurement
#------------------------------------------------------------------------------------------------------------------#
dt_work_data <- dt_work_data[ , .SD, .SDcols = patterns('subject|activity|mean|std')]

#------------------------------------------------------------------------------------------------------------------#
# TASK 3 - Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------------------------------------------#
dt_work_data[,activity:=  mapvalues( activity, unlist(dt_activities[,1]), unlist(dt_activities[,2]))]


#------------------------------------------------------------------------------------------------------------------#
# TASK 4 - Appropriately labels the data set with descriptive variable names.
#------------------------------------------------------------------------------------------------------------------#
names_data <- names(dt_work_data)

# Remove "(" , ")" and "-"
names_data <- gsub("[\\(\\)-]", "", names_data)

names_data<- gsub("BodyBody", "Body", names_data)
names_data<- gsub("Body", "Body-", names_data)
names_data<- gsub("Gravity", "Gravity-", names_data)

names_data<- gsub("Acc", "Accelerometer-", names_data)
names_data<- gsub("Gyro", "Gyroscope-", names_data)
names_data<- gsub("Mag", "Magnitude-", names_data)
names_data<- gsub("Freq", "Frequency-", names_data)
names_data<- gsub("mean", "Mean-", names_data)
names_data<- gsub("std", "Standard-Deviation-", names_data)
names_data<- gsub("Jerk", "Jerk-", names_data)
names_data<- gsub("^f", "Frequency-", names_data)
names_data<- gsub("^t", "Time-", names_data)
names_data<- gsub("-$", "", names_data)
names_data<- gsub("activity", "Activity", names_data)
names_data<- gsub("subject", "Subject", names_data)

names(dt_work_data) <- names_data

#------------------------------------------------------------------------------------------------------------------#
# TASK 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each 
#          variable for each activity and each subject.
#------------------------------------------------------------------------------------------------------------------#

# Group by subject and activity and then calculate the average
dt_tidy_data <- dt_work_data %>% 
                group_by(Subject, Activity) %>%
                summarise_all(funs(mean))

fwrite(dt_tidy_data, "Tidy-Data.csv")
