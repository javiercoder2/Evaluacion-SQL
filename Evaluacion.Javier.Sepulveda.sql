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
`fecha_Transaccion_Compra` datetime NOT NULL,
PRIMARY KEY (`registro_Ventas_id`));
####################Terminamos Creacion de Tablas#####################
drop table evaluacion_sql.registro_Ventas; 
delete from evaluacion_sql;

#Debemos añadir las FK ahora a las tablas correspondientes acorde al diagrama realizado

ALTER TABLE evaluacion_sql.proveedores ADD CONSTRAINT tipoProductosProveedor FOREIGN KEY (tipo_productos_id) REFERENCES evaluacion_sql.tipo_Productos(tipo_productos_id);
ALTER TABLE evaluacion_sql.productos ADD CONSTRAINT tipoProductoVenta FOREIGN KEY (tipo_productos_id) REFERENCES evaluacion_sql.tipo_Productos(tipo_productos_id);
ALTER TABLE evaluacion_sql.productos ADD CONSTRAINT proveedorProducto FOREIGN KEY (proveedores_id) REFERENCES evaluacion_sql.proveedores(proveedores_id);


ALTER TABLE generation_schema.cliente ADD CONSTRAINT clienteHistorial FOREIGN KEY (historial_id) REFERENCES generation_schema.historial(historial_id);


INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('papas fritas', 0001, 500,200);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('agua Mineral', 0002, 1000,600);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Jamon Serrano', 0003, 1500,1000);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Detergente 1kg', 0004, 2500,1200);
INSERT INTO evaluacion_sql.productos (nombre, codigo, precio_Venta, precio_Compra) VALUES ('Helado Sahne Nuss', 0005, 3500,2000);

SELECT * FROM evaluacion_sql.productos;



