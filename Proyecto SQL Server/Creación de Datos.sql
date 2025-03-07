create Database AnalisisVentas

--tabla de Clientes
create table Clientes (
	ID int primary key identity(1,1),
	Nombre varchar(50) not null,
	Edad int,
	Ubicación varchar(50),
	Email nvarchar(50) unique
)

--tabla de Productos
create table Productos (
	ProductoID int primary key identity(1,1),
	Nombre varchar(50) not null,
	Categoria nvarchar(50),
	Precio numeric(10,2) check(Precio>0),
	Stock int check(Stock>=0)
)

--tabla de Empleados
create table Empleados(
	EmpleadoID int primary key identity(1,1),
	Nombre varchar(50) not null,
	Cargo nvarchar(50),
	Sucursal nvarchar(50)
)

-- tabla Ventas
create table Ventas(
	VentaID int primary key identity(1,1),
	ClienteID int not null,
	ProductoID int not null,
	EmpleadoID int not null,
	Fecha date,
	Cantidad int check(Cantidad > 0)
)

-- Verificar Tablas Creadas
select * from Clientes
select * from Productos
select * from Empleados
select * from Ventas

-- Insertar Datos Clientes
insert into Clientes(Nombre, Edad, Ubicación, Email)
values
	('Alejandro Rojas', 32, 'Ciudad A', 'alejandro.rojas@email.com'),
	('Beatriz Vega', 27, 'Ciudad B', 'beatriz.vega@email.com'),
	('Camilo Ortega', 45, 'Ciudad C', 'camilo.ortega@email.com'),
	('Daniela Ruiz', 29, 'Ciudad A', 'daniela.ruiz@email.com'),
	('Eduardo Salazar', 33, 'Ciudad B', 'eduardo.salazar@email.com'),
	('Fernando Castro', 36, 'Ciudad C', 'fernando.castro@email.com'),
	('Gabriela Soto', 31, 'Ciudad A', 'gabriela.soto@email.com'),
	('Héctor Paredes', 50, 'Ciudad B', 'hector.paredes@email.com'),
	('Isabel Torres', 22, 'Ciudad C', 'isabel.torres@email.com'),
	('Javier Gómez', 28, 'Ciudad A', 'javier.gomez@email.com'),
	('Karla Mendoza', 26, 'Ciudad B', 'karla.mendoza@email.com'),
	('Leonardo Herrera', 35, 'Ciudad C', 'leonardo.herrera@email.com'),
	('Mónica Valdez', 30, 'Ciudad A', 'monica.valdez@email.com'),
	('Natalia Flores', 42, 'Ciudad B', 'natalia.flores@email.com'),
	('Oscar Jiménez', 38, 'Ciudad C', 'oscar.jimenez@email.com'),
	('Patricia Guzmán', 25, 'Ciudad A', 'patricia.guzman@email.com'),
	('Ricardo Navarro', 48, 'Ciudad B', 'ricardo.navarro@email.com'),
	('Sofía Estrada', 29, 'Ciudad C', 'sofia.estrada@email.com'),
	('Tomás Díaz', 40, 'Ciudad A', 'tomas.diaz@email.com'),
	('Valentina Ortiz', 37, 'Ciudad B', 'valentina.ortiz@email.com'),
	('David Vargas', 39, 'Ciudad C', 'david.vargas@email.com'),
	('Andrea Silva', 31, 'Ciudad A', 'andrea.silva@email.com'),
	('Sebastián Pino', 29, 'Ciudad B', 'sebastian.pino@email.com'),
	('Lorena Peña', 33, 'Ciudad C', 'lorena.pena@email.com'),
	('Fabián Morales', 41, 'Ciudad A', 'fabian.morales@email.com'),
	('Carolina Salas', 36, 'Ciudad B', 'carolina.salas@email.com'),
	('Jorge Herrera', 38, 'Ciudad C', 'jorge.herrera@email.com'),
	('Diana Paredes', 28, 'Ciudad A', 'diana.paredes@email.com'),
	('Felipe Mendez', 35, 'Ciudad B', 'felipe.mendez@email.com'),
	('Ximena Vargas', 40, 'Ciudad C', 'ximena.vargas@email.com'),
	('Mauricio Díaz', 50, 'Ciudad A', 'mauricio.diaz@email.com'),
	('Vanessa Torres', 27, 'Ciudad B', 'vanessa.torres@email.com'),
	('Esteban Guzmán', 45, 'Ciudad C', 'esteban.guzman@email.com'),
	('Claudia Navarro', 34, 'Ciudad A', 'claudia.navarro@email.com'),
	('Francisco Ortiz', 43, 'Ciudad B', 'francisco.ortiz@email.com')

