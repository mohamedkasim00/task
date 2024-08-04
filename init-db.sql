-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS petclinic;

-- Create a new user with a password
CREATE USER 'petclinic'@'%' IDENTIFIED BY 'petclinicpassword';

-- Grant all privileges on the petclinic database to the new user
GRANT ALL PRIVILEGES ON petclinic.* TO 'petclinic'@'%';

-- Apply the changes
FLUSH PRIVILEGES;
