# setting filenames
filezip <- "UCI_dataset.zip"
filename <- "UCI HAR Dataset"
filepath <- file.path(getwd(), filename)

# downloading and unzipping the dataset if not present
if (!file.exists(filezip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filezip, method="curl")
}  
if (!file.exists(filename)) { 
  unzip(filezip)
}

# read all the necessary files
testSubject <- read.table(file.path(filepath, "test" , "subject_test.txt" ))
testData <- read.table(file.path(filepath, "test" , "X_test.txt" ))
testLabels <- read.table(file.path(filepath, "test" , "y_test.txt" ))
  
trainSubject <- read.table(file.path(filepath, "train", "subject_train.txt"))
trainData <- read.table(file.path(filepath, "train", "X_train.txt"))
trainLabels <- read.table(file.path(filepath, "train", "y_train.txt"))

# Merges the training and the test sets to create one data set
allSubject <- rbind(trainSubject, testSubject)
allData <- rbind(trainData, testData)
allLabels <- rbind(trainLabels, testLabels)

# Extracts only the measurements on the mean and standard deviation for each measurement.
dataFeatures <- read.table(file.path(filepath, "features.txt"))
mean_and_std_features <- grep("-(mean|std)\\(\\)", dataFeatures$V2)
allData <- allData[, mean_and_std_features]

names(allData) <- gsub("\\(\\)", "", dataFeatures[mean_and_std_features, 2]) # remove "()"
names(allData) <- gsub("mean", "Mean", names(allData)) # capitalize M
names(allData) <- gsub("std", "Std", names(allData)) # capitalize S
names(allData) <- gsub("-", "", names(allData)) # remove "-" in column names 

# Uses descriptive activity names to name the activities in the data set
activity <- read.table(file.path(filepath, "activity_labels.txt"))
allLabels$V1 <- activity[allLabels$V1, 2]
names(allLabels) <- "activity"

# Appropriately labels the data set with descriptive activity names
names(allSubject) <- "subject"
tidy_data <- cbind(allSubject, allLabels, allData)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
subjectLen <- length(table(allSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(tidy_data)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(tidy_data)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(allSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == tidy_data$subject
        bool2 <- activity[j, 2] == tidy_data$activity
        result[row, 3:columnLen] <- colMeans(tidy_data[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
# dim(result) --> 180 68

write.table(result, "tidy.txt", row.names=FALSE)