-- Insertar Datos Productos
insert into Productos(Nombre, Categoria, Precio, Stock)
values
	('Laptop HP Pavilion', 'Electrónica', 1200.00, 15),
	('Smartphone Samsung Galaxy S21', 'Electrónica', 800.00, 30),
	('Teclado Mecánico Redragon', 'Accesorios', 100.00, 50),
	('Monitor LG 24”', 'Electrónica', 300.00, 20),
	('Mouse Gamer Logitech', 'Accesorios', 50.00, 40),
	('Tablet Lenovo Tab M10', 'Electrónica', 500.00, 25),
	('Audífonos Sony WH-1000XM4', 'Accesorios', 120.00, 100),
	('Cámara Canon EOS 2000D', 'Fotografía', 900.00, 20),
	('Impresora HP LaserJet', 'Electrónica', 250.00, 15),
	('Silla Gamer Corsair', 'Muebles', 300.00, 10),
	('Escritorio Oficina', 'Muebles', 180.00, 20),
	('Disco Duro Externo 1TB', 'Almacenamiento', 90.00, 35),
	('Memoria USB 64GB', 'Almacenamiento', 25.00, 60),
	('Cargador Universal Laptop', 'Accesorios', 40.00, 30),
	('Mochila Antirrobo', 'Accesorios', 70.00, 25),
	('Cafetera Nespresso', 'Electrodomésticos', 150.00, 18),
	('Smart TV Samsung 55”', 'Electrónica', 1000.00, 12),
	('Refrigerador LG Inverter', 'Electrodomésticos', 1200.00, 8),
	('Horno Microondas Panasonic', 'Electrodomésticos', 180.00, 20),
	('Plancha a Vapor Philips', 'Electrodomésticos', 60.00, 40),
	('Bicicleta Montaña', 'Deportes', 450.00, 15),
	('Mancuernas Ajustables', 'Deportes', 120.00, 30),
	('Colchoneta Yoga', 'Deportes', 40.00, 50),
	('Reloj Inteligente Garmin', 'Wearables', 300.00, 25),
	('Banda de Resistencia', 'Deportes', 20.00, 80),
	('Zapatillas Running Nike', 'Deportes', 130.00, 40),
	('Chaqueta Impermeable Columbia', 'Ropa', 200.00, 20),
	('Jeans Levi’s', 'Ropa', 90.00, 30),
	('Camisa Formal Zara', 'Ropa', 50.00, 35),
	('Reloj Casio Clásico', 'Accesorios', 40.00, 60),
	('Gafas de Sol Ray-Ban', 'Accesorios', 150.00, 25),
	('Perfume Dior Sauvage', 'Belleza', 120.00, 30),
	('Secadora de Cabello Dyson', 'Belleza', 300.00, 15),
	('Cepillo Eléctrico Oral-B', 'Belleza', 80.00, 40),
	('Crema Hidratante Neutrogena', 'Belleza', 20.00, 50),
	('Lámpara LED Escritorio', 'Hogar', 35.00, 40),
	('Aspiradora Xiaomi', 'Electrodomésticos', 250.00, 18),
	('Set de Ollas Tefal', 'Hogar', 200.00, 12),
	('Cama King Size', 'Muebles', 800.00, 5),
	('Sofá Seccional', 'Muebles', 1200.00, 4)

