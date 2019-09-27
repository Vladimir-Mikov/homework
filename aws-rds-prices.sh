#!/bin/bash	
#https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonRDS/current/region_index.json > api.json


#./aws-rds-prices.sh >> ~/aws-prices/$date"_rds.cs"

now=$(date +"%Y%m")
file=~/${now}_rds.csv

curl https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonRDS/current/region_index.json > api.json

echo "Enter region name (e.g us-west-2)"

read region

cat api.json | jq ".regions[].currentVersionUrl" | grep $region | sed 's/.json/.csv/' >> ~/${now}_rds.cs

if [ -f "$file" ]; then
        echo "$file already exists, appending information"
        echo $now > $file
else
        echo "File does not exist, creating $file and writing into it"
        echo $now >> $file
fi

echo $now >> $file

#echo ~/${now}_rds.cs




