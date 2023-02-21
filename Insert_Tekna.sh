#!/bin/bash
#
if [ -z "$1" ]; then
  echo "Provide a CSV file"
  exit 1
fi
#
if [ -z "$2" ]; then
  echo "Provide a table name"
  exit 1
fi

filename=$1
table=$2

echo "USE medlemmer;"
echo "DROP TABLE IF EXISTS $table;"
echo "SET character_set_client = utf8mb4;"
echo "CREATE TABLE $table (Teknamedlem int(11), Ansattnr int(11), Etternavn varchar(25), Fornavn varchar(25), Epost varchar(50), Mobil varchar(20), Eksamen datetime);"
n=0

while read -r line; do

medlem=$(echo $line | cut -d';' -f1)
ansattnr=`echo $line | cut -d';' -f2`

if [ "$ansattnr" == "" ] ; then
ansattnr=0
fi

etternavn=`echo $line | cut -d';' -f3`
fornavn=`echo $line | cut -d';' -f4`
epost=`echo $line | cut -d';' -f14`
mobil=`echo $line | cut -d';' -f13`
eksamen=`echo $line | cut -d';' -f28`
month=`echo $eksamen | cut -d'/' -f1`
year=`echo $eksamen | cut -d'/' -f2`

eksamen=$year-$month-01


if [ $n -gt 0 ] ; then
echo "INSERT INTO $table (Teknamedlem, Ansattnummer, Etternavn, Fornavn, Epost, Mobil, Eksamen) VALUES ($medlem, $ansattnr, \"$etternavn\", \"$fornavn\", \"$epost\",  \"$mobil\", \"$eksamen\");"
fi
let "n++"
done < $filename
let "n--"

echo "#-- Found $n entries"