-- Insertar datos en Empleados
insert into Empleados (Nombre, Cargo, Sucursal)
values
	('Juan Carlos', 'Cajero', 'Sucursal Norte'),
	('Juan Pérez', 'Gerente', 'Sucursal Centro'),
	('María López', 'Cajero', 'Sucursal Norte'),
	('Carlos Gómez', 'Vendedor', 'Sucursal Centro'),
	('Ana Torres', 'Analista', 'Sucursal Sur'),
	('Pedro Ramírez', 'Supervisor', 'Sucursal Este'),
	('Luisa Fernández', 'Cajero', 'Sucursal Oeste'),
	('Hugo Castro', 'Vendedor', 'Sucursal Centro'),
	('Diana Soto', 'Gerente', 'Sucursal Norte'),
	('José Rojas', 'Cajero', 'Sucursal Este'),
	('Mónica Herrera', 'Supervisor', 'Sucursal Sur'),
	('Esteban Salinas', 'Analista', 'Sucursal Centro'),
	('Paola Méndez', 'Vendedor', 'Sucursal Oeste'),
	('Ramón Guzmán', 'Cajero', 'Sucursal Norte'),
	('Carla Jiménez', 'Gerente', 'Sucursal Sur'),
	('Fernando Morales', 'Supervisor', 'Sucursal Centro'),
	('Elena Paredes', 'Analista', 'Sucursal Este'),
	('Santiago Vázquez', 'Vendedor', 'Sucursal Oeste'),
	('Valeria Ortega', 'Cajero', 'Sucursal Norte'),
	('Ricardo Fuentes', 'Gerente', 'Sucursal Centro'),
	('Natalia Ruiz', 'Supervisor', 'Sucursal Sur'),
	('Gustavo Ramírez', 'Cajero', 'Sucursal Este'),
	('Andrea Castillo', 'Vendedor', 'Sucursal Oeste'),
	('Francisco Peña', 'Analista', 'Sucursal Centro'),
	('Lorena Medina', 'Supervisor', 'Sucursal Norte'),
	('Emilio Vargas', 'Gerente', 'Sucursal Sur'),
	('Gabriela Espinoza', 'Cajero', 'Sucursal Oeste'),
	('Rodrigo Pacheco', 'Vendedor', 'Sucursal Este'),
	('Clara Sánchez', 'Analista', 'Sucursal Norte'),
	('Javier Navarro', 'Supervisor', 'Sucursal Centro'),
	('Sofía Álvarez', 'Cajero', 'Sucursal Sur'),
	('David Romero', 'Gerente', 'Sucursal Norte'),
	('Isabel Cordero', 'Analista', 'Sucursal Oeste'),
	('Martín Mendoza', 'Vendedor', 'Sucursal Centro'),
	('Fabiola Bustamante', 'Cajero', 'Sucursal Este'),
	('Raúl Villanueva', 'Supervisor', 'Sucursal Oeste'),
	('Cecilia Duarte', 'Gerente', 'Sucursal Norte'),
	('Cristian Vargas', 'Analista', 'Sucursal Centro'),
	('Patricia León', 'Cajero', 'Sucursal Sur'),
	('Eugenio Bravo', 'Vendedor', 'Sucursal Oeste'),
	('Marta Espinosa', 'Supervisor', 'Sucursal Norte'),
	('Álvaro Rivas', 'Gerente', 'Sucursal Centro'),
	('Paula Ocampo', 'Cajero', 'Sucursal Este'),
	('Tomás Estrada', 'Analista', 'Sucursal Sur'),
	('Camila Valdez', 'Vendedor', 'Sucursal Norte'),
	('Federico Lozano', 'Supervisor', 'Sucursal Centro'),
	('Beatriz Pineda', 'Gerente', 'Sucursal Oeste'),
	('Andrés Gutiérrez', 'Cajero', 'Sucursal Norte'),
	('Liliana Salazar', 'Analista', 'Sucursal Este'),
	('Héctor Arias', 'Vendedor', 'Sucursal Sur')

