
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# Load data
train = pd.read_csv("src/data/train.csv")
test = pd.read_csv("src/data/test.csv")

print("Training data:")
print(train.head())

# Select features
features = ["Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked"]

X_train = train[features].copy()
X_test = test[features].copy()
y_train = train["Survived"]

# Fill missing values
for col in ["Age", "Fare"]:
    median = X_train[col].median()
    X_train[col] = X_train[col].fillna(median)
    X_test[col] = X_test[col].fillna(median)

X_train["Embarked"] = X_train["Embarked"].fillna("S")
X_test["Embarked"] = X_test["Embarked"].fillna("S")

# Convert categorical variables
X = pd.concat([X_train, X_test])
X = pd.get_dummies(X, columns=["Sex", "Embarked"], dtype=int)

X_train = X.iloc[:len(train)]
X_test = X.iloc[len(train):]

print("\nProcessed training data:")
print(X_train.head())

# Train model
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

# Training predictions and accuracy
train_predictions = model.predict(X_train)

print("\nTraining accuracy:")
print(accuracy_score(y_train, train_predictions))

# Test predictions
test_predictions = model.predict(X_test)

print("\nTest predictions:")
print(test_predictions)
