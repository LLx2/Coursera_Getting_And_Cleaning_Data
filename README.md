# Coursera_Getting_And_Cleaning_Data
The required scripts for the Coursera, Getting &amp; Cleaning Data course, week 4.

The purpose of this file is to explain how the script run_analysis.R works via the codebook. Aditionally it serves as as repository for the finished tidy data(Tidy.txt) & the raw data which the tidy data is built off of.

All data files are available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

After retrieving the data from the above site, run the program run_analysis.R. The cookbook will guide you through each step
of the code.

In summary:
run_analysis.R is an R script that downloads and places all files from the above link into a file named "data." Then the script will comingle the data as needed into 1 set (explained in the cookbook), pull the required information (explained in the cookbook), creates a more descriptive & appropriately labeled data frame (explained in the cookbook) and finally reutrns a tidy & independent data set with the avg of each variable for each activity & subject.

