create database db_practica9;
use db_practica9;

create table Empleado (
  emp_id int ,
  emp_nombre VARCHAR(255),
  emp_edad int
);

create table Proyecto (
  pro_idl int ,
  pro_descripcion VARCHAR(255)
);

create table Asignacion (
  asi_id int AUTO_INCREMENT PRIMARY key,db_practica9
  emp_id int,
  pro_id INT,
  asi_fecha DATETIME,
  asi_cant_horas double
);

insert INTO Empleado  VALUES (1,'Lucas',40);
insert INTO Empleado  VALUES (2,'Nahuel',25);
insert INTO Empleado  VALUES (3,'Micaela',32);
insert INTO Empleado  VALUES (4,'Julian',55);
insert INTO Empleado  VALUES (5,'Laura',34);

insert INTO Proyecto  VALUES (1,'Harbor');
insert INTO Proyecto  VALUES (2,'Narciso');
insert INTO Proyecto  VALUES (3,'Elinium');
insert INTO Proyecto  VALUES (4,'Varader');

/*3.Crear una tabla temporal SEMANA_COMPLETA, que tenga una fila por día de una semana laboral a elección. Queda a criterio del alumno la definición 
de las columnas que necesite.Se espera que tenga 5 filas que contengan como mínimo la fecha de cada día de una semana.*/

CREATE temporary TABLE semana_completa (
dias INT,
fecha DATE);

INSERT INTO semana_completa (dias) VALUES (1),(2),(3),(4),(5);

UPDATE semana_completa SET fecha = DATE_ADD(NOW(), INTERVAL dias DAY);

#4.Insertar para 2 proyectos y para 3 empleados, asignaciones de 4 horas durante la semana representada en el punto 3

INSERT INTO Asignacion (emp_id, pro_id, asi_fecha, asi_cant_horas)
SELECT e.emp_id, p.pro_idl, sc.fecha, 4
FROM Empleado e, Proyecto p, Semana_completa sc
WHERE e.emp_id IN (1, 2, 3)
  AND p.pro_idl IN (1, 2)
  AND sc.fecha IN (SELECT fecha FROM Semana_completa);


#5.Insertar para los 2 proyectos restantes y los 2 empleados restantes asignaciones de 4 horas durante la semana representada en el punto 3.

INSERT INTO Asignacion (emp_id, pro_id, asi_fecha, asi_cant_horas)
SELECT e.emp_id, p.pro_idl, sc.fecha, 4
FROM Empleado e, Proyecto p, Semana_completa sc
WHERE e.emp_id IN (4, 5)
AND p.pro_idl IN (3, 4)
AND sc.fecha IN (SELECT fecha FROM Semana_completa);

#6.Determinar por medio de una consulta cuáles son los proyectos en los cuales trabajaron más de dos empleados
SELECT a.pro_id,COUNT(DISTINCT emp_id) AS id_empleado FROM asignacion a
GROUP BY a.pro_id
HAVING COUNT(DISTINCT emp_id)> 2 ;

/*7.Crear una tabla RESUMEN_PROYECTO, con esquema < pro_id: int, pro_descripcion: varchar(255), 
horas_totales:double, cantidad_empleados: INT >,
y lograr que contenga por cada fila a cada proyecto, la cantidad total de horas trabajadas para tal proyecto y 
la cantidad de empleados involucrados en el mismo.*/
CREATE TABLE RESUMEN_PROYECTO( 
pro_id int ,
pro_descripcion VARCHAR(255),
horas_totales DOUBLE,
cantidad_empleados int
);
INSERT INTO RESUMEN_PROYECTO (pro_id ,pro_descripcion,horas_totales,cantidad_empleados) 
SELECT pro_id,pro_descripcion,SUM(a.asi_cant_horas),COUNT(DISTINCT a.emp_id) FROM asignacion a INNER JOIN proyecto p ON a.pro_id = p.pro_idl
GROUP BY pro_id;


#8.Generar una consulta SQL para obtener los empleados que no estén asignados a ningún proyecto
SELECT e.emp_id FROM empleado e WHERE NOT EXISTS (SELECT a.pro_id FROM asignacion a where e.emp_id=a.emp_id );
