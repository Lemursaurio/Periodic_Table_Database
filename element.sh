#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else  
  echo "$1"
fi

if [[ $1 =~ [0-9]* ]];
then
  RESULT_DATA=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e LEFT JOIN properties p USING(atomic_number) WHERE e.atomic_number = $1")
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]];
then
  RESULT_DATA=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e LEFT JOIN properties p USING(atomic_number) WHERE e.symbol = '$1'")
else
  RESULT_DATA=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e LEFT JOIN properties p USING(atomic_number) WHERE e.name = '$1'")
fi

if [[ -z $RESULT_DATA ]]
then
  echo "No results"
else

  echo $RESULT_DATA | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT 
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."   
  done

fi
