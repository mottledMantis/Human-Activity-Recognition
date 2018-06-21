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

colnames(y_train) <- ("labels")
colnames(x_train) <- ("data1")
colnames(y_test) <- ("labels")
colnames(x_test) <- ("data1")
colnames(subject_test) <- ("subject")
colnames(subject_train) <- ("subject")

# train <- full_join(y_train, x_train)
# test <- full_join(y_test, x_test)
# View(train)
# View(test)
train <- bind_cols(subject_train["subject"], y_train["labels"], x_train["data1"])
test <- bind_cols(subject_test["subject"], y_test["labels"], x_test["data1"])
# View(train)
# View(test)
all_data <- bind_rows(train, test)
# View(all_data)


new_feat <- data.frame(matrix(ncol = (nrow(features)), nrow = 0))

colnames(new_feat) <- features$X2


i <- 1
while (i < nrow(all_data)) {
# print(i)
# vectorize a data cell
cell <- c(unlist(strsplit(as.character(all_data[i, 3]), split = "\\s+")))

# pass the vector as a new row using rbind()
new_feat <- rbind(new_feat, cell, stringsAsFactors = FALSE)
i <- i + 1
}

# # strsplit(as.character(all_data[2, "data1"]), split = "\\s+")
# i <- 1 #outer loop, col
# j <- 1 #inner loop, row
# while (i < nrow(all_data)) {
#   print(i)
#   while (j < nrow(features)) {
#     print(j)
#     new_feat[1,1] <- unlist(strsplit(as.character(all_data[j, 3]), split = "\\s+"))
#   j <- j + 1
#   }
# i <- i + 1
# }


