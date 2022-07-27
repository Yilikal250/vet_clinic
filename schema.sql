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
