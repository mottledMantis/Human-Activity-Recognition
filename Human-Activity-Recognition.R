library(tidyverse)
activity_labels <- read_csv("UCI HAR Dataset/activity_labels.txt", col_names = FALSE)
features <- read_table2("UCI HAR Dataset/features.txt", col_names = FALSE)
features_info <- read_csv("UCI HAR Dataset/features_info.txt", col_names = FALSE, skip = 11)
subject_train <- read_csv("UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
x_train <- read_csv("UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
y_train <- read_csv("UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
subject_test <- read_csv("UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
x_test <- read_csv("UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
y_test <- read_csv("UCI HAR Dataset/test/y_test.txt", col_names = FALSE)

# View(activity_labels)
# View(features)
# View(features_info)
# View(subject_train)
# View(X_train)
# View(y_train)
# View(subject_test)
# View(X_test)
# View(y_test)

colnames(y_train) <- ("ActivityLabel")
colnames(x_train) <- ("data1")
colnames(y_test) <- ("ActivityLabel")
colnames(x_test) <- ("data1")
colnames(subject_test) <- ("subject")
colnames(subject_train) <- ("subject")

#create dfs for train and test sets and merge them into all_data
train <- bind_cols(subject_train["subject"], y_train["ActivityLabel"], x_train["data1"])
test <- bind_cols(subject_test["subject"], y_test["ActivityLabel"], x_test["data1"])
all_data <- bind_rows(train, test)
# View(train)
# View(test)
# View(all_data)


new_feat <- as.tbl(data.frame(matrix(ncol = (nrow(features)), nrow = 0)))


#if I name the columns here, they work initially, but once I add rows below these names
#are overwritten with Xn and the values of row 1 - WHY???
# colnames(new_feat) <- features$X2

#initialize i for while loop - with a version for the full set and a safe version
i <- 1

#while (i < nrow(all_data)) {
while (i < 50) {

# vectorize a data cell
  cell <- c(unlist(strsplit(as.character(all_data[i, 3]), split = "\\s+")))

# pass the vector to a new row using rbind()
  new_feat <- rbind(new_feat, cell, stringsAsFactors = FALSE)
  i <- i + 1
}

#why does this only stick is placed AFTER adding rows?
colnames(new_feat) <- features$X2

j <- 1

while (j < nrow(all_data)) {
  if (all_data[j, "ActivityLabel"] == 1) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[1,1])
  }
  else if (all_data[j, "ActivityLabel"] == 2) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[2,1])
  }
  else if (all_data[j, "ActivityLabel"] == 3) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[3,1])
  }
  else if (all_data[j, "ActivityLabel"] == 4) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[4,1])
  }
  else if (all_data[j, "ActivityLabel"] == 5) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[5,1])
  }
  else if (all_data[j, "ActivityLabel"] == 6) {
    all_data[j, "ActivityName"] <- sub("^..", "", activity_labels[6,1])
  }
j <- j + 1
}
print(sub("^..", "", "1 ghd"))
