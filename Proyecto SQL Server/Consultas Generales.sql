-----------------------------CONSULTAS BÁSICAS-------------------------------------------
select * from Clientes order by Edad desc;  -- Clientes más viejos primero

select top 10 Nombre, Precio from Productos order by Precio asc  -- 10 productos mas baratos
select top 10 Nombre, Precio from Productos order by Precio desc -- 10 productos mas caros

select COUNT(*) from Clientes -- Nro. Total de clientes
select COUNT(*) from Ventas where ClienteID = 5; -- Ventas de un cliente

select distinct(Ubicación) from Clientes -- Ciudades existentes
select distinct Categoria from Productos; -- Categorías de productos

select count(*) from Empleados -- cantidad de empleados

-----------------------------CONSULTAS INTERMEDIAS--------------------------------------
select * from Ventas
select * from Productos

-- Registro de Ventas por cliente y producto
select t2.Nombre,t3.Nombre, round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre,t3.Nombre
order by 1 asc

-- Registro de cliente mas vendidos 
select top 10 
	t2.Nombre, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre
order by 2 desc

-- Registro de Ventas por cliente
select t2.Nombre, count(*) as 'Registro de Ventas' 
from Ventas t1
inner join Clientes t2
	on t1.ClienteID = t2.ID
group by t2.Nombre

-- Registro de Ventas por cliente top 5
select top 5 t2.Nombre, count(*) as 'Clientes con max.Registros' 
from Ventas t1
inner join Clientes t2
	on t1.ClienteID = t2.ID
group by t2.Nombre
order by 2 desc

--Cantidad de clientes registrados
select count(*) as 'Cantidad de clientes registrados'
from (
	select t2.Nombre, count(*) as 'Registro de Ventas' 
	from Ventas t1
	inner join Clientes t2
		on t1.ClienteID = t2.ID
	group by t2.Nombre
) subq1

select min(Fecha), MAX(Fecha) from Ventas

-- creacion de View
create view Vista1 as (
	select 
	t2.Nombre as Cliente,
	t3.Nombre as Producto, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
	from Ventas t1 
	inner join Clientes t2
		on t1.ClienteID = t2.ID
	inner join Productos t3
		on t1.ProductoID = t3.ProductoID
	group by t2.Nombre,t3.Nombre
)
select * from Vista1

-- Ventas que se realizaron en cierto periodo
select distinct ClienteID as 'Clientes', Fecha from Ventas
where Fecha between '2024-02-01' AND '2024-03-01'

-- Solo empleados con más de una venta
SELECT EmpleadoID, COUNT(*) AS Total_Ventas
FROM Ventas
GROUP BY EmpleadoID
HAVING COUNT(*) > 1; 

-- Cantidad de clientes por grupo de edad
select q2.[Grupo de edad], COUNT(*) as 'Nro de Clientes'
from (	
select *, 
		case
			when Edad < 30 THEN 'Joven'
			when Edad between 30 and 45 then 'Adulto'
			else 'Adulto mayor'
		end as 'Grupo de edad'
	from Clientes
) q2
group by q2.[Grupo de edad]
order by 2 desc

-- Registro de Ventas por cliente y producto
select t2.Nombre,t3.Nombre, round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre,t3.Nombre
order by 1 asc

-- consulta sobre venta máximo y mínimo 
with cte as (
select 
	t2.Nombre as 'Cliente',
	t3.Nombre as 'Producto', 
	round(sum(t1.Cantidad*t3.Precio),2) as Cantidad_Total
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre,t3.Nombre
)
select 
	min(cte.Cantidad_Total) as 'Cantidad Mínima', 
	max(cte.Cantidad_Total) as 'Cantidad Máxima'
from cte

-- cantidad de venta en un intervalo del total
select 
	t2.Nombre as 'Cliente',
	t3.Nombre as 'Producto', 
	round(sum(t1.Cantidad*t3.Precio),2) as Cantidad_Total
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre,t3.Nombre
having round(sum(t1.Cantidad*t3.Precio),2) between 500.00 and 6000.00
order by 3 asc

-- Producto mas caro
select * from Productos
where Precio = (select max(Precio) from Productos)