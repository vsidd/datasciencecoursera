#The following code downloads the required dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest = "dataset.zip")
# The following code extract the dataset
unzip("dataset.zip")
setwd("UCI HAR Dataset")
library(dplyr)

#We load the different data available in the given dataset to respective variables
#Loads the test set
X_test <- read.table("test/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
#Loads the test labels
y_test <- read.table("test/y_test.txt", stringsAsFactors = FALSE, header = FALSE)
#Loads the subject of the test set
subject_test <- read.table("test/subject_test.txt", stringsAsFactors = FALSE, header = FALSE)

#Loads the training set
X_train <- read.table("train/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
#Loads the training labels
y_train <- read.table("train/y_train.txt", stringsAsFactors = FALSE, header = FALSE)
#Loads the subject of the training set
subject_train <- read.table("train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)

#Load the feature labels
features <- read.table("features.txt", stringsAsFactors = FALSE, header = FALSE)
#Load the activity labels that links the class label with their activity name
activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE, header = FALSE)

#Step 1: The following code merges the training and the test sets to create one data set.
mergedfeatures <- rbind(X_train, X_test)
mergedLabels <- rbind(y_train, y_test)
mergedSubjects <- rbind(subject_train, subject_test)

names(mergedLabels) <- c("Activity")
names(mergedSubjects) <- c("Subject")
names(mergedfeatures) <- features[,2]
dataset <- cbind(mergedSubjects, mergedLabels, mergedfeatures)


#Step 2: The following code extracts only the measurements on the mean and standard deviation for each measurement. 
valid_column_names <- make.names(names=names(dataset), unique=TRUE, allow_ = TRUE)
names(dataset) <- valid_column_names
mean_sd_dataset <- select(dataset, Subject, Activity, contains("mean"), contains("std"))

#Step 3: The following code uses the descriptive activity names to name the activities in the data set
mean_sd_dataset$Activity <- as.character(mean_sd_dataset$Activity)
for(i in 1:6){
        mean_sd_dataset$Activity[mean_sd_dataset$Activity == i] <- as.character(activity_labels[i,2])
}

#Step 4: The following code appropriately labels the data set with descriptive variable names. 
names(mean_sd_dataset) <- gsub("^t", "time", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("^f", "frequency", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("BodyBody", "Body", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Gyro", "Gyroscope", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Acc", "Accelerometer", names(mean_sd_dataset))
names(mean_sd_dataset) <- gsub("Mag", "Magnitude", names(mean_sd_dataset))

#Step 5: From the data set in step 4, the following code creates a second, independent tidy data set with 
#        the average of each variable for each activity and each subject.
mean_sd_dataset$Subject <- as.factor(mean_sd_dataset$Subject)
tidyDataSet <- aggregate(.~ Activity+Subject, dataset, mean)
tidyDataSet <- arrange(tidyDataSet, Activity, Subject)
write.table(tidyDataSet, "tidyDataset.txt", row.name=FALSE)