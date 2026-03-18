# SQL Portfolio: Querying, Relating & Designing

## Objetivo
Aplicar SQL para explorar, analizar y estructurar datos en bases relacionales.

---

## Estructura del portafolio

## Querying
Consultas sobre múltiples datasets:

### Cyberchase

Cyberchase es una serie animada educativa transmitida por el Public Broadcasting Service (PBS) desde 2002. Su objetivo es mostrar que las matemáticas están presentes en la vida cotidiana y que cualquier persona puede aprenderlas. A lo largo de los episodios, se abordan conceptos de matemáticas, ciencia y resolución de problemas.

En este proyecto se analiza la base de datos (`cyberchase.db`) que contiene información de los episodios en la tabla `episodes`.

#### Estructura de la tabla `episodes`

- `id`: identificador único de cada episodio  
- `season`: número de temporada en la que se emitió el episodio  
- `episode_in_season`: número del episodio dentro de su temporada  
- `title`: título del episodio  
- `topic`: tema o concepto que el episodio busca enseñar  
- `air_date`: fecha de emisión del episodio (formato YYYY-MM-DD)  
- `production_code`: identificador único utilizado internamente por PBS para cada episodio  

### Players

El béisbol es un deporte en el que dos equipos de 9 jugadores se turnan para batear y defender. El objetivo es anotar carreras (“runs”) al recorrer todas las bases antes de ser eliminado por el equipo contrario. Es especialmente popular en Estados Unidos y Canadá, donde la Major League Baseball (MLB) ha sido la principal liga profesional desde 1876.

En este proyecto se utiliza una base de datos (`players.db`) con información de jugadores de la MLB que han participado entre 1871 y 2023. La tabla `players` contiene datos históricos y físicos de los jugadores.

#### Estructura de la tabla `players`

- `id`: identificador único del jugador  
- `first_name`: nombre  
- `last_name`: apellido  
- `bats`: lado de bateo (R = derecha, L = izquierda)  
- `throws`: mano con la que lanza (R = derecha, L = izquierda)  
- `weight`: peso en libras  
- `height`: altura en pulgadas  
- `debut`: fecha en la que el jugador comenzó su carrera en MLB (YYYY-MM-DD)  
- `final_game`: fecha del último juego (YYYY-MM-DD)  
- `birth_year`: año de nacimiento  
- `birth_month`: mes de nacimiento  
- `birth_day`: día de nacimiento  
- `birth_city`: ciudad de nacimiento  
- `birth_state`: estado de nacimiento  
- `birth_country`: país de nacimiento  

---

### Habilidades demostradas

- Filtrado de datos (WHERE)
- Búsqueda con patrones (LIKE)
- Manejo de fechas
- Ordenamiento (ORDER BY)
- Agregaciones (COUNT, DISTINCT, AVG)
- Análisis estructurado de datos

---

## Relating

En esta sección se trabaja con relaciones entre tablas para resolver problemas más complejos mediante SQL.

### Packages, please
#### Contexto

Se simula un sistema de entrega de correo en la ciudad de Boston. Como responsable del seguimiento de paquetes, el objetivo es investigar casos de paquetes perdidos reportados por clientes.

Para cada caso, se busca determinar:
- La ubicación actual del paquete
- El tipo de ubicación (residencial, negocio, etc.)
- El contenido del paquete

### Estructura de la base de datos

La base de datos `packages.db` permite rastrear el movimiento de paquetes dentro de la ciudad mediante múltiples tablas relacionadas.

#### addresses
Contiene las direcciones registradas en el sistema.
- `id`: identificador único de la dirección  
- `address`: dirección física  
- `type`: tipo de ubicación (residencial, comercial, etc.)  

#### drivers
Contiene información de los conductores encargados de los envíos.
- `id`: identificador del conductor  
- `name`: nombre del conductor  

#### packages
Contiene la información general de los paquetes.
- `id`: identificador del paquete  
- `contents`: contenido del paquete  
- `from_address_id`: dirección de origen  
- `to_address_id`: dirección de destino (no necesariamente la ubicación final)  

#### scans
Registra el historial de seguimiento de cada paquete.
- `id`: identificador del registro  
- `driver_id`: conductor que realizó el escaneo  
- `package_id`: paquete escaneado  
- `address_id`: ubicación del escaneo  
- `action`: acción realizada (“Pick” o “Drop”)  
- `timestamp`: fecha y hora del evento  

---
### Relaciones entre entidades

- Un **driver** puede realizar múltiples **scans**, pero cada scan es realizado por un solo driver.

- Cada **scan** está asociado a un único **package**, mientras que un package puede tener múltiples scans a lo largo de su recorrido.

- Cada **scan** ocurre en una **address**, mientras que en una **address** se hacen varios **scan**

- Cada **package** tiene una dirección de origen (`from_address_id`) y una dirección de destino (`to_address_id`), ambas referenciando a la entidad **addresses**.

Estas relaciones permiten reconstruir el recorrido completo de un paquete desde su origen hasta su ubicación actual.


### Casos de análisis

---

#### Caso 1: Carta extraviada

Se analiza el envío de una carta de felicitaciones desde la dirección *900 Somerville Avenue* hacia *2 Finnegan Street*.  
El objetivo es determinar si la carta fue entregada correctamente y localizar su estado actual dentro del sistema.

El objetivo es:
- Determinar el tipo de domicilio en el que la carta fue entregada
- La dirección donde fue entregada

---

#### Caso 2: Entrega sin remitente

Se investiga un paquete sin dirección de origen registrada, cuyo contenido corresponde a un objeto recreativo (juguete de baño).

Este caso requiere:
- Determinar el tipo de domicilio donde el paquete fue entregado
- El contenido del paquete

---

#### Caso 3: Regalo no entregado

Se analiza un paquete enviado desde *109 Tileston Street* hacia *728 Maple Place*, cuya entrega presenta retraso.

El objetivo es rastrear el paquete y determinar su estado actual dentro del sistema de entregas.

Este caso requiere:
- Determinar el contenido del regalo
- Quién lo recibió
  
---

## Datasets

Bases de datos proporcionadas por curso de Harvard (CS50 Introduction to Databases with SQL).

---

## Cómo usar este proyecto

```bash
sqlite3 (nombre de la base de datos).db
.read queries.sql
