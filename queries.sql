SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name, date_of_birth FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name, neutered, escape_attempts FROM animals WHERE neutered = 'TRUE' AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts, weight_kg FROM animals WHERE weight_kg > 10.5;
SELECT name, neutered FROM animals WHERE neutered = 'TRUE';
SELECT name FROM animals WHERE NOT name = 'Gabumon';
SELECT name, weight_kg FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > DATE '2022-01-01';
SAVEPOINT SP01;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP01;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) AS "TOTAL ANIMALS" FROM animals;
SELECT COUNT(*) AS "ANIMALS WITH 0 ESCAPE COUNT" FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS "AVERAGE WEIGHT OF ANIMALS" FROM animals;
SELECT neutered, AVG(escape_attempts) AS "AVERAGE ESCAPE ATTEMPTS OF ANIMALS" FROM animals GROUP BY neutered ORDER BY AVG(escape_attempts) DESC LIMIT 1;
SELECT species, MIN(weight_kg) AS "MIN WEIGHT", MAX(weight_kg) AS "MAX WEIGHT" FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS "AVERAGE ESCAPE ATTEMPTS OF ANIMALS" FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

SELECT a.name AS "ANIMAL NAME", o.full_name AS "BELONG TO" FROM animals AS a 
JOIN owners AS o 
ON a.owner_id = o.id 
WHERE o.full_name = 'Melody Pond'; 

SELECT a.name AS "ANIMAL NAME", s.name AS "ANIMAL TYPE" FROM animals AS a 
JOIN species AS s 
ON a.species_id = s.id 
WHERE s.name = 'Pokemon';

SELECT o.full_name AS "OWNER NAME", a.name AS "ANIMAL NAME" FROM owners AS o 
LEFT JOIN animals AS a 
ON o.id = a.owner_id;

SELECT s.name AS "SPECIES", COUNT(a.species_id) "NUMBER OF ANIMALS PER SPECIES" FROM animals AS a 
JOIN species AS s 
ON a.species_id = s.id 
GROUP BY s.id;

SELECT o.full_name AS "OWNER NAME", a.name AS "ANIMAL NAME" FROM owners AS o 
JOIN animals AS a 
ON o.id = a.owner_id 
WHERE o.full_name = 'Jennifer Orwell' AND a.species_id = 2;

SELECT o.full_name AS "OWNER NAME", a.name AS "ANIMAL NAME", a.escape_attempts AS "ESCAPE ATTEMPTS" FROM owners AS o 
JOIN animals AS a 
ON o.id = a.owner_id 
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name AS "OWNER NAME", COUNT(a.name) as "NUMBER OF ANIMALS" FROM owners AS o 
LEFT JOIN animals AS a 
ON a.owner_id = o.id 
GROUP BY o.full_name 
ORDER BY COUNT(a.name) DESC 
LIMIT 1;

SELECT vets.name AS "VET NAME", animals.name AS "ANIMAL NAME", visits.date_of_visit AS "DATE OF VISIT" FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals
ON animals.id = visits.animal_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT vets.name AS "VET NAME", COUNT(DISTINCT visits.animal_id) AS "NUMBER OF DIFFERENT ANIMALS" FROM vets 
JOIN visits 
ON vets.id = visits.vet_id 
WHERE vets.name = 'Stephanie Mendez' 
GROUP BY vets.name;

SELECT vets.name AS "VET NAME", species.name AS "SPECIALTIES" FROM vets 
LEFT JOIN specializations 
ON vets.id = specializations.vet_id 
LEFT JOIN species 
ON specializations.species_id = species.id;

SELECT vets.name AS "VET NAME", animals.name AS "ANIMAL NAME", visits.date_of_visit AS "DATE OF VISIT" FROM vets 
JOIN visits 
ON vets.id = visits.vet_id 
JOIN animals 
ON visits.animal_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS "ANIMAL NAME", COUNT(animals.id) AS "NUMBER OF VISITS TO VET" FROM visits 
JOIN animals 
ON visits.animal_id = animals.id 
GROUP BY animals.name 
ORDER BY COUNT(animals.id) DESC 
LIMIT 1;

SELECT vets.name AS "VET NAME", visits.date_of_visit AS "DATE OF VISIT" FROM vets 
JOIN visits 
ON vets.id = visits.vet_id 
WHERE vets.name = 'Maisy Smith' 
ORDER BY visits.date_of_visit 
LIMIT 1;

SELECT animals.name AS "NAME", 
animals.date_of_birth AS "BIRTHDATE", 
animals.escape_attempts AS "ESCAPE ATTEMPTS", 
animals.neutered AS "NEUTERED", 
animals.weight_kg AS "WEIGHT", 
species.name AS "TYPE", 
vets.name AS "VET NAME", 
vets.age AS "VET AGE", 
vets.date_of_graduation AS "DATE OF GRAD", 
visits.date_of_visit AS "DATE OF VISIT" FROM visits 
JOIN animals 
ON visits.animal_id = animals.id 
JOIN species 
ON animals.species_id = species.id 
JOIN vets 
ON visits.vet_id = vets.id 
ORDER BY visits.date_of_visit DESC 
LIMIT 1;

SELECT animals.name AS "ANIMAL NAME",
COUNT(visits.animal_id) AS "NUMBER OF VISITS",
vets.name AS "VET NAME",
specializations.species_id AS "SPECIALTIES" FROM visits
JOIN animals
ON animals.id = visits.animal_id
FULL JOIN specializations
ON visits.vet_id = specializations.vet_id
JOIN vets
ON visits.vet_id = vets.id
GROUP BY visits.animal_id, visits.vet_id, animals.name,
specializations.species_id, vets.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

SELECT species.name AS "SPECIES TYPE",
COUNT(visits.animal_id) AS "NUMBER OF VISITS",
vets.name AS "VET NAME" FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, animals.species_id, species.name
ORDER BY animals.species_id DESC
LIMIT 1;

EXPLAIN ANALYZE SELECT * FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';



