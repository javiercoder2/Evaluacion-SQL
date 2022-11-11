CREATE SCHEMA IF NOT EXISTS evaluacion_sql; #Creamos esquema nuevo

CREATE TABLE `evaluacion_sql`. `productos`(			#creamos la primera tabla de productos
`productos_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(20) NOT NULL,
`codigo` INT NOT NULL,
`precio_Venta` INT NOT NULL,
`precio_Compra` INT NOT NULL,
PRIMARY KEY (`productos_id`));

CREATE TABLE `evaluacion_sql`. `tipo_Productos`(			#creamos la segunda tabla de tipo productos 
`tipo_productos_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(20) NOT NULL,
`categoria`  VARCHAR(20) NOT NULL,
PRIMARY KEY (`tipo_productos_id`));

#creamos la primera tabla de proveedores
CREATE TABLE `evaluacion_sql`. `proveedores`(			
`proveedores_id` INT NOT NULL AUTO_INCREMENT,
`nombre`  VARCHAR(20) NOT NULL,
`direccion`  VARCHAR(20) NOT NULL,
`rut`  VARCHAR(20) NOT NULL,
PRIMARY KEY (`proveedores_id`));
## Creamos dos registros para asi obtener de mejor forma las ganancias anuales con un ejercicio sencillo de resta entre ambas

CREATE TABLE `evaluacion_sQL`. `registro_Compras`(			#creamos la primera tabla de registro de compras 
`registro_Compras_id` INT NOT NULL AUTO_INCREMENT,
`precio_Compra`  int NOT NULL,
`fecha_Transaccion_Compra` datetime,
PRIMARY KEY (`registro_Compras_id`));

CREATE TABLE `evaluacion_Sql`. `registro_Ventas`(			#creamos la primera tabla de registro de ventas
`registro_Ventas_id` INT NOT NULL AUTO_INCREMENT,
`precio_Compra` int NOT NULL,
`fecha_Transaccion_Ventas` datetime NOT NULL,
PRIMARY KEY (`registro_Ventas_id`));
####################Terminamos Creacion de Tablas#####################
drop table evaluacion_sql.registro_Ventas; 
delete from evaluacion_sql; ## Se tuvo que borrar tabla debido a errores de duplicacion

#Debemos añadir las FK ahora a las tablas correspondientes acorde al diagrama realizado

ALTER TABLE evaluacion_sql.proveedores ADD CONSTRAINT tipoProductosProveedor FOREIGN KEY (tipo_productos_id) REFERENCES evaluacion_sql.tipo_Productos(tipo_productos_id);
ALTER TABLE evaluacion_sql.productos ADD CONSTRAINT tipoProductoVenta FOREIGN KEY (tipo_productos_id) REFERENCES evaluacion_sql.tipo_Productos(tipo_productos_id);
ALTER TABLE evaluacion_sql.productos ADD CONSTRAINT proveedorProducto FOREIGN KEY (proveedores_id) REFERENCES evaluacion_sql.proveedores(proveedores_id);
###Error cometido en atributo###

ALTER TABLE evaluacion_sql.registro_ventas CHANGE COLUMN fecha_Transaccion_Compra fecha_Transaccion_Ventas datetime;
ALTER TABLE evaluacion_sql.registro_ventas CHANGE COLUMN precio_Compra precio_Venta int not null;



INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('papas fritas', 0001, 500,200);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('agua Mineral', 0002, 1000,600);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Jamon Serrano', 0003, 1500,1000);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Detergente 1kg', 0004, 2500,1200);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Helado Sahne Nuss', 0005, 3500,2000);


