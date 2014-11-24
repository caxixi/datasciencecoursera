EXPLANATION OF HOW THE SCRIPT WORK:  

One script is porvided, and explanations are added within. Here is an walk-through the script, based on those explanations:

* R packages that are used above the basic in this script, data.table and dplyr, are called.  

* files are downloaded and unzipped, then red.

* the training data (in X_train) and the test data (in X_test) are merged with the respective volunteers and the activity data (subject_*, y_*  respectively), then the test and the train files are merged. 
 
* to assign collumn names, the features in  features.txt are converted to a character vector, which is then used to add column names.

* activity codes are replaced with character names describing the activities.

* a data frame tbl is  created, from which only columnes containing the strings "mean" or "std" (presumably stands for standard deviation) are selected to a new data frame tbl. 

* the tidy dataset, showing only the averge per volunteer per activity, is created under the name final_tidy.


      
      




