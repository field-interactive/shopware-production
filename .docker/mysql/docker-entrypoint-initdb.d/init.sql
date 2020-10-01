-- create databases
CREATE DATABASE IF NOT EXISTS `shopware`;
CREATE DATABASE IF NOT EXISTS `shopware_test`;

-- create users
CREATE USER 'app'@'%' IDENTIFIED BY 'app';
CREATE USER 'app_test'@'%' IDENTIFIED BY 'app_test';

--  grant rights
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'app'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'app_test'@'%';
