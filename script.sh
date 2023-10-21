#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo -e '\n~~~~~ MY SALON ~~~~~' 
echo -e "\nWelcome to My Salon, how can I help you?"

MAIN_MENU(){
SERVICES=$($PSQL "SELECT service_id, name FROM services")

echo "$SERVICES" | while read SERVICE_ID BAR NAME
 do
  echo "$SERVICE_ID  $NAME" | sed 's\|\) \'
 done 
read SERVICE_SELECTION
SERVICE_AVAILABLE=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_SELECTION")
 if [[ -z $SERVICE_AVAILABLE ]]
  then
  MAIN_MENU "I could not find that service. What would you like today?"
  else 
  echo $SERVICE_AVAILABLE | while read SERVICE_ID BAR NAME
  do
   echo "$SERVICE_ID $NAME | sed 's\|\) \'"
  done
 fi 
}
MAIN_MENU
