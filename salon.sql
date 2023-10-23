#You should create a database named salon
CREATE DATABASE saloon


#You should connect to your database, then create tables named customers, appointments, and services
#Each table should have a primary key column that automatically increments
#Each primary key column should follow the naming convention, table_name_id. For example, the customers table should have a customer_id key. Note that there’s no s at the end of customer

\c saloon


#Your customers table should have phone that is a VARCHAR and must be unique
#Your customers and services tables should have a name column

CREATE TABLE customers(
customer_id SERIAL PRIMARY KEY,
phone VARCHAR(15) UNIQUE,
name VARCHAR(30)
);


#Your appointments table should have a time column that is a VARCHAR

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT,
    service_id INT,
    time VARCHAR(15)
);

CREATE TABLE services(
service_id SERIAL PRIMARY KEY,
name VARCHAR(30)
);



#Your appointments table should have a customer_id foreign key that references the customer_id column from the customers table
#Your appointments table should have a service_id foreign key that references the service_id column from the services table
ALTER TABLE appointments 
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
ADD FOREIGN KEY (service_id) REFERENCES services(service_id)
;


#You should have at least three rows in your services table for the different services you offer, one with a service_id of 1

INSERT INTO services(name)
VALUES('Haircut'),('Pedicure'),('Manicure');


#You should create a script file named salon.sh in the project folder

touch salon.sh


#Your script file should have executable permissions

chmod +x salon.sh


#You should display a numbered list of the services you offer before the first prompt for input, each with the format #) 
<service>. For example, 1) cut, where 1 is the service_id


