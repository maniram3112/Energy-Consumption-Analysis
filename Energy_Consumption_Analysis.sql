CREATE DATABASE ENERGY_CONSUMPTION_DB;

USE ENERGY_CONSUMPTION_DB;

-- 1. Country Table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

select * from country;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission DOUBLE,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 2 data points are missing
select count(*) from emission_3;

-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);
-- 1 data point is missing
select count(*) from population;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 3 datapoints are missing
select count(*) from production;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

select count(*) from gdp_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

-- 4 datapoints are missing
select * from consumption;


-- Relationships between the tables

-- 1. emission_3 -> country
ALTER TABLE emission_3
	ADD CONSTRAINT fk_emission_country
    FOREIGN KEY (country)
    REFERENCES country(Country)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- 2. population -> country
ALTER TABLE population
ADD CONSTRAINT fk_population_country
FOREIGN KEY (countries)
REFERENCES country(Country)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 3. production -> country
ALTER TABLE production
ADD CONSTRAINT fk_production_country
FOREIGN KEY (country)
REFERENCES country(Country)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 4. gdp_3 → country
ALTER TABLE gdp_3
ADD CONSTRAINT fk_gdp_country
FOREIGN KEY (Country)
REFERENCES country(Country)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 5. consumption → country
ALTER TABLE consumption
ADD CONSTRAINT fk_consumption_country
FOREIGN KEY (country)
REFERENCES country(Country)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Data Analysis Questions

-- 1. General & Comparative Analysis
