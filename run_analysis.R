# Activity 1 import data
activities = read.table('activity_labels.txt', header = F,stringsAsFactors=FALSE)
features = read.table('features.txt', header = F,stringsAsFactors=FALSE)
train_subj = read.table('train/subject_train.txt', header = F)
train_feat = read.table('train/X_train.txt', header = F)
train_act = read.table('train/y_train.txt', header = F)
test_subj = read.table('test/subject_test.txt', header = F)
test_feat = read.table('test/X_test.txt', header = F)
test_act = read.table('test/y_test.txt', header = F)
# Activity 2 merge data and label it
myData <- rbind(
  cbind(train_subj,train_feat,train_act),
  cbind(test_subj,test_feat,test_act)
)
names(myData) <- c("subject",features[,2],'activity')
myData$activity <- factor(myData$activity,
                          levels = c(1:6),
                          labels = activities[,2])

#Activity 3 summarize data
tidy = myData[,c(1, grep('mean\\()',names(myData)), grep('std()',names(myData)), 563)]
#Activity 4 write data
write.csv(tidy,file='tidy.csv')

# Second chore

tidy2<-NULL
for (i in 1:30) {
  for (j in names(table(tidy$activity))) {
    tidy2 = rbind(tidy2,sapply(subset(tidy,tidy$subject == i & tidy$activity == j)[,2:67],mean))
  }
}

tidy2 <- as.data.frame(tidy2)
tidy2$subject <- rep(1:30,6)
tidy2$activity <- as.factor(rep(names(table(tidy$activity)),30))

#Hello there
write.csv(tidy2,file='tidy2.csv')


