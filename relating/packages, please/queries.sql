------------------------------------------------------------------------------------------------------------------
-- RELATING: ANÁLISIS DE PAQUETES
------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------
-- CASO 1: LA CARTA PERDIDA
------------------------------------------------------------------------------------------------------------------
-- ¿En qué tipo de dirección terminó la carta perdida?

-- Enfoque:
-- 1. Obtener el id de la dirección de origen
-- 2. Obtener el id del paquete asociado
--    - Puede haber múltiples paquetes, se filtra por contenido
-- 3. Obtener el último escaneo del paquete (timestamp DESC)
-- 4. Obtener el tipo de la dirección final

SELECT "type" FROM "addresses" WHERE "id" = (
  SELECT "address_id" FROM "scans" WHERE "package_id" = (
    SELECT "id" FROM "packages" WHERE "from_address_id" = (
      SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue')
      AND "contents" LIKE '%ongratulatory%'
  )
  ORDER BY "timestamp" DESC LIMIT 1
);

-- Resultado:
-- Tipo de dirección: residential


-- Pregunta:
-- ¿En qué dirección terminó la carta perdida?: 

-- Enfoque:
-- Misma lógica anterior, cambiando "type" por "address"

SELECT "address" FROM "addresses" WHERE "id" = (
  SELECT "address_id" FROM "scans" WHERE "package_id" = (
    SELECT "id" FROM "packages" WHERE "from_address_id" = (
      SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue')
      AND "contents" LIKE '%ongratulatory'
  )
  ORDER BY "timestamp" DESC LIMIT 1
);

-- Resultado:
-- Dirección final: 2 Finnigan Street

------------------------------------------------------------------------------------------------------------------
-- CASO 2: LA ENTREGA ENGAÑOSA
------------------------------------------------------------------------------------------------------------------

-- Pregunta:
-- ¿En qué tipo de dirección terminó la entrega?:

-- Enfoque:
-- 1. Identificar paquete sin dirección de origen (from_address_id IS NULL)
-- 2. Podrían haber múltiples paquetes sin dirección , filtrar por contenido 
-- 3. Obtener el último escaneo del paquete
-- 4. Obtener el tipo de dirección

SELECT "type" FROM "addresses" WHERE "id" = (
  SELECT "address_id" FROM "scans" WHERE "package_id" = (
    SELECT "id" FROM "packages" 
    WHERE "from_address_id" IS NULL 
    AND "contents" LIKE '%uck%'
  )
  ORDER BY "timestamp" DESC LIMIT 1
);

-- Resultado:
-- Tipo de dirección: Police Station


--  Pregunta:
-- ¿Cuál era el contenido de la entrega engañosa?: 

SELECT "contents" FROM "packages" 
WHERE "from_address_id" IS NULL 
AND "contents" LIKE '%uck%';

-- Resultado:
-- Contenido: Duck debugger



--------------------------------------------------------------------------------------------------------------
-- CASO 3: EL REGALO OLVIDADO
--------------------------------------------------------------------------------------------------------------

-- Pregunta:
-- ¿Cuál es el contenido del regalo olvidado?:

-- Enfoque:
-- 1. Filtrar por dirección de origen
-- 2. Pueden haberse enviado múltiples paquetes desde el mismo origen, filtrar por dirección de destino 

SELECT "contents" FROM "packages" WHERE "from_address_id" = (
  SELECT "id" FROM "addresses" WHERE "address" = '109 Tileston Street'
)
AND "to_address_id" = (
  SELECT "id" FROM "addresses" WHERE "address" = '728 Maple Place'
);

-- Resultado:
-- Contenido: Flowers


-- Pregunta:
-- ¿Quién tiene el regalo olvidado?

-- Enfoque:
-- 1. Identificar el paquete con origen y destino específicos
-- 2. Obtener el último escaneo del paquete (timestamp DESC)
-- 3. Identificar el driver asociado

SELECT "name" FROM "drivers" WHERE "id" = (
  SELECT "driver_id" FROM "scans" WHERE "package_id" = (
    SELECT "id" FROM "packages" WHERE "from_address_id" = (
      SELECT "id" FROM "addresses" WHERE "address" = '109 Tileston Street'
    )
    AND "to_address_id" = (
      SELECT "id" FROM "addresses" WHERE "address" = '728 Maple Place'
    )
  )
  ORDER BY "timestamp" DESC LIMIT 1
);

-- Resultado:
-- Driver responsable: Mikel

