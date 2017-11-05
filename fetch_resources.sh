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
unzip $DATA_FILENAME

echo Number of lines to import:
cat DATA_TSV | wc -l

echo Importing food facts into an SQLite file...
sqlite3 -separator $'\t' $DB ".import $DATA_TSV $TBL"

echo Done.

echo Number of lines successfully imported to sqlite:
sqlite3 test.db  "select count(*) from $TBL"

echo Head into the Jupyter Notebook for further analysis.

echo Passing on to Jupyter Notebook start script...


