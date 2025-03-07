-------------------------------------1️ Objetivos del estudio---------------------------------------
-- ¿Cuáles son los clientes más valiosos en términos de compra?
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

-- clientes separados por categorias
with cte1 as (
select  
	t2.Nombre, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t2.Nombre
)
select *,
	case
		when cte1.[Cantidad Total] between 3000 and 5000 then 'Clientes Bajos'
		when cte1.[Cantidad Total] between 5000 and 7000 then 'Clientes Regulares'
		when cte1.[Cantidad Total] > 7000 then 'Clientes VIP'
		else 'Otros'
	end as 'Tipo de Cliente'
from cte1
order by 2 desc


-- ¿Qué productos generan más ingresos?
select top 10 
	t3.Nombre, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t3.Nombre
order by 2 desc

-- ¿Qué productos generan menos ingresos?
select top 10 
	t3.Nombre, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t3.Nombre
order by 2 asc

-- Ingresos generados por categoría de producto
select 
	t3.Categoria, 
	round(sum(t1.Cantidad*t3.Precio),2) as 'Cantidad Total'
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID
group by t3.Categoria
order by 2 desc

-- tabla a usar (TEMPORAL)
select
	t1.VentaID,
	t1.ClienteID,
	t1.ProductoID,
	t1.EmpleadoID,
	t1.Fecha,
	t1.Cantidad,
	t2.Nombre as Cliente,
	t2.Edad,
	t2.Ubicación,
	t2.Email,
	t3.Nombre as Producto,
	t3.Categoria,
	t3.Precio,
	t3.Stock,
	round((t1.Cantidad*t3.Precio),2) as Cantidad_Total
into TablaCompleta
from Ventas t1 
inner join Clientes t2
	on t1.ClienteID = t2.ID
inner join Productos t3
	on t1.ProductoID = t3.ProductoID

select * from TablaCompleta -- Tabla temporal

-- ¿Cómo varían las ventas en el tiempo mensual?
select 
	format(t1.Fecha, 'yyyy-MM') as 'Fechas',
	round(sum(t1.Cantidad*t1.Precio),2) as Cantidad_Total
from TablaCompleta t1
group by format(t1.Fecha, 'yyyy-MM')

-- ¿Cómo varían las ventas en el tiempo de manera diaria?
select 
	(t1.Fecha) as 'Fechas',
	round(sum(t1.Cantidad*t1.Precio),2) as Cantidad_Total
from TablaCompleta t1
group by (t1.Fecha)

-- ¿Cuáles son los empleados más productivos?
select top 10
	t2.Nombre, 
	COUNT(*) AS Total_Ventas
from Ventas t1
inner join Empleados t2
	on t1.EmpleadoID = t2.EmpleadoID
group by t2.Nombre
having COUNT(*) > 1
order by 2 desc

-- ¿Existen tendencias en el comportamiento de los clientes según su edad o ubicación?
select q2.[Grupo de edad],q2.Ubicación ,COUNT(*) as 'Nro de Clientes'
from (	
select *, 
		case
			when Edad < 30 THEN 'Joven'
			when Edad between 30 and 45 then 'Adulto'
			else 'Adulto mayor'
		end as 'Grupo de edad'
	from Clientes
) q2
group by q2.[Grupo de edad],q2.Ubicación
order by 2 asc

-------------------------------2️ Exploración de la base de datos----------------------------------

select Nombre, Precio from Productos -- Listado de productos con sus precios.
-- Listado de productos con sus precios.
select 
	max(Precio) as 'Precio Máximo', 
	min(Precio) as 'Precio Mínimo',
	avg(Precio) as 'Precio Promedio'
from Productos 


select count(ID) as 'Conteo de clientes' from Clientes -- Conteo de clientes.
select count(*) as 'Conteo de Empleados' from Empleados -- Conteo de Empleados.

-- Nro de clientes por ciudad.
select Ubicación, COUNT(Cliente) as 'Nro de Clientes' from [dbo].[TablaCompleta] 
group by Ubicación

-- Nro de clientes por Edad.
select Edad, COUNT(Cliente) as 'Nro de Clientes' from [dbo].[TablaCompleta] 
group by Edad

select Fecha, Precio from TablaCompleta order by 1 asc
