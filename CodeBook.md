# Code Book

### The script run_analysis.R performs the 5 steps described in the course project's definition.

   * First, all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
   * Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
   * As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
   * On the whole dataset, those columns with vague column names are corrected.
   * Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called tidy.txt

### Code Variables

   * trainData, trainLabels, testData, testLabels, trainSubject and testSubject contain the data from the downloaded files.
   * trainData, trainLabels and trainSubject merge the previous datasets to further analysis.
   * dataFeatures contains the correct names for the trainData dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
   * A similar approach is taken with activity names through the activities variable.
   * allData merges trainData, trainLabels and trainSubject in a big dataset.
   * Finally, tidy contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.

### Measurements

"tBodyAccMeanX" "tBodyAccMeanY" "tBodyAccMeanZ" "tBodyAccStdX" "tBodyAccStdY" "tBodyAccStdZ" "tGravityAccMeanX" "tGravityAccMeanY" "tGravityAccMeanZ" "tGravityAccStdX" 
"tGravityAccStdY" "tGravityAccStdZ" "tBodyAccJerkMeanX" "tBodyAccJerkMeanY" "tBodyAccJerkMeanZ" "tBodyAccJerkStdX" "tBodyAccJerkStdY" "tBodyAccJerkStdZ" "tBodyGyroMeanX" 
"tBodyGyroMeanY" "tBodyGyroMeanZ" "tBodyGyroStdX" "tBodyGyroStdY" "tBodyGyroStdZ" "tBodyGyroJerkMeanX" "tBodyGyroJerkMeanY" "tBodyGyroJerkMeanZ" "tBodyGyroJerkStdX" 
"tBodyGyroJerkStdY" "tBodyGyroJerkStdZ" "tBodyAccMagMean" "tBodyAccMagStd" "tGravityAccMagMean" "tGravityAccMagStd" "tBodyAccJerkMagMean" "tBodyAccJerkMagStd" 
"tBodyGyroMagMean" "tBodyGyroMagStd" "tBodyGyroJerkMagMean" "tBodyGyroJerkMagStd" "fBodyAccMeanX" "fBodyAccMeanY" "fBodyAccMeanZ" "fBodyAccStdX" "fBodyAccStdY" 
"fBodyAccStdZ" "fBodyAccJerkMeanX" "fBodyAccJerkMeanY" "fBodyAccJerkMeanZ" "fBodyAccJerkStdX" "fBodyAccJerkStdY" "fBodyAccJerkStdZ" "fBodyGyroMeanX" "fBodyGyroMeanY" 
"fBodyGyroMeanZ" "fBodyGyroStdX" "fBodyGyroStdY" "fBodyGyroStdZ" "fBodyAccMagMean" "fBodyAccMagStd" "fBodyBodyAccJerkMagMean" "fBodyBodyAccJerkMagStd" "fBodyBodyGyroMagMean" 
"fBodyBodyGyroMagStd" "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStd"

### Identifiers

   * subject - The ID of the test subject
   * activity - The type of activity performed when the corresponding measurements were taken

### Activity Labels

   * WALKING (value 1): subject was walking during the test
   * WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
   * WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
   * SITTING (value 4): subject was sitting during the test
   * STANDING (value 5): subject was standing during the test
   * LAYING (value 6): subject was laying down during the test

