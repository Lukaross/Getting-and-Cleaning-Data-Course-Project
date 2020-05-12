## Getting and Cleaning Data Project 

In this course project we were asked to take a dataset from an experiment and produce a R script that would output a tidy version of the dataset in a single text file and a code book (`codebook.md`) to go along with this tidy data. The dataset and detials of the experiment can be found here <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. The R script `run_analysis.R` does the following:

1. Downloads the dataset if it does not already exist in the current working directory 
2. Unzips the file if it is not already unzipped
3. Reads and merges both the training and test datasets into a single data frame
4. Renames the activity and subject columns
5. From the single data frame selects only those columns which reflect a mean or standard deviation
6. Renames all variables with descriptive names
7. Creates a tidy dataset that consists of the mean average value of each variable for each subject and activity pair.

Results can be found in the `tidy.txt` file 
