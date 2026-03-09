-- 1. Busqué el reporte del crimen en la fecha y ciudad indicadas. Encontré 2 testigos.

SELECT * FROM crime_scene_report WHERE date is 20180115 AND 
city = "SQL City" AND type= "murder" 

-- 2. Busqué la dirección del primer testigo, basandome en la pista de "la última casa". Encontré información adicional sobre él.

SELECT * FROM person
WHERE address_street_name is "Northwestern Dr"
ORDER BY address_number	DESC
LIMIT 1;
  
-- 3. Con el nombre: "Annabel" y dirección: "Franklin Ave" del segundo testigo, obtuve sus datos completos

SELECT  * FROM person
WHERE name LIKE "%Annabel%"
AND address_street_name is "Franklin Ave" 

-- 4. Con sus nombres y id´s pude obtener sus respectivas declaraciones

SELECT person.name,interview.transcript FROM person
JOIN interview ON person.id = interview.person_id
WHERE person_id is 16371 OR person_id is 14887

--5. Con base a la declaración de Morty, quién vió a un hombre
--salir del gimnasio Get Fit Now Gym, busqué su estado de membresía "gold" y su id "48Z"
SELECT * FROM get_fit_now_member 
WHERE membership_status = "gold" AND id LIKE "%48%"

--6. En la declaración se identifica la secuencia de una placa
-- "H42W". Realicé una búsqueda en la tabla de licencias de conducir 
--para identificar los vehiculos con dicha placa
SELECT * FROM drivers_license
WHERE plate_number LIKE "%H42W%";

--7. Con el identificador de licencia de conducción, busco la
-- información del sospechoso en la tabla personas
SELECT * FROM person WHERE license_id = 423327

--8. Partiendo de la información anterior
--Consulté la tabla get_fit_now_member y busqué aL
-- sospechoso utilizando su identificador correspondiente.
SELECT * FROM get_fit_now_member WHERE person_id = 67318

-- 9. Encuentro al asesino y confirmo mi análisis
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        SELECT value FROM solution;

--PARTE 2

--10. Teniendo el id del asesino, lo entrevisto
-- para obtener más informaión sobre el autor intelectual
-- Obtengo su declaración
SELECT * FROM interview WHERE person_id = 67318

--11. Con la información de la declaración, 
-- aplico varios filtros teniendo en cuenta las 
--características proporcionadas en el testimonio y encuentro 
-- a la autora intelectual
SELECT *
FROM drivers_license
JOIN person 
ON drivers_license.id = person.license_id
JOIN income 
ON person.ssn = income.ssn
WHERE drivers_license.car_model = 'Model S'
AND drivers_license.gender = 'female'
AND drivers_license.hair_color = 'red'
AND drivers_license.height BETWEEN 65 AND 67
AND person.id IN (
    SELECT person_id
    FROM facebook_event_checkin
    WHERE event_name = 'SQL Symphony Concert'
    GROUP BY person_id
    HAVING COUNT(*) = 3
);

--12. Encuentro a la autora intelectual y confirmo mi análisis
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;