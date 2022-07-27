 CREATE TABLE animals (
    id integer,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric
);
ALTER TABLE animals
ADD COLUMN species TEXT;

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name TEXT
);

ALTER TABLE animals 
DROP COLUMN id, DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN id SERIAL PRIMARY KEY, ADD COLUMN species_id INT;

ALTER TABLE animals 
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets (id),
    species_id INT REFERENCES species (id)
);

CREATE TABLE visits (
    animal_id INT REFERENCES animals (id),
    vet_id INT REFERENCES vets (id),
    date_of_visit DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX visits_animal_id_idx ON visits(animal_id);
CREATE INDEX visits_vet_id_idx ON visits(vet_id);
CREATE INDEX owners_email_idx ON owners(email);