INSERT INTO evaluacion_sql.tipo_productos (nombre, categoria) VALUES ('Legumbres', 'Congelados');
INSERT INTO evaluacion_sql.tipo_productos (nombre, categoria) VALUES ('Legumbres', 'Granel');
INSERT INTO evaluacion_sql.tipo_productos (nombre, categoria) VALUES ('Carne', 'Al vacio');
INSERT INTO evaluacion_sql.tipo_productos (nombre, categoria) VALUES ('Verduras', 'Congelados');
############Creamos valores para los registros y asi tener un registro total de ganancia###################
INSERT INTO evaluacion_sql.registro_Compras (registro_Compras_id, fecha_Transaccion_Compra) VALUES (1, '2022-09-03');
INSERT INTO evaluacion_sql.registro_compras (registro_Compras_id, fecha_Transaccion_Compra) VALUES (2, '2022-10-03');
INSERT INTO evaluacion_sql.registro_compras (registro_Compras_id, fecha_Transaccion_Compra) VALUES (3, '2022-08-03');

INSERT INTO evaluacion_sql.registro_Ventas (registro_Ventas_id, precio_Venta, fecha_Transaccion_Ventas) VALUES (1, 500,'2022-10-03');
INSERT INTO evaluacion_sql.registro_Ventas (registro_Ventas_id, precio_Venta,fecha_Transaccion_Ventas) VALUES (2, 1000 ,'2022-11-03');
INSERT INTO evaluacion_sql.registro_Ventas (registro_Ventas_id, precio_Venta,fecha_Transaccion_Ventas) VALUES (3, 1500 ,'2022-11-10');


###############Se terminan de agregar datos####################

INSERT INTO evaluacion_sql.tipo_productos (nombre, categoria) VALUES ('Carne', 'Al vacio')
ON duplicate key update categoria = 'Congelados';

##Vamos probando como va todo
SELECT * FROM evaluacion_sql.productos;
SELECT * FROM evaluacion_sql.tipo_productos;

######Debemos subir el precio de las papas fritas por error de precio venta muy bajo#############
UPDATE evaluacion_sql.productos
SET precio_Venta = 1000
WHERE nombre = 'papas fritas';


########################################################################
#TABLA1 = cliente, TABLA2 = historial

SELECT productos.nombre, productos.codigo, productos.precio_Venta,productos.precio_Compra, tipo_Productos.categoria
FROM evaluacion_sql.productos
RIGHT JOIN evaluacion_sql.tipo_Productos on evaluacion_sql.productos.productos_id = evaluacion_sql.productos.productos_id;


##Traemos datos de las tablas en sentido contrario (2 a 1)
SELECT productos.nombre, productos.codigo, productos.precio_Venta,productos.precio_Compra, tipo_Productos.categoria
FROM evaluacion_sql.productos
LEFT JOIN evaluacion_sql.tipo_Productos on evaluacion_sql.productos.productos_id = evaluacion_sql.productos.productos_id;

#####Traemos la informacion de 3 tablas 
##Traemos datos de las tablas en sentido contrario (2 a 1)

SELECT productos.nombre, productos.codigo, productos.precio_Venta,productos.precio_Compra, fecha_Transaccion_Ventas
FROM evaluacion_sql.productos
INNER JOIN evaluacion_sql.registro_ventas on evaluacion_sql.productos.productos_id = evaluacion_sql.productos.productos_id;

SELECT productos.nombre, productos.codigo, productos.precio_Venta,productos.precio_Compra, fecha_Transaccion_Compra
FROM evaluacion_sql.productos
CROSS JOIN evaluacion_sql.registro_compras on evaluacion_sql.productos.productos_id = evaluacion_sql.productos.productos_id;

###############Para obtener un registro Anual solo debemos restar#############################
#para sumar el total de precios de venta productos
SELECT SUM(precio_Venta) - SUM(precio_Compra) AS resta
FROM productos;

### 9000 la venta
SELECT SUM(precio_Compra) 
FROM evaluacion_sql.productos;
### 3000 la venta

#REsultado Final de Ganancias
SELECT SUM(precio_Venta) - SUM(precio_Compra) AS resta
FROM productos;


select * from evaluacion_sql.productos;


