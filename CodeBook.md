-================
+## Introduction
+
+ This is explained how the run_analysis.R script running.
+
+
+## The script explanation
+
+The dataset after downloading must be extracted to the same folder contains run_analysis.R.
+The script will do the below things:
+* Read data from files (train, test, subject and features files)
+* Merge training data and test data
+* Extract only mean and std data
+* Convert activity value to activity names (based on activity_labels.txt file)
+* Set descriptive names for column names
+* Merge all data: x, y and subject into one dataset
+* Create a new data with the keys are subjectID and activity, the other variables will be calculated by mean
+* Export the new data to a text file (tidy_data_set.txt) in the same folder with run_analysis.R file
