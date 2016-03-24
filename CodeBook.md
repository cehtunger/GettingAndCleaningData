# Getting and cleaning data assignment code book

run_analysis function reads all neccessary data from files
and returns data frame with following variables:
subject - subject id from data
activities - factor variable which describes activity
all mean and standard deviation variables from original data set

data frame contains unique combinations of subject and activity,
an average values for each mean or standard deviation variable for
given subject and activity.

# Data cleaning and processing

Here, all R variables are formatted as **strong**,
and all variables that represents data frame variables (columns) ar formatted as *emphasis*

variable **labels** contains activity labels from file activity_labels.txt
variable **features** contains features from file features.txt
variables **subject_test**, **X_test**, **y_test**, **subject_train**, **X_train**, **y_train** contains corresponding data
from test and train sapmles.

variables **subject**, **X**, **y** are created by merging corresponding test and train data

variable **feature** is used to set names of variables in **X** data frame. Before assigning names
to data frame they need to be processed using make.names function. This is required so that
each column name in the data frame have unique name. After that one additional cleaning is
required, removing all repeating of charater ".", so that column names are more readable.

for data in variables **subject** and **y** names *subject* and *activity_id* are asigned respectively.

data frames **subject**, **y** and **X** are merged into one data frame variable with name **data**.
It is very important to do merge before any other operation, like subsetting by columns and rows,
because any such operation doesn't keep row ordering, which can result in invalid data.

**data** is merged with **labels** and column *V2* from **labels** is renamed to *activity*

from the **data**, following columns are selected: *subject*, *activity*, and all columns that contains word "mean" or "std" in name.

data in **data** is grouped by columns *subject* and *activity*. For each unique combination of *subject* and *activity*, average value is
calculated for each other column in **data**, and resulting data frame is returned from function.



