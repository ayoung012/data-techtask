#!/bin/sh

DATA_FOLDER=https://s3-ap-southeast-2.amazonaws.com/vibrato-data-test-public-datasets
DATA_ZIP=world-food-facts.zip
DATA_TSV=en.openfoodfacts.org.products.tsv

DB=food.db
TBL=food_facts

echo Downloading World Food Facts dataset, this may take a while...

# Grab dataset for Task 1
wget $DATA_FOLDER/$DATA_ZIP

echo Unzipping facts archive...
unzip $DATA_ZIP

echo Removing all quotes, not required for this analysis
sed -i 's/"//g' $DATA_TSV

echo Number of lines to import (including header):
cat $DATA_TSV | wc -l

echo Importing food facts into an SQLite file...


sqlite3 $DB -batch $1 <<EOF
.mode tabs
.import ${DATA_TSV} ${TBL}

EOF

echo Done.

echo Number of lines successfully imported to sqlite:
sqlite3 $DB  "select count(*) from $TBL"

echo Head into the Jupyter Notebook for further analysis.

echo Passing on to Jupyter Notebook start script...

