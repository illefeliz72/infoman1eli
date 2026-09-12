-- Database Creation
CREATE DATABASE infoman1_vetclinic;
USE infoman1_vetclinic;

-- Core Tables
CREATE TABLE owner (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT,
    email VARCHAR(100)
);

CREATE TABLE veterinarian (
    vet_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE pet (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    birth_date DATE,
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
);

-- Relationship Tables
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
    FOREIGN KEY (vet_id) REFERENCES veterinarian(vet_id)
);

CREATE TABLE vaccination_record (
    vaccination_id INT AUTO_INCREMENT PRIMARY KEY,
    vaccine_name VARCHAR(100) NOT NULL,
    date_administered DATE NOT NULL,
    next_due_date DATE,
    pet_id INT NOT NULL,
    FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
);

-- Fix Deliberate Mistake
ALTER TABLE owner MODIFY COLUMN phone_number VARCHAR(20);