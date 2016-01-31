library(plyr)

# setting filenames
filezip <- "UCI_dataset.zip"
filename <- "UCI HAR Dataset"
filepath <- file.path(getwd(), filename)

# downloading and unzipping the dataset
if (!file.exists(filezip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filezip, method="curl")
}  
if (!file.exists(filename)) { 
  unzip(filezip)
}

# read all the necessary files
testSubject <- tbl_df(read.table(file.path(filepath, "test" , "subject_test.txt" )))
testData <- tbl_df(read.table(file.path(filepath, "test" , "X_test.txt" )))
testLabels <- tbl_df(read.table(file.path(filepath, "test" , "y_test.txt" )))
  
trainSubject <- tbl_df(read.table(file.path(filepath, "train", "subject_train.txt")))
trainData <- tbl_df(read.table(file.path(filepath, "train", "X_train.txt")))
trainLabels <- tbl_df(read.table(file.path(filepath, "train", "y_train.txt")))

dataFeatures <- tbl_df(read.table(file.path(filepath, "features.txt")))
activity <- tbl_df(read.table(file.path(filepath, "activity_labels.txt")))


# Merges the training and the test sets to create one data set
allSubject <- rbind(trainSubject, testSubject)
allData <- rbind(trainData, testData)
allLabels <- rbind(trainLabels, testLabels)
colnames(allData) <- dataFeatures$V2


# Extracts only the measurements on the mean and standard deviation for each measurement
mean_and_std_features <- grep("-(mean|std)\\(\\)", dataFeatures$V2)
allData <- allData[, mean_and_std_features]


# Uses descriptive activity names to name the activities in the data set
allLabels$V1 <- activity[allLabels$V1, 2]


# Appropriately labels the data set with descriptive variable names
colnames(allLabels) <- "activity"
names(allSubject) <- "subject"


# creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- ddply(allData, 1:66, function(x) colMeans(x[, 1:66]))
tidy_data <- cbind(allData, allLabels, allSubject)

write.table(tidy_data, "tidy.txt", row.names = FALSE, quote = FALSE)
