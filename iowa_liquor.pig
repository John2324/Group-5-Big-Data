-- This pig script is for the iowa_liquor.csv
-- that should be already uploaded into LOCAL FILE SYSTEM
-- The script will analyze and filter the data
-- with the top 10 counties who bought "  "


-- STEP 1: LOAD YOUR DATA
-- REMEMBER TO MODIFY THE DIRECTORY TO YOUR FILE
data = LOAD './project/iowa_liquor.csv' AS (invoice: chararray, 
date_sold: chararray, 
store_number: int,
store_name: chararray, 
address: chararray, 
city: chararray, 
zipcode: int, 
county_num: int, 
count_name: chararray, 
vendor_num: int, 
vendor_name: chararray, 
item_num: int, 
item_name: chararray, 
pack: int,
bottle_volume: int, 
state_bottle_cost: chararray, 
state_bottle_retail: chararray,
bottles_sold: int, 
sale_dollar: int, 
sale_volume_liter: int, 
sale_volume_gallon: int);


-- STEP 2 FILTER DATA by drink "Jim Beam"
jims = FILTER data BY vendor_num == 65;

-- STEP 3 Group results by county
group_county = GROUP jims BY count_name;

-- STEP 4 GENERATE TOTAL SUM OF bottles_sold AND displaying county, item name, and number of bottles sold
totals = FOREACH group_county GENERATE jims.count_name, jims.item_name, SUM(jims.bottles_sold) AS total_bottles_sold;

-- STEP 5 Sort from highest to lowest
sort_bottles = ORDER totals BY total_bottles_sold DESC;

-- STEP 6 OUTPUT TOP 10 COUNTIES WITH THE MOST JIM BEAM BOTTLES SOLD
top_county = LIMIT sort_bottles 10;

-- STEEP 7 DISPLAY OUTPUT OF top_county
DUMP top_county;