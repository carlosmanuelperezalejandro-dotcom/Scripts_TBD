-- Ejercicio 1
-- 1. Crear las tablas en PostgreSQL y definir sus claves primarias y foraneas.
CREATE TABLE autores (
id_autor INTEGER PRIMARY KEY,
nombre_autor VARCHAR(100),
estatus VARCHAR(15));

CREATE TABLE libros (
id_libro INTEGER PRIMARY KEY,
titulo VARCHAR(150),
id_autor INTEGER,
disponibilidad VARCHAR(15),
FOREIGN KEY (id_autor) REFERENCES autores(id_autor));

-- 2. Insertar los datos de prueba.
INSERT INTO autores (id_autor, nombre_autor, estatus) VALUES
(1, 'Gabriel García Márquez', 'Activo'),
(2, 'Isabel Allende', 'Activo'),
(3, 'Julio Alvarez', 'Activo'),
(4, 'Elena Flores', 'Activo'),
(5, 'Carlos Perez', 'Inactivo');

INSERT INTO libros (id_libro, titulo, id_autor, disponibilidad) VALUES
(101, 'Cien años de soledad', 1, 'Disponible'),
(102, 'El amor en los tiempos del cólera', 1, 'Prestado'),
(103, 'La casa de los espíritus', 2, 'Disponible'),
(104, 'Veinte mil leguas de viaje submarino', 3, 'Prestado'),
(105, 'Libro sin autor asignado', NULL, 'Disponible');

-- 3. Crear una consulta con INNER JOIN que muestre el titulo de cada libro y su autor.
SELECT l.titulo AS Titulo, a.nombre_autor AS Autor
FROM libros AS l
INNER JOIN autores AS a ON l.id_autor = a.id_autor;

-- 4. Crear una consulta con LEFT JOIN que identifique los libros sin autor asignado.
SELECT l.titulo AS Titulo, a.nombre_autor AS Autor
FROM libros AS l
LEFT JOIN autores AS a ON l.id_autor = a.id_autor;

-- 5. Utilizar RIGHT JOIN o una consulta equivalente con LEFT JOIN para identificar autores sin libros registrados.
SELECT a.id_autor, a.nombre_autor AS Autor_sin_libros_registrados
FROM autores AS a
LEFT JOIN libros AS l ON a.id_autor = l.id_autor
WHERE l.id_autor IS NULL;

-- 6. Construir una consulta con GROUP BY y COUNT() para contar los libros disponibles por autor.
SELECT a.id_autor, a.nombre_autor AS autor, COUNT(l.id_libro) AS libros_disponibles
FROM autores AS a
LEFT JOIN libros AS l ON a.id_autor = l.id_autor
WHERE l.disponibilidad = 'Disponible'
GROUP BY a.id_autor, a.nombre_autor
ORDER BY libros_disponibles DESC;

-- 7. Generar un reporte general con FULL OUTER JOIN.
SELECT a.id_autor, a.nombre_autor, a.estatus,
l.id_libro, l.titulo, l.disponibilidad
FROM autores AS a
FULL JOIN libros AS l ON a.id_autor = l.id_autor;

-- Ejercicio 2
-- 1. Crear las tablas con sus respectivas claves.
CREATE TABLE proveedores (
id_proveedor INTEGER PRIMARY KEY,
nombre_proveedor VARCHAR(100),
estatus VARCHAR(15));

CREATE TABLE productos (
id_producto INTEGER PRIMARY KEY,
nombre_producto VARCHAR(100),
id_proveedor INTEGER,
estatus_producto VARCHAR(15),
FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor));

-- 2. Insertar los datos de prueba.
INSERT INTO proveedores (id_proveedor, nombre_proveedor, estatus) VALUES
(1, 'Tecnología del Sureste', 'Activo'),
(2, 'Distribuidora Industrial', 'Activo'),
(3, 'Suministros del Golfo', 'Activo'),
(4, 'Electrónica Integral', 'Inactivo'),
(5, 'Soluciones Empresariales', 'Activo');

INSERT INTO productos (id_producto, nombre_producto, id_proveedor, estatus_producto) VALUES
(201, 'Computadora portátil', 1, 'Activo'),
(202, 'Monitor de 24 pulgadas', 1, 'Activo'),
(203, 'Cable de red', 2, 'Activo'),
(204, 'Conector RJ45', 2, 'Inactivo'),
(205, 'Sensor industrial', 3, 'Activo'),
(206, 'Producto sin proveedor', NULL, 'Activo'),
(207, 'Tarjeta electrónica', 4, 'Inactivo');

-- 3. Utilizar INNER JOIN para generar un catalogo de productos con su proveedor.
SELECT p.id_producto, p.nombre_producto,
pv.nombre_proveedor
FROM productos as p
INNER JOIN proveedores AS pv ON p.id_proveedor = pv.id_proveedor;

