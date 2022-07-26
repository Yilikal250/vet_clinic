select * from animals where name LIKE  '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '#01-01-2016#' AND '#01-01-2019#';
SELECT name FROM animals WHERE neutered = 't' AND escape_attempts < '3';

