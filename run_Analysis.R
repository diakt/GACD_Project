library(dplyr)

downloadLink <- "https://d396qusza40orc.cloudfront.net/
                getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "project.zip"

if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
        download.file(downloadLink, fileName, method = "curl")
}


if(!file.exists("UCI HAR Dataset")){
        unzip("project.zip")
}

#we are now in business. Have data, all those beautiful files
#defining various data lego blocks

activityLabels <- read.table("activity_labels.txt", col.names = c("exNum", "exType"))
features <- read.table("features.txt", col.names = c("Useless", "colNames"))

#train
subjectsTrain <- read.tables("UCI HAR Dataset/test/subject_test.txt", 
                                        col.names = "subTrainIdent")
trainData <- read.tables("UCI HAR Dataset/test/X_test.txt", 
                                        col.names = features$colNames)
trainExerIdent <- read.tables("UCI HAR Dataset/test/X_test.txt",
                                        col.names = "trainExer_type")

#type
subjectsTest <- read.tables("UCI HAR Dataset/test/subject_test.txt", 
                             col.names = "subTestIdent")
testData <- read.tables("UCI HAR Dataset/test/X_test.txt", 
                         col.names = features$colNames)
testExerIdent <- read.tables("UCI HAR Dataset/test/X_test.txt",
                              col.names = "testExer_type")

#we now have some blocks to assemble. Join the datasets

oneBlock <- rbind(subjectsTrain, subjectsTest)
twoBlock <- rbind(trainExerIdent, testExerIdent)
threeblock <- rbind(trainData, testData)

#and cook that shit up quay

thanos <- cbind(oneBlock, twoBlock, threeBlock)

#let's get this in tidyverse

thanos <- tbl_df(thanos)















