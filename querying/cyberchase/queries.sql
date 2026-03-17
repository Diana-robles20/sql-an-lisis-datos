-----------------------------------------
-- FILTROS BÁSICOS
-- =====================================

-- Episodios de la temporada 1
SELECT title
FROM episodes
WHERE season = 1;

-- Episodios que son el primero de cada temporada
SELECT title, season
FROM episodes
WHERE episode_in_season = 1;

-- Obtener production code de un episodio específico
SELECT production_code
FROM episodes
WHERE title = 'Hackerized!';

-- Episodios sin tema asignado
SELECT title
FROM episodes
WHERE topic IS NULL;

-- Episodios emitidos en una fecha específica
SELECT title
FROM episodes
WHERE air_date = '2004-12-31';

----------------------------------------
-- FILTROS POR FECHA
----------------------------------------

-- Episodios de la temporada 6 en 2007
SELECT title
FROM episodes
WHERE season = 6
AND air_date LIKE '2007%';

-- Número de episodios entre 2018 y 2023
SELECT COUNT(title) AS episodes_2018_2023
FROM episodes
WHERE air_date >= '2018-01-01'
AND air_date <= '2023-12-31';

-- Número de episodios entre 2002 y 2007
SELECT COUNT(title) AS episodes_2002_2007
FROM episodes
WHERE air_date >= '2002-01-01'
AND air_date <= '2007-12-31';


------------------------------------------
-- BÚSQUEDA DE TEXTO
-------------------------------------------
   
-- Episodios cuyo tema contiene "fraction"
SELECT title, topic
FROM episodes
WHERE topic LIKE '%raction%';

------------------------------------------
-- ORDENAMIENTO
------------------------------------------
  
-- Ordenar por production code
SELECT id, title, production_code
FROM episodes
ORDER BY production_code;

-- Episodios de temporada 5 ordenados descendentemente
SELECT title
FROM episodes
WHERE season = 5
ORDER BY title DESC;

-----------------------------------------------
-- AGREGACIONES
------------------------------------------------
-- Número de títulos únicos
SELECT COUNT(DISTINCT title) AS unique_episode_titles
FROM episodes;
