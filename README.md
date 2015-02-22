-================
+## Introduction
+
+ The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis

+## Input data
+ Sample data is from:
+* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">Human Activity Recognition</a> 
+* <b>Description</b>: A full description is available at the site where the data was obtained.
+
+## Cleaning data
+
+ Cleaning data is executed by run_analysis.R script following the below steps:
+* Merging training data and test data.
+* Getting necessary variables for analysis. In this case, they are mean and std variables.
+* Transforming variables to descriptive variable names.
+* Creating a new data set which combine the records by subject and activity with mean value for the remaining variables.
+
+## Output data
+
+ Output is a text file named tidy_data_set.txt which is ready to use for analysis.
