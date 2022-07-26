select * from animals where name LIKE  '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '#01-01-2016#' AND '#01-01-2019#';
SELECT name FROM animals WHERE neutered = 't' AND escape_attempts < '3';
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg < '10.5';
