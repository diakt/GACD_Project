library(dplyr)

downloadLink <- "https://d396qusza40orc.cloudfront.net/
                getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "project.zip"


if(!file.exists("UCI HAR Dataset")){
        if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
                download.file(downloadLink, fileName, method = "curl")
        } 
        unzip("project.zip")
}

#we are now in business. Have data, all those beautiful files
#defining various data lego blocks
#print(read.table("UCI HAR Dataset/activity_labels.txt"))
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("exNum", "exType"))
#print(activityLabels)
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("Useless", "colNames"))

#train
subjectsTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                                        col.names = "identif")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", 
                                        col.names = features$colNames)
trainExerIdent <- read.table("UCI HAR Dataset/train/y_train.txt",
                                        col.names = "exerType")

#test
subjectsTest <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                             col.names = "identif")
testData <- read.table("UCI HAR Dataset/test/X_test.txt", 
                         col.names = features$colNames)
testExerIdent <- read.table("UCI HAR Dataset/test/y_test.txt",
                              col.names = "exerType")

#we now have some blocks to assemble. Join the datasets

oneBlock <- rbind(subjectsTrain, subjectsTest)
twoBlock <- rbind(trainExerIdent, testExerIdent)
threeBlock <- rbind(trainData, testData)

#and cook that shit up quay

thanos <- cbind(oneBlock, twoBlock, threeBlock)
thanos$exerType <- activityLabels[thanos$exerType, 2]
print("After?")
#I'll be honest, getting to this point was incredibly difficult for me
#and this is my fourth language
#let's get this in tidyverse

thanos <- tibble::as_tibble(thanos)
print("dingo")
#split down to measurements on means or standard deviations

specific <- thanos %>% select(identif, exerType, contains("mean"), contains("std"))
print("Charlatan")
#sidenote, std is an awful shortened name for standard deviation, like come on
#print(specific)
#but we now have our special <3 little <3 table
#time to clean
print("this?")
names(specific) <- gsub("^t", "Time", names(specific))
names(specific) <- gsub("^f", "Frequency", names(specific)) #done with initials
names(specific) <- gsub("Acc", "Acceleration", names(specific))
names(specific) <- gsub("Freq", "Frequency", names(specific))
names(specific) <- gsub("Gyro", "Gyroscope", names(specific))
names(specific) <- gsub("mean", "Mean", names(specific))
names(specific) <- gsub("std", "StandardDeviation", names(specific))
names(specific) <- gsub("gravity", "Gravity", names(specific))
names(specific) <- gsub("mag", "Magnitude", names(specific))
names(specific) <- gsub("-", "", names(specific))

print("honey?")
# I also thought about replacing jerk, but it turns out that that's a real metric
#jerk is the third derivative, also known as d'''
#guess what the fourth, fifth, and sixth derivative are?

#snap, crackle, and pop

#I wish I was kidding
#Let's convert the activity number associates to the activity names


#And create our mean-cycle group
returnedData <- specific %>% group_by(identif, exerType) %>% summarize_all(funs(mean))

#Our special table is returned, or what it is in r

print(returnedData)