-- 4. Utilizar LEFT JOIN para identificar productos sin proveedor asignado.
SELECT p.id_producto, p.nombre_producto,
pv.nombre_proveedor
FROM productos as p
LEFT JOIN proveedores AS pv ON p.id_proveedor = pv.id_proveedor
WHERE p.id_proveedor IS NULL;

-- 5. Utilizar LEFT JOIN o RIGHT JOIN para identificar proveedores sin productos activos.
SELECT pv.id_proveedor,
pv.nombre_proveedor AS Proveedor_sin_productos_activos
FROM proveedores AS pv
LEFT JOIN productos AS p ON pv.id_proveedor = p.id_proveedor
WHERE p.estatus_producto = 'Inactivo';

-- 6. Crear un reporte con GROUP BY y COUNT() que contabilice los productos activos por proveedor.
SELECT pv.id_proveedor, pv.nombre_proveedor,
COUNT(p.id_producto) AS productos_activos
FROM proveedores AS pv
LEFT JOIN productos AS p ON pv.id_proveedor = p.id_proveedor
WHERE p.estatus_producto = 'Activo'
GROUP BY
pv.id_proveedor, pv.nombre_proveedor
ORDER BY productos_activos DESC;

-- 7. Utilizar FULL OUTER JOIN para presentar los productos y proveedores coincidentes y no coincidentes.
SELECT pv.id_proveedor, pv.nombre_proveedor, p.id_producto,
p.nombre_producto, p.estatus_producto
FROM proveedores AS pv
FULL OUTER JOIN productos AS p ON pv.id_proveedor = p.id_proveedor;

-- Ejercicio 3
-- 1. Crear las tablas y definir las claves primarias y foraneas.
CREATE TABLE instructores (id_instructor INTEGER PRIMARY KEY, nombre_instructor VARCHAR(100), especialidad VARCHAR(100), estatus VARCHAR(15));

CREATE TABLE cursos (id_curso INTEGER PRIMARY KEY, nombre_curso VARCHAR(100), id_instructor INTEGER, estatus_curso VARCHAR(15), FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor));

-- 2. Insertar los datos de prueba.
INSERT INTO instructores (id_instructor,nombre_instructor,especialidad,estatus) VALUES (1,'Ana Martínez','Bases de datos','Activo'),(2,'Luis Hernández','Redes de computadoras','Activo'),(3,'Patricia Gómez','Ciberseguridad','Activo'),(4,'Roberto Sánchez','Desarrollo de software','Inactivo'),(5,'Laura Pérez','Inteligencia artificial','Activo');

INSERT INTO cursos (id_curso,nombre_curso,id_instructor,estatus_curso) VALUES (301,'PostgreSQL básico',1,'Activo'),(302,'Administración de bases de datos',1,'Activo'),(303,'Enrutamiento y conmutación',2,'Activo'),(304,'Seguridad de redes',3,'Inactivo'),(305,'Curso sin instructor',NULL,'Activo'),(306,'Programación orientada a objetos',4,'Inactivo');

-- 3. Construir una consulta con INNER JOIN para mostrar los cursos con sus instructores.
SELECT c.id_curso, c.nombre_curso,
i.nombre_instructor, i.especialidad, c.estatus_curso
FROM cursos AS c
INNER JOIN instructores AS i ON c.id_instructor = i.id_instructor;

-- 4. Utilizar LEFT JOIN para identificar cursos sin instructor asignado.
SELECT c.id_curso, c.nombre_curso, c.estatus_curso
FROM cursos AS c
LEFT JOIN instructores AS i ON c.id_instructor = i.id_instructor
WHERE i.id_instructor IS NULL;

-- 5. Identificar instructores que no imparten cursos activos.
SELECT i.id_instructor, i.nombre_instructor, i.especialidad
FROM instructores AS i
LEFT JOIN cursos AS c ON i.id_instructor = c.id_instructor
WHERE c.estatus_curso = 'Inactivo';

-- 6. Utilizar GROUP BY y COUNT() para contar los cursos activos por instructor.
SELECT i.id_instructor, i.nombre_instructor,
COUNT(c.id_curso) AS cursos_activos
FROM instructores AS i
LEFT JOIN cursos AS c ON i.id_instructor = c.id_instructor
WHERE c.estatus_curso = 'Activo'
GROUP BY i.id_instructor, i.nombre_instructor
ORDER BY cursos_activos DESC;

-- 7. Crear una consulta con FULL OUTER JOIN para auditar las relaciones entre instructores y cursos.
SELECT i.id_instructor, i.nombre_instructor, i.especialidad,
c.id_curso, c.nombre_curso, c.estatus_curso
FROM instructores AS i
FULL OUTER JOIN cursos AS c ON i.id_instructor = c.id_instructor;
