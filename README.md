# SQL Portfolio: Querying, Relating & Designing

## Objetivo
Aplicar SQL para explorar, analizar y estructurar datos en bases relacionales.

---

## Estructura del portafolio

## Querying
Consultas sobre múltiples datasets:

### Players

En este proyecto se utiliza una base de datos (`players.db`) con información de jugadores de la MLB (Major League Baseball) que han participado entre 1871 y 2023. La tabla `players` contiene datos históricos y físicos de los jugadores.

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
### DESE (Department of Elementary and Secondary Education) in Massachusetts 

Este dataset contiene información sobre el sistema educativo en Massachusetts, organizado a nivel de distritos y escuelas. Permite analizar relaciones entre desempeño académico, gasto educativo y evaluaciones del personal.

---

### Estructura de la base de datos

El sistema se organiza en torno a distritos escolares, que contienen múltiples escuelas y concentran información financiera y evaluaciones.

#### districts
Contiene información general de los distritos escolares.
- `id`: identificador del distrito  
- `name`: nombre del distrito  
- `type`: tipo de distrito (público o charter)  

---

#### schools
Representa las escuelas dentro de cada distrito.
- `id`: identificador de la escuela  
- `district_id`: distrito al que pertenece  
- `name`: nombre de la escuela  
- `type`: tipo de escuela  

---

#### graduation_rates
Contiene métricas de desempeño académico por escuela.
- `school_id`: escuela asociada  
- `graduated`: porcentaje de graduación  
- `dropped`: porcentaje de abandono escolar  

---

#### expenditures
Información financiera a nivel distrito.
- `district_id`: distrito asociado  
- `pupils`: número de estudiantes  
- `per_pupil_expenditure`: gasto por alumno  

---

#### staff_evaluations
Evaluación del personal educativo por distrito.
- `district_id`: distrito asociado  
- `exemplary`: porcentaje de desempeño ejemplar  
- `unsatisfactory`: porcentaje de desempeño insatisfactorio  

---

### Relaciones clave

- Un **distrito** contiene múltiples **escuelas**  
- Cada **escuela** reporta una métrica de **graduación**  
- Los **distritos** pueden no hacer **gasto** o múltiples y asimismo no recibir **evaluación del personal** o recibir múltiples  

---
### Moneyball

Este dataset contiene información sobre jugadores, equipos, desempeño y salarios en la MLB, permitiendo analizar la relación entre rendimiento deportivo y costo económico.

---

### Estructura de la base de datos

#### players
Contiene información básica de los jugadores.
- `id`: identificador del jugador  
- `first_name`: nombre  
- `last_name`: apellido  

---

#### teams
Información de los equipos.
- `id`: identificador del equipo  
- `name`: nombre del equipo  

---

#### performances
Registra el desempeño de los jugadores por equipo y año.
- `player_id`: jugador  
- `team_id`: equipo  
- `year`: año  
- `H`: número de hits  
- `HR`: número de home runs  

---

#### salaries
Información de salarios de los jugadores.
- `player_id`: jugador  
- `team_id`: equipo  
- `year`: año  
- `salary`: salario en dólares  

---

### Relaciones clave

- Un **jugador** genera múltiples **performances**  
- Cada **performance** está asociada a un **equipo**  
- Un **jugador** puede recibir múltiples **salarios** dependiendo del equipo y año  
- Los **equipos** pagan salarios a los jugadores  

---

### Habilidades demostradas

- Uso de SQL para análisis de datos relacionales, integrando información de múltiples tablas mediante JOINs y subconsultas  
- Capacidad para resolver problemas del mundo real a partir de datos (seguimiento de paquetes, análisis educativo y deportivo)  
- Aplicación de funciones de agregación y análisis por grupos (AVG, SUM, COUNT, GROUP BY, HAVING)  
- Uso de lógica analítica y secuencial para construir soluciones paso a paso  
- Manejo de datos incompletos o ambiguos mediante filtros y condiciones adecuadas  
- Desarrollo de métricas e indicadores para evaluar desempeño (ej. eficiencia, promedios, comparaciones)  
- Comprensión de modelos relacionales y relaciones entre entidades   

---

## Datasets

Bases de datos proporcionadas por curso de Harvard (CS50 Introduction to Databases with SQL).

---

## Cómo usar este proyecto

```bash
sqlite3 (nombre de la base de datos).db
.read queries.sql
