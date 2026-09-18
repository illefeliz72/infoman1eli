SELECT * FROM pet;

SELECT name, species FROM pet;

SELECT name, species 
FROM pet 
WHERE species = 'Dog';

SELECT * 
FROM pet 
WHERE birth_date > '2020-01-01';

SELECT * 
FROM appointment 
WHERE appointment_date >= '2026-09-01';

SELECT name, species, birth_date 
FROM pet 
WHERE species = 'Cat';

SELECT name, species, birth_date 
FROM pet 
WHERE species = 'Catt';