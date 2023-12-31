CREATE DATABASE practica_8vfinal;
#1)
CREATE TABLE nombres (
nombre VARCHAR (30))

INSERT INTO nombres (nombre) VALUES ('Matias');
INSERT INTO nombres (nombre) VALUES ('Lorenzo');
INSERT INTO nombres (nombre) VALUES ('Paula');
INSERT INTO nombres (nombre) VALUES ('Toby');
INSERT INTO nombres (nombre) VALUES ('Psicodelic');
INSERT INTO nombres (nombre) VALUES ('Ana');
INSERT INTO nombres (nombre) VALUES ('Raul');
INSERT INTO nombres (nombre) VALUES ('Nestor');

#2)
CREATE TABLE Apellidos (
apellido VARCHAR (30))

INSERT INTO Apellidos (apellido) VALUES ('Orlando');
INSERT INTO Apellidos (apellido) VALUES ('Miyasaki');
INSERT INTO Apellidos (apellido) VALUES ('Motto');
INSERT INTO Apellidos (apellido) VALUES ('Miyamoto');
INSERT INTO Apellidos (apellido) VALUES ('Rodriguez');
INSERT INTO Apellidos (apellido) VALUES ('Alonso');
INSERT INTO Apellidos (apellido) VALUES ('Lombardo');
INSERT INTO Apellidos (apellido) VALUES ('Perez');
INSERT INTO Apellidos (apellido) VALUES ('Zilli');
INSERT INTO Apellidos (apellido) VALUES ('Papparo');

#3)
CREATE TABLE materias (
id INT NOT NULL PRIMARY KEY,
descripcion VARCHAR (30));

ALTER table materias MODIFY COLUMN id int AUTO_INCREMENT;

INSERT INTO materias (id, descripcion) VALUES (1, 'Programacion');
INSERT INTO materias (id, descripcion) VALUES (2, 'DOO');
INSERT INTO materias (id, descripcion) VALUES (3, 'Base de datos');
INSERT INTO materias (id, descripcion) VALUES (4, 'Orga');

#4)Crear una tabla alumnos con el esquema "NombreYApellido" poblándola con todas las combinaciones de nombres y apellidos. Deberán generarse 80 alumnos.
CREATE TABLE alumnos (
NombreYApellido VARCHAR (50))

#Nuevo codigo
INSERT INTO alumnos (NombreYApellido) SELECT CONCAT(n.nombre,' ',a.apellido) AS NombreYApellido FROM nombres n,  apellidos a;

#5) Crear una tabla exámenes con el esquema "Nombre", "Materia", "Nota"
#La nota puede calcularse con el id de la materia, la cantidad de letras (length) del nombre, y un cálculo que termine (........)%10 +1 (de modo que vaya de 1 a 10)
#Todos los alumnos rindieron exámenes para todas las materias
   
CREATE TABLE examenes (
Nombre VARCHAR (50) NOT null,
materia VARCHAR (30) NOT null,
Nota INT NOT NULL);

#Modificacion
INSERT INTO examenes (Nombre, materia, Nota)
SELECT alumnos.NombreYApellido, materias.descripcion, (LENGTH(alumnos.NombreYApellido) * materias.id % 10 + 1)
FROM alumnos, materias;

#6) Modificar la tabla de alumnos para que tenga una columna "Estado", alfanumérica

ALTER TABLE alumnos ADD Estado VARCHAR (30);

#7) Para los alumnos que tengan algún aplazo, dejarle "Con Aplazo" en la columna "Estado"

UPDATE alumnos SET Estado = 'Con Aplazo' WHERE NombreYAPellido IN (SELECT Distinct Nombre FROM examenes WHERE Nota < 4)


#8)Agregar columna Descripción en la tabla de exámenes

ALTER TABLE examenes ADD Descripcion VARCHAR (30);

#9) Generar filas sin nota en exámenes para los alumnos/materias con aplazos, con descripción recuperatorio

UPDATE examenes
SET Descripcion = 'Recuperatorio'
WHERE Nota < 4;
