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
# edit these as needed
companyName="Firmanavn"
emplyeeNumber="Ansattnr"
firstName="Fornavn"
lastName="Etternavn"
#
# create an array with the column names
#
names=($(head -1 $filename | tr -d ' ' | tr -d '.' | tr ';' ' '))
#
# loop through the names to find the indexes we are looking for
#
for ((n = 0; n < ${#names[@]}; n++));
do
  case "${names[$n]}" in
  $companyName)
    companyNameColumn=$n
    ;;
  $emplyeeNumber)
    employeeNumberColumn=$n
    ;;
  $firstName)
    firstNameColumn=$n
    ;;
  $lastName)
    lastNameColumn=$n
    ;;
  *) ;;
  esac
done
#
# do we have all indexes to the required columns?
#
if [ -z "$companyNameColumn" ] || [  -z "$employeeNumberColumn" ] || [  -z "$lastNameColumn" ] || [  -z "$firstNameColumn" ]; then
  echo "Columns are missing"
  exit 1
fi
# adjust them a notch
#
((companyNameColumn++))
((employeeNumberColumn++))
((lastNameColumn++))
((firstNameColumn++))

echo "USE medlemmer;"
echo "DROP TABLE IF EXISTS $table;"
echo "SET character_set_client = utf8mb4;"
echo "CREATE TABLE $table ($companyName varchar(25), $emplyeeNumber int(11), $lastName varchar(25), $firstName varchar(25));"
n=0

while read -r line; do
  firmanavn=$(echo $line | cut -d';' -f$companyNameColumn)
  ansattnr=$(echo $line | cut -d';' -f$employeeNumberColumn)
  etternavn=$(echo $line | cut -d';' -f$lastNameColumn)
  fornavn=$(echo $line | cut -d';' -f$firstNameColumn)
#
# employees without an employee number are skipped.
#
  if [ ! -z $ansattnr ] ; then
    echo "INSERT INTO $table ($companyName, $emplyeeNumber, $lastName, $firstName) VALUES (\"$firmanavn\", $ansattnr, \"$etternavn\", \"$fornavn\");"
  ((n++))
  fi
done <${filename}
((n--))

echo "### Found $n entries"
