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
