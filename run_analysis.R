# The script below does the following things:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

library(plyr)

# Set path to extracted data source
dataPath <- "./UCI HAR Dataset"

# Read training data
xtrainDF <- read.table(file=paste(dataPath,"train/X_train.txt", sep = "/"), header = FALSE)
ytrainDF <- read.table(file=paste(dataPath,"train/y_train.txt", sep = "/"), header = FALSE)
subjectTrainDF <- read.table(file=paste(dataPath,"train/subject_train.txt", sep = "/"), header = FALSE)

# Read test data
xtestDF <- read.table(file=paste(dataPath,"test/X_test.txt", sep = "/"), header = FALSE)
ytestDF <- read.table(file=paste(dataPath,"test/y_test.txt", sep = "/"), header = FALSE)
subjectTestDF <- read.table(file=paste(dataPath,"test/subject_test.txt", sep = "/"), header = FALSE)

# Read features data
features <- read.table(file=paste(dataPath,"features.txt", sep = "/"), header = FALSE)

# 1. Merges the training and the test sets to create one data set.
xdataDF <- rbind(xtrainDF, xtestDF)
ydataDF <- rbind(ytrainDF, ytestDF)
subjectDF <- rbind(subjectTrainDF, subjectTestDF)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Find all standard deviation and mean columns by getting only columns with mean() or std() 
meanStdPos <- grep("mean\\(\\)|std\\(\\)", features[,2])
# Extracting data
xdataDF <- xdataDF[,meanStdPos]

# 3. Uses descriptive activity names to name the activities in the data set
actColNames <- c('actCode','actName')
activityNames <- read.table(file=paste(dataPath, "activity_labels.txt", sep = "/"), header = FALSE, col.names=actColNames)
# Format activity names
activityNames$actName <- tolower(gsub("_", " ", activityNames$actName))

# Names the activities 
ydataDF[, 1] <- activityNames[ydataDF[, 1], 2]

# 4. Appropriately label the data set with descriptive variable names
featuresColNames <- features[meanStdPos,2]
featuresColNames <- gsub("\\(\\)", "", featuresColNames) 
featuresColNames <- gsub("mean", "Mean", featuresColNames) 
featuresColNames <- gsub("std", "Std", featuresColNames) 
featuresColNames <- gsub("-", "", featuresColNames) 

colnames(xdataDF) <- featuresColNames
colnames(ydataDF) <- c('activity')
colnames(subjectDF) <- c('subjectId')

# Merges 3 data frames
dataDF <- cbind(xdataDF,ydataDF, subjectDF)

# 5.Create a second, independent tidy data set with the average of each variable for each activity and each subject
avgDataDF <- ddply(dataDF, .(subjectId, activity), function(x) colMeans(x[, 1:66]))

# Write average data to file
write.table(avgDataDF, "tidy_data_set.txt", row.name=FALSE)
