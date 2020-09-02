-- create databases
CREATE DATABASE IF NOT EXISTS `application`;
CREATE DATABASE IF NOT EXISTS `application_test`;

-- create users
CREATE USER 'application'@'%' IDENTIFIED BY 'application';
CREATE USER 'application_test'@'%' IDENTIFIED BY 'application_test';

--  grant rights
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'application'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'application_test'@'%';