-- Insertar datos en Ventas
insert into Ventas (ClienteID, ProductoID, EmpleadoID, Fecha, Cantidad)
values	
	(12, 5, 23, '2024-02-15', 2),
    (3, 10, 8, '2024-02-16', 1),
    (25, 15, 45, '2024-02-17', 3),
    (7, 20, 12, '2024-02-18', 4),
    (18, 3, 31, '2024-02-19', 1),
    (30, 28, 5, '2024-02-20', 2),
    (5, 11, 29, '2024-02-21', 1),
    (21, 9, 33, '2024-02-22', 5),
    (9, 36, 48, '2024-02-23', 3),
    (27, 8, 17, '2024-02-24', 2),
    (2, 12, 41, '2024-02-25', 1),
    (16, 22, 9, '2024-02-26', 4),
    (33, 6, 27, '2024-02-27', 1),
    (14, 30, 11, '2024-02-28', 3),
    (8, 4, 50, '2024-02-29', 2),
    (29, 18, 13, '2024-03-01', 5),
    (11, 7, 21, '2024-03-02', 2),
    (22, 25, 35, '2024-03-03', 1),
    (31, 14, 4, '2024-03-04', 3),
    (6, 32, 37, '2024-03-05', 4),
    (20, 13, 16, '2024-03-06', 2),
    (15, 1, 39, '2024-03-07', 1),
    (10, 24, 7, '2024-03-08', 5),
    (28, 17, 19, '2024-03-09', 2),
    (1, 26, 25, '2024-03-10', 3),
    (17, 34, 43, '2024-03-11', 4),
    (34, 19, 30, '2024-03-12', 1),
    (24, 2, 22, '2024-03-13', 5),
    (26, 35, 14, '2024-03-14', 2),
    (13, 29, 6, '2024-03-15', 3),
	(5, 3, 10, '2024-03-16', 2),
    (21, 7, 27, '2024-03-17', 4),
    (8, 22, 14, '2024-03-18', 1),
    (35, 9, 50, '2024-03-19', 3),
    (11, 17, 23, '2024-03-20', 2),
    (16, 31, 6, '2024-03-21', 5),
    (4, 2, 19, '2024-03-22', 1),
    (26, 18, 33, '2024-03-23', 2),
    (3, 25, 7, '2024-03-24', 3),
    (13, 34, 41, '2024-03-25', 4),
    (28, 1, 11, '2024-03-26', 5),
    (9, 27, 48, '2024-03-27', 1),
    (30, 12, 35, '2024-03-28', 3),
    (19, 38, 22, '2024-03-29', 2),
    (2, 6, 37, '2024-03-30', 4),
    (25, 21, 9, '2024-03-31', 5),
    (33, 15, 13, '2024-04-01', 1),
    (7, 30, 29, '2024-04-02', 2),
    (20, 5, 31, '2024-04-03', 3),
    (12, 24, 8, '2024-04-04', 4),
    (17, 10, 44, '2024-04-05', 2),
    (27, 29, 16, '2024-04-06', 1),
    (1, 13, 49, '2024-04-07', 5),
    (32, 8, 21, '2024-04-08', 3),
    (6, 39, 25, '2024-04-09', 4),
    (15, 20, 17, '2024-04-10', 2),
    (34, 11, 39, '2024-04-11', 1),
    (10, 36, 5, '2024-04-12', 5),
    (14, 26, 30, '2024-04-13', 3),
    (29, 4, 42, '2024-04-14', 2),
    (22, 28, 12, '2024-04-15', 1),
    (24, 14, 45, '2024-04-16', 3),
    (18, 40, 32, '2024-04-17', 2),
    (11, 16, 38, '2024-04-18', 5),
    (9, 33, 15, '2024-04-19', 4),
    (31, 23, 20, '2024-04-20', 1),
    (5, 19, 24, '2024-04-21', 2),
    (23, 37, 18, '2024-04-22', 3),
    (4, 32, 26, '2024-04-23', 4),
    (35, 9, 47, '2024-04-24', 5),
	(7, 12, 33, '2024-04-25', 6),
    (19, 28, 14, '2024-04-26', 9),
    (5, 31, 47, '2024-04-27', 7),
    (23, 9, 21, '2024-04-28', 8),
    (35, 4, 11, '2024-04-29', 10),
    (11, 15, 39, '2024-04-30', 5),
    (27, 22, 8, '2024-05-01', 6),
    (3, 37, 44, '2024-05-02', 9),
    (16, 7, 17, '2024-05-03', 8),
    (21, 26, 42, '2024-05-04', 7),
    (9, 19, 31, '2024-05-05', 10),
    (29, 13, 48, '2024-05-06', 6),
    (6, 32, 24, '2024-05-07', 5),
    (20, 10, 35, '2024-05-08', 7),
    (12, 25, 29, '2024-05-09', 9),
    (4, 16, 50, '2024-05-10', 8),
    (31, 5, 19, '2024-05-11', 10),
    (15, 40, 26, '2024-05-12', 6),
    (8, 18, 46, '2024-05-13', 7),
    (14, 34, 23, '2024-05-14', 9),
    (30, 11, 12, '2024-05-15', 10),
    (2, 38, 15, '2024-05-16', 8),
    (22, 27, 41, '2024-05-17', 6),
    (17, 3, 37, '2024-05-18', 7),
    (25, 20, 30, '2024-05-19', 9),
    (13, 6, 45, '2024-05-20', 10),
    (32, 29, 33, '2024-05-21', 8),
    (10, 2, 38, '2024-05-22', 7),
    (18, 36, 9, '2024-05-23', 6),
    (1, 14, 22, '2024-05-24', 9)

-- Verificar Tablas Creadas
select * from Clientes
select * from Productos
select * from Empleados
select * from Ventas

-- Borrar Registros (OPCIONAL)
delete Clientes
delete Productos
delete Empleados
delete Ventas
where Email in ('jan.perez@email.com','juan.erez@email.com','juanperez@email.com'
				,'juan.perez@email.com')