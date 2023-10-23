#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo -e '\n~~~~~ MY SALON ~~~~~'

MAIN_MENU() {
  if [[ $1 ]]; then
    echo -e "\n$1"
  fi
  echo -e "\nWelcome to My Salon, how can I help you?\n"

  # Fetch the list of services  
  LIST_SERVICES=$($PSQL "SELECT * FROM services")
  echo "$LIST_SERVICES" | while read SERVICE_ID BAR SERVICE
  do
    ID=$(echo $SERVICE_ID | sed 's/ //g')
    NAME=$(echo $SERVICE | sed 's/ //g')
    echo "$ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    [1-5]) NEXT ;;
        *) GET_SERVICES_ID "I could not find that service. What would you like today?" ;;
  esac
}
APPOINTMENT_MENU(){
  echo "What's your phone number?"
  read PHONE_NUMBER
   if [[ ! $PHONE_NUMBER =~ ^[0-9]+$ ]]; then
  echo "Invalid phone number. 
  Please enter a valid numeric phone number."
  else
   NAME=$($PSQL "SELECT name FROM customers 
   WHERE phone=$PHONE_NUMBER")
   if [[ -z $NAME ]]
    then
     echo -e "\n What's your name?"
     read CUSTOMER_NAME
      SAVE_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name)
      VALUES('$PHONE_NUMBER', '$CUSTOMER_NAME')")
     fi
   GET_SERVICE_NAME=$($PSQL "SELECT name FROM services
   WHERE service_id=$SERVICE_ID_SELECTED")
   SERVICE_NAME=$(echo $GET_SERVICE_NAME| sed 's/ //g')
  CUSTOMER_ID=$($PSQL "SELECT customer_id 
  FROM customers WHERE phone='$CUSTOMER_PHONE'")
echo -e "\n What time would you like your $SERVICE_NAME, $CUSTOMER_NAME ?"
read SERVICE_TIME
 SAVE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")"
  if [[ $SAVED_TO_TABLE_APPOINTMENTS == "INSERT 0 1" ]]
  then
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
  fi
}


MAIN_MENU

