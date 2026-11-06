SQL Commands Executed:

-- Create the database
CREATE DATABASE infoman1_vetclinic;

-- Verify database creation
SHOW DATABASES;

-- Select the database for active use
USE infoman1_vetclinic;


Verification & Deliverables:

Screenshot Location: week4/screenshots/task1.png

Confirmation: The output of SHOW DATABASES; includes infoman1_vetclinic.

Task 2 — Create the Core Tables

Create the core tables (owner, veterinarian, pet) based on the Week 3 logical schema. Proper data types, AUTO_INCREMENT primary keys, and NOT NULL constraints are defined.

SQL Commands Executed:

-- 1. Create owner table
CREATE TABLE owner (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(255)
);

-- 2. Create veterinarian table
CREATE TABLE veterinarian (
    vet_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100)
);

-- 3. Create pet table (references owner)
CREATE TABLE pet (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    birth_date DATE,
    owner_id INT NOT NULL,
    CONSTRAINT fk_pet_owner 
        FOREIGN KEY (owner_id) 
        REFERENCES owner(owner_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


Verification & Deliverables:

Screenshot Location: week4/screenshots/task2.png

Task 3 — Create the Relationship Tables

Create the relationship tables appointment (resolving the Pet–Veterinarian M:N relationship) and vaccination_record (resolving the weak entity from Week 3), with enforced foreign key constraints.

SQL Commands Executed:

-- 4. Create appointment table (M:N relationship between pet and veterinarian)
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    CONSTRAINT fk_appointment_pet 
        FOREIGN KEY (pet_id) 
        REFERENCES pet(pet_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_vet 
        FOREIGN KEY (vet_id) 
        REFERENCES veterinarian(vet_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- 5. Create vaccination_record table (Weak entity dependent on pet)
CREATE TABLE vaccination_record (
    vaccination_id INT AUTO_INCREMENT PRIMARY KEY,
    vaccine_name VARCHAR(100) NOT NULL,
    administered_date DATE NOT NULL,
    next_due_date DATE,
    pet_id INT NOT NULL,
    CONSTRAINT fk_vaccination_pet 
        FOREIGN KEY (pet_id) 
        REFERENCES pet(pet_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
