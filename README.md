
# Titanic Survival Prediction

This project uses logistic regression to predict passenger survival on the Titanic dataset. The model is implemented in both Python and R, with each implementation running in a separate Docker container.

Both implementations:
1. Load the Titanic training and test datasets.
2. Handle missing values and encode categorical variables.
3. Train a logistic regression model using the full training dataset.
4. Calculate training accuracy.
5. Generate predictions for the test dataset.

## 1. Prerequisites

The following software is required:

- [Git](https://git-scm.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or Docker Engine

Make sure Docker is running before proceeding.

For WSL users, Docker Desktop must have WSL integration enabled under **Settings > Resources > WSL Integration**.

## 2. Clone the Repository

Open a terminal and run:

```bash
git clone https://github.com/Jason101010/titanic-disaster.git
cd titanic-disaster
```

All subsequent commands should be executed from the repository's root directory.

## 3. Download the Dataset

Download the Titanic dataset from [Kaggle](https://www.kaggle.com/competitions/titanic/data).

The following files are required:

- `train.csv`: Passenger information and survival outcomes.
- `test.csv`: Passenger information without survival outcomes.

Place both files inside the `src/data/` directory:

```text
src/data/
    - train.csv
        - test.csv
```

The datasets are excluded from the GitHub repository and must be downloaded separately.

## 4. Python Implementation

### Build the Docker Image

Run the following command from the repository root:

```bash
docker build -f src/python/Dockerfile -t titanic-python .
```

This builds a Docker image containing Python, pandas, scikit-learn, and the Python script.

### Run the Container

On Linux, macOS, or WSL Ubuntu:

```bash
docker run --rm -v "$(pwd)/src/data:/app/src/data:ro" titanic-python
```

The command mounts the local dataset directory inside the container and runs the Python script.

The terminal will display:
- A preview of the original training data.
- A preview of the processed training data.
- Training accuracy.
- Predictions for the test dataset.

## 5. R Implementation

### Build the Docker Image

Run the following command from the repository root:

```bash
docker build -f src/r/Dockerfile -t titanic-r .
```

This builds a separate Docker image containing R and the R script.

The R implementation uses the built-in `glm()` function, so no additional modeling packages are required.

### Run the Container

On Linux, macOS, or WSL Ubuntu:

```bash
docker run --rm -v "$(pwd)/src/data:/app/src/data:ro" titanic-r
```

The terminal will display:
- A preview of the original training data.
- A preview of the processed training data.
- Training accuracy.
- Predictions for the test dataset.

## 6. Model Details

Both implementations use the following features:

| Feature | Description |
|---------|-------------|
| Pclass | Passenger ticket class |
| Sex | Passenger sex |
| Age | Passenger age |
| SibSp | Number of siblings/spouses aboard |
| Parch | Number of parents/children aboard |
| Fare | Passenger fare |
| Embarked | Port of embarkation |

### Data Preprocessing

Missing Age and Fare values are replaced using medians calculated from the training dataset. Missing Embarked values are filled with Southampton (`S`).

Categorical variables are converted into numerical representations before fitting the model.

### Model Training and Prediction

Both implementations train logistic regression on all observations in `train.csv`.

Training accuracy is calculated by comparing predictions on the training data against the known survival outcomes.

The fitted models then generate predictions for `test.csv`.

Since the test dataset does not contain survival labels, test accuracy is not calculated. The test predictions are only displayed in the terminal.

## 7. Repository Structure

```text
titanic-disaster/
- .gitignore
- README.md
- src/
    - data/
        - .gitkeep
    - python/
        - Dockerfile
        - requirements.txt
        - main.py
    - r/
        - Dockerfile
        - install_packages.R
        - main.R
```

The `src/data/` directory is where the user should place the downloaded CSV files.

## 8. Troubleshooting

### Docker Cannot Connect to the Daemon

Make sure Docker Desktop or Docker Engine is running.

If using WSL, verify that Docker Desktop's WSL integration is enabled.

### Dataset Not Found

Make sure `train.csv` and `test.csv` are located in `src/data/`.

Run the Docker commands from the repository root rather than from the Python or R subdirectories.

### Docker Build Fails

Verify that the Dockerfile, source code, and dependency files exist in the correct locations.

Make sure Docker is running and an internet connection is available to download the required images and packages.

## 9. Reproducibility

Both implementations run in Docker containers with their own environments and dependencies.

After cloning the repository and downloading the datasets, users can build and run either implementation using the commands above.

No modifications to the source code are required.
