# Objective
The final objective of the script run_analysis.R is to tidy the data. In order to do that, the script will execute 5 tasks.

## Source Data
All the data used in the program comes from the zip file [Project Source Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Output
The program will generate a csv file named Tidy-Data.csv. It will contain the result of the last task.

## Script 
### Preparation
1. Create the working directory
1. Donwload the zip file
1. Unzip the file
1. Create data tables for all the files:
   1. dt_train_subject 
      * Source: \train\subject_train.txt"
      * Description: Recorded train data of subjects being observed
      * Rows: 7352
      * Columns:1
   1. dt_train_x 
      * Source: \train\X_train.txt"
      * Description: Recorded features train data
      * Rows: 7352
      * Columns:561
   1. dt_train_y 
      * Source: \train\X_train.txt"
      * Description: Recorded Activities(Code) train data
      * Rows: 7352
      * Columns:1
   1. dt_test_subject 
      * Source: \test\subject_test.txt"
      * Description: Recorded test data of subjects being observed
      * Rows: 2947
      * Columns:1
   1. dt_test_x 
      * Source: \train\X_test.txt"
      * Description: Recorded features test data
      * Rows: 2947
      * Columns:561
   1. dt_test_y 
      * Source: \train\X_test.txt"
      * Description: Recorded Activities(Code) test data
      * Rows: 2947
      * Columns:1
   1. dt_features 
      * Source: \train\features.txt"
      * Description: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
      * Rows: 561
      * Columns:2
   1. dt_activities 
      * Source: \train\activity_labels.txt"
      * Description: List of activities performed (Code and Label)
      * Rows: 6
      * Columns:2

### Task 1
Merges the training and the test sets to create one data set.
1. Combine the columns from all **train** data table (x, y and subject) using the cbind function
2. Combine the columns from all **test** data table (x, y and subject) using the cbind function
3. Merge the train and test data tables in a resulting data table named dt_work_data
4. Change the column names to: subject, features data table, activity

### Task 2
Extracts only the measurements on the mean and standard deviation for each measurement

1. Use the .SD method to create a subset with only the columns subject, activity and all others with **mean** or **std** in the name. 

### Task 3
Uses descriptive activity names to name the activities in the data set

1. Use the mapvalues function to link the activity code in the activity field to the activity lable in the data table dt_activities

### Task 4
Appropriately labels the data set with descriptive variable names.

1. Change the column names according to the following rules (in this order):
   1. Remove "(" , ")" and "-"
   1. *BodyBody* to *Body*
   1. *Body* to *Body-*
   1. *Gravity* to *Gravity-*
   1. *Acc* to *Accelerometer-*
   1. *Gyro* to *yroscope*
   1. *Mag* to *Magnitude-*
   1. *Freq* to *Frequency-*
   1. *mean* to *Mean-*
   1. *std* to *Standard-Deviation-"*
   1. *Jerk* to *Jerk-*
   1. *all f in the begging of the name* to *Frequency-*
   1. *all t in the begging of the name* to *Time-*
   1. Remove the ending "-"
   1. *activity* to *Activity*
   1. *subject* to *Subject*
   
Example of the final result: *Time-Body-Accelerometer-Mean-X*

### Task 5
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Group the data table by subject and activity and then calculate the average
1. Save the result in the file Tidy-Data.csv
