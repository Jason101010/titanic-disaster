# Load data
train <- read.csv("src/data/train.csv")
test <- read.csv("src/data/test.csv")

cat("Training data:\n")
print(head(train))

# Select features
features <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")

X_train <- train[, features]
X_test <- test[, features]

# Fill missing values
for (col in c("Age", "Fare")) {
  med <- median(X_train[[col]], na.rm = TRUE)
  X_train[[col]][is.na(X_train[[col]])] <- med
  X_test[[col]][is.na(X_test[[col]])] <- med
}

X_train$Embarked[is.na(X_train$Embarked) | X_train$Embarked == ""] <- "S"
X_test$Embarked[is.na(X_test$Embarked) | X_test$Embarked == ""] <- "S"

# Convert categorical variables
X_train$Sex <- factor(X_train$Sex)
X_test$Sex <- factor(X_test$Sex, levels = levels(X_train$Sex))

X_train$Embarked <- factor(X_train$Embarked)
X_test$Embarked <- factor(X_test$Embarked, levels = levels(X_train$Embarked))

cat("\nProcessed training data:\n")
print(head(X_train))

# Train model
X_train$Survived <- train$Survived

model <- glm(
  Survived ~ .,
  data = X_train,
  family = binomial
)

# Training predictions and accuracy
train_predictions <- as.integer(
  predict(model, type = "response") >= 0.5
)

cat("\nTraining accuracy:\n")
print(mean(train_predictions == train$Survived))

# Test predictions
test_predictions <- as.integer(
  predict(model, newdata = X_test, type = "response") >= 0.5
)

cat("\nTest predictions:\n")
print(test_predictions)
