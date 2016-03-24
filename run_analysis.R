run_analysis <- function() {
  #load all neccessary libraries
  library(dplyr)

  #working folders 
  #setwd(file.path("GettingAndCleaningData","GettingAndCleaningData"))
  dataDir = "UCI HAR Dataset"
  testDir = file.path(dataDir, "test")
  trainDir = file.path(dataDir, "train")
  
  #read information about labels and features (their names)
  labels = read.table(file.path(dataDir, "activity_labels.txt"))
  features = read.table(file.path(dataDir, "features.txt"))
  
  #read all test data
  subject_test = read.table(file.path(testDir, "subject_test.txt"))
  X_test = read.table(file.path(testDir, "X_test.txt"))
  y_test = read.table(file.path(testDir, "y_test.txt"))
  
  #read all train data
  subject_train = read.table(file.path(trainDir, "subject_train.txt"))
  X_train = read.table(file.path(trainDir, "X_train.txt"))
  y_train = read.table(file.path(trainDir, "y_train.txt"))
 
  #merge train and test data
  subject = rbind(subject_test, subject_train)
  X = rbind(X_test, X_train)
  y = rbind(y_test, y_train)
  
  #set variable names for all 3 data frames.
  #feature names needs to be cleaned before we assign them to X data frame
  names(X) <- gsub("\\.+", ".", make.names(features[[2]], unique=TRUE))
  names(subject) <- c("subject")
  names(y) <- c("activity_id")

  #combine all three data frames into one
  data <- cbind(subject, y, X)
  
  #replace activity_id with labels
  data <- merge(data, labels, by.x = "activity_id", by.y = "V1")
  data <- rename(data, activity = V2)

  #from data select subject, activity, and variables that contains words "mean" or "std" in name
  data <- select(data, subject, activity, matches("mean|std"))
  
  
  #group data by subject and activity, and for each combination of those two variables
  #calculate average value of each other variable
  data <- data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
  data
}