-- Ejercicio 1
-- 1. Activar el esquema gestion_ventas.
SET search_path TO gestion_ventas, public;

-- 2. Consulta sobre empleados que genere ficha_empleado con el formato "[Puesto] - Nombre: [Nombre]" usando ||.
SELECT puesto || ' - Nombre: ' || nombre AS ficha_empleado 
FROM gestion_ventas.empleados;

-- 3. Consulta sobre clientes con CONCAT() que genere una etiqueta de envio: nombre, un guion y correo electronico.
SELECT CONCAT(nombre, ' - ', correo_electronico) AS etiqueta_envio 
FROM gestion_ventas.clientes;

-- 4. Probar el comportamiento ante valores nulos con un NULL explicito en ambas formas de concatenacion.
SELECT 'Telefono: ' || NULL AS resultado_operador;

SELECT CONCAT('Telefono: ', NULL, '9331630208') AS resultado_concat;

-- Ejercicio 2
-- 1. Consultar productos: nombre_producto, precio y longitud del nombre con LENGTH().
SELECT nombre_producto, precio, 
LENGTH(nombre_producto) AS longitud_nombre 
FROM gestion_ventas.productos;

-- 2. Reporte de clientes: correo en minusculas (LOWER()) y nombre completo en mayusculas (UPPER()).
SELECT UPPER(nombre), LOWER(correo_electronico) 
FROM gestion_ventas.clientes;

-- 3. Filtrar empleados cuyo puesto, convertido a mayusculas, coincida con 'ASESOR COMERCIAL'.
SELECT nombre, UPPER(puesto) as puestos 
FROM gestion_ventas.empleados 
WHERE UPPER(puesto) = 'ASESOR COMERCIAL';

-- Ejercicio 3
-- 1. Utilizar TRIM() para eliminar espacios en blanco al inicio o final.
SELECT TRIM(nombre) 
FROM gestion_ventas.empleados;

-- 2. Extraer los primeros 3 digitos (clave LADA) de los telefonos con SUBSTRING().
SELECT CONCAT('Lada: ', SUBSTRING(telefono FROM 1 FOR 3)) AS lasdas_clientes 
FROM gestion_ventas.clientes;

-- 3. Sustituir con REPLACE() 'Ergonomico' u 'Ergonomica' por 'Premium' en nombre_producto.
SELECT REPLACE(REPLACE(nombre_producto, 'Ergonómico', 'Premium'), 'Ergonómica', 'Premium') 
AS producto_remombrado 
FROM gestion_ventas.productos;

-- Ejercicio 4
-- 1. Campo correo_enmascarado: primeras 2 letras del correo, tres asteriscos y el dominio completo a partir de @.
SELECT CONCAT(
	SUBSTRING(correo_electronico FROM 1 FOR 2), 
	'***', 
	SUBSTRING(correo_electronico FROM POSITION('@' IN correo_electronico))) 
	AS correo_enmascarado 
FROM gestion_ventas.clientes;

-- 2. Campo codigo_sku: 3 primeros caracteres del nombre en mayusculas, guion, longitud del nombre, guion, ultimos 4 caracteres del id_producto como texto.
SELECT CONCAT(
	UPPER(SUBSTRING(nombre_producto FROM 1 FOR 3)), 
	'-', 
	LENGTH(nombre_producto), 
	'-', 
	SUBSTRING(id_producto::TEXT FROM LENGTH(id_producto::TEXT) -3)) 
	AS codigo_sku 
FROM gestion_ventas.productos;

-- Ejercicio 5
-- 1. Mostrar nombre original y la columna nombre_formato_expediente, aplicando REPLACE() para eliminar espacios dobles.
SELECT nombre, CONCAT(REPLACE(nombre, '  ', ' ')) AS nombre_formato_expediente 
FROM gestion_ventas.empleados;

-- 2. Extraer la primera palabra del nombre del empleado con SUBSTRING() junto con POSITION().
SELECT SUBSTRING(nombre FROM 1 FOR (LENGTH(nombre) - LENGTH(SUBSTRING(nombre FROM POSITION(' ' IN nombre))))) AS primer_nombre 
FROM gestion_ventas.empleados;

-- 3. Convertir el nombre al formato "Titulo" (primera letra en mayuscula y el resto en minusculas) con UPPER() y LOWER().
SELECT CONCAT(UPPER(SUBSTRING(nombre FROM 1 FOR 1)), 
	LOWER(SUBSTRING(nombre FROM 2 FOR (LENGTH(nombre) -1)))) AS Titulo 
FROM gestion_ventas.empleados;
