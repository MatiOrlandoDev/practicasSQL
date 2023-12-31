create database db_practica10;
use db_practica10;

create table ciudad (
  id_ciudad INT PRIMARY KEY,
  nombre VARCHAR(50),
  estado CHAR(2),
  pais CHAR(2) ,
FOREIGN KEY(pais) REFERENCES pais(id_pais)
);

create table propiedad (
  id_propiedad INT PRIMARY key,
  nombre VARCHAR(255),
  ciudad INT ,
  descripcion VARCHAR(255),
  estrellas INT ,
FOREIGN KEY(ciudad) REFERENCES ciudad(id_ciudad)
);

create table pais (
 id_pais CHAR(2) PRIMARY KEY,
 nombre VARCHAR(70),
 codigo_telefonico CHAR(3)
);

create table estado (
 id_estado CHAR(2) PRIMARY KEY,
 nombre VARCHAR(100) 
);

/*2. Insertar 3 países, 2 ciudades y 1 estado. Luego, insertar 5 propiedades. Una de
las ciudades debe tener estado definido, la otra, no.*/

insert INTO pais  VALUES (1,'Uganda',69);
insert INTO pais  VALUES (2,'Polonia',37);
insert INTO pais  VALUES (3,'Macedonia',21);

insert INTO ciudad  VALUES (1,'Buenos Aires',1,1);
insert INTO ciudad  VALUES (2,'Bogota',2,2);
UPDATE ciudad SET nombre = NULL WHERE nombre ='bogota'                                                                                                              

insert INTO estado  VALUES (1,'Texas');

insert INTO propiedad  VALUES (1,'Casa Verano',1,'Casa para verano',4);
insert INTO propiedad  VALUES (2,'Casa invierno',2,'Casa para invierno',4);
insert INTO propiedad  VALUES (3,'Casa otoño',1,'Casa para otoño',5);
insert INTO propiedad  VALUES (4,'Casa primavera',2,'Casa para primavera',3);
insert INTO propiedad  VALUES (5,'Casa simple',1,'Casa muy simple',2);

/*3. Crear una vista, ciudad_recomendada, que muestre:
a. id de ciudad
b. nombre de ciudad,
c. nombre de estado o la cadena “SIN ESTADO”, en caso de que no lo tenga
d. cantidad de propiedades en esa ciudad*/

CREATE VIEW ciudad_recomendada AS SELECT c.id_ciudad AS CiudadId, c.nombre AS CiudadNombre,  
CASE WHEN e.nombre IS NULL THEN 'SIN ESTADO' ELSE e.nombre END AS EstadoNombre, COUNT(p.id_propiedad) AS CantidadPropiedades 
FROM ciudad c LEFT JOIN estado e ON c.estado = e.id_estado LEFT JOIN Propiedad p ON c.id_ciudad = p.Ciudad GROUP BY c.id_ciudad, c.nombre, e.nombre;

#4. Agregar a la tabla propiedad la columna aeropuerto_cercano de tipo char(3)

ALTER TABLE propiedad add COLUMN aeropuerto_cercano CHAR(3);

/*5. Crear:
a. una tabla Facilidad con campos
i. id int
ii. descripcion varchar(50)
b. una tabla propiedad_facilidad con campos:
i. id int autonumerico
ii. id_facilidad int
iii. id_propiedad int
Insertar 5 facilidades y filas en propiedad_facilidad para todas las propiedades y
facilidades*/

create table facilidad (
  id INT PRIMARY KEY,
  descripcion VARCHAR(50)
);
create table propiedad_facilidad (
  id INT PRIMARY KEY auto_increment ,
  id_facilidad int,
  id_propiedad INT
);

insert INTO facilidad VALUES (1,'bastante facil');
insert INTO facilidad VALUES (2,'muy facil');
insert INTO facilidad VALUES (3,'realmente facil');
insert INTO facilidad VALUES (4,'sorpresivamente facil');
insert INTO facilidad VALUES (5,'abismalmente facil');

INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad)
SELECT f.id ,p.id_propiedad FROM facilidad f, propiedad p;

#6. Agregar foreign keys que relacionen a propiedad_facilidad con las dos tablas con las que se relaciona

ALTER TABLE propiedad_facilidad
ADD CONSTRAINT  fk_facilidad FOREIGN KEY (id_facilidad) REFERENCES facilidad(id);

ALTER TABLE propiedad_facilidad
ADD CONSTRAINT  fk_propiedad FOREIGN KEY (id_propiedad) REFERENCES propiedad(id_propiedad);

#7. Crear una vista con el id de propiedad y el nombre de propiedad, para aquellas que tengan todas las facilidades asignadas

CREATE VIEW idynombre_propiedad AS
SELECT p.id_propiedad,p.nombre FROM propiedad p WHERE EXISTS(SELECT * FROM facilidad f WHERE p.id_propiedad = f.id);

#8. Eliminar la columna estrellas de la tabla propiedad

ALTER TABLE propiedad DROP COLUMN estrellas;

/*9. Agregar a la tabla propiedad la columna fecha_inauguración de tipo DATETIME.
 Asignar a todas las filas el valor de fecha una semana posterior a la actual*/
 
ALTER TABLE propiedad add COLUMN fecha_inauguracion DATETIME;
UPDATE propiedad SET fecha_inauguracion = DATE_ADD(NOW(), INTERVAL 1 WEEK);
