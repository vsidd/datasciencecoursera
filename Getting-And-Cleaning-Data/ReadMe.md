The repo contains 3 documents: ReadMe.md, CodeBook.md and run_analysis.R

###About the documents:
ReadMe.md explains how all of the scripts work and how they are connected

The CodeBook describes about the data, the variables and the transformation performed to clean up the data.

run_analysis.R contains the source code to transform the data from untidy state to a tidy state.

source("run_analysis.R") -> This source code downloads the data, unzips it to a directory and then it starts loading all the required files and then apply the following transformation to get a tidy dataset.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Required library:
The dplyr (dplyr_0.4.1) package is required to run this R code.

####Machine details:

The code is developed and run in RStudio.

R version 3.1.2 (2014-10-31)

Platform: Windows 8.1 (64-bit)
