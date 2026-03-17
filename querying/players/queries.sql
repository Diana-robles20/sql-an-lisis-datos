----------------------------------------------------------------------------------------------------------------------------------------
-- DATASET: PLAYERS
----------------------------------------------------------------------------------------------------------------------------------------
-- Base de datos de jugadores de béisbol.
-- Contiene información como nombre, lugar de nacimiento,
-- altura, peso, mano con la que batea/lanzan y fechas de carrera.
-- Este archivo incluye consultas para explorar y analizar los datos.


---------------------------------------------------------------------------------------------------------------------------------------
-- FILTROS BÁSICOS
----------------------------------------------------------------------------------------------------------------------------------------

-- Lugar de nacimiento de Jackie Robinson
SELECT birth_city, birth_state, birth_country
FROM players
WHERE first_name = 'Jackie'
AND last_name = 'Robinson';

-- Mano con la que bateaba Babe Ruth
SELECT bats
FROM players
WHERE first_name = 'Babe'
AND last_name = 'Ruth';

-- Jugadores sin fecha de debut (datos faltantes)
SELECT id
FROM players
WHERE debut IS NULL;


--------------------------------------------------------------------------------------------------------------------------------------
-- FILTROS POR CONDICIÓN + ORDENAMIENTO
--------------------------------------------------------------------------------------------------------------------------------------

-- Jugadores nacidos fuera de USA
SELECT first_name, last_name
FROM players
WHERE birth_country != 'USA'
ORDER BY first_name ASC, last_name ASC;

-- Jugadores que batean con la derecha
SELECT first_name, last_name
FROM players
WHERE bats = 'R'
ORDER BY first_name ASC, last_name ASC;


--------------------------------------------------------------------------------------------------------------------------------------
-- FILTROS POR FECHA
--------------------------------------------------------------------------------------------------------------------------------------

-- Jugadores debutados desde el año 2000
SELECT ROUND(AVG(height), 2) AS 'Average height',
       ROUND(AVG(weight), 2) AS 'Average weight'
FROM players
WHERE debut >= '2000%';

-- Jugadores cuyo último juego fue en 2022
SELECT first_name, last_name
FROM players
WHERE final_game LIKE '2022%'
ORDER BY first_name ASC, last_name ASC;


-------------------------------------------------------------------------------------------------------------------------------------
-- FILTROS COMPUESTOS
-------------------------------------------------------------------------------------------------------------------------------------

-- Jugadores nacidos en Pittsburgh, PA ordenados por debut
SELECT first_name, last_name, debut
FROM players
WHERE birth_city = 'Pittsburgh'
AND birth_state = 'PA'
ORDER BY debut DESC, first_name ASC, last_name ASC;


-------------------------------------------------------------------------------------------------------------------------------------
-- AGREGACIONES
-------------------------------------------------------------------------------------------------------------------------------------

-- Jugadores que batean y lanzan con manos diferentes
SELECT COUNT(id) AS 'players opposite hand'
FROM players
WHERE (bats = 'L' AND throws = 'R')
   OR (bats = 'R' AND throws = 'L');

-- bats != throws --> tomaría aquellas combinaciones donde una sea valor nulo y la otra no
-- NOTA: especificar combinaciones de bats y throws --> (L,R) , (R,L) 


---------------------------------------------------------------------------------------------------------------------------------------
-- ANÁLISIS AVANZADO
---------------------------------------------------------------------------------------------------------------------------------------

-- Jugadores más altos que el promedio 
SELECT birth_country, first_name, last_name, height
AS 'Taller than the average'
FROM players
WHERE height > (
       SELECT AVG(height)
       FROM players
       )
ORDER BY height DESC, first_name ASC, last_name ASC
LIMIT 10;
