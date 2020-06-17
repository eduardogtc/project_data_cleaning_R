# Data Cleaning Final Project
Final project for the data cleaning course with R at Coursera

**Author**: Eduardo Godoy

## Objective
Prepare tidy data that can be used for later analysis.

the data used in the project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data for the projec is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Tasks required 

Create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names.
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Files

1. README.md
    * This file, where the project is explained and files used 
1. CodeBook.md
    * The CodeBook describes the variables, the data files and the logic used in the script
1. run_analysis.R
    * The R script used to generate the final data set
1. tidy_data.txt
    * The final result of the project
    
## Additional comments

* R version 4.0.0 (2020-04-24) -- "Arbor Day"
* Platform: x86_64-w64-mingw32/x64 (64-bit)
* Packages:
    * data.table
    * plyr (because of the function mapvalues)
    * dplyr



