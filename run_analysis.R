library(reshape2)
library(dplyr)

filename <- "getdata_dataset.zip"

# Download dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename,mode = 'wb')
}  

#unzipps the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#read the test data files and merges them
activities_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- cbind(activities_test,subjects_test,test_data)

#read the train data files and merges them
activities_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- cbind(activities_train,subjects_train,train_data)

#merges the train and test data and renames the first 2 cols to descriptive names
data<- rbind(test,train)
names(data)[1:2] <- c("activity","subject")

#extracts measurements on mean and sd
features <- read.table("UCI HAR Dataset/features.txt")
features_index <- grepl(".*mean.*|.*std.*",features$V2)
col_names_vec <- names(data)
data <- select(data,col_names_vec[features_index])

#replaces variable names descriptive names
names(data)[3:length(names(data))] <- features$V2[features_index]

#replaces the activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
data <- merge(data,activities,by.x = "activity",by.y = "V1")
no_of_cols <- length(names(data))
data <- data[,c(no_of_cols,3:no_of_cols-1)]
names(data)[1] <- c("activity")
data <- arrange(data,data$subject)

#creates hte tidy data with the average 
#of each varible for each activity and each subject
#and writes the tidy data to a text file
dataMelt <- melt(data,id=c("activity","subject"))
dataCast <- dcast(dataMelt,activity + subject ~ variable,mean)
tidyData <- arrange(dataCast,dataCast$subject)
write.table(tidyData,"Tidy_Data.txt",row.names = FALSE,quote = FALSE)




