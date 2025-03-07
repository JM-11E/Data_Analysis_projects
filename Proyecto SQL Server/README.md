# 📊 Generación y Análisis de Datos de Ventas en SQL Server

## 📌 Descripción del Proyecto
Este proyecto consiste en la creación y análisis de un conjunto de datos sintético para un sistema de ventas en SQL Server. La base de datos está compuesta por tablas interconectadas que representan clientes, productos, empleados y ventas, lo que permite realizar consultas detalladas sobre el comportamiento del negocio.

## 🏛 Estructura de la Base de Datos
Se diseñaron las siguientes tablas:

- **Clientes** 🧑‍💼: ID, Nombre, Edad, Ubicación.
- **Productos** 📦: ID, Nombre, Categoría, Precio.
- **Empleados** 👔: ID, Nombre, Cargo.
- **Ventas** 💳: ID, ClienteID, ProductoID, EmpleadoID, Cantidad, Fecha.

## 🔧 Proceso de Creación de Datos
Para asegurar una distribución realista, se siguieron estos criterios:

- **Clientes**: Generados con nombres aleatorios y edades en distintos rangos.
- **Productos**: Se asignaron categorías y precios variados.
- **Ventas**: Se generó un historial de compras con fechas aleatorias.
- **Empleados**: Se asignó un vendedor a cada venta.

## 📊 Análisis y Consultas SQL
Se realizaron consultas para analizar distintos aspectos del negocio:

### 🟢 Consultas Básicas
- Listado de clientes ordenados por edad.
- Productos más baratos y más caros.
- Número total de clientes y empleados.
- Categorías de productos y ubicaciones de clientes.

### 🟡 Consultas Intermedias
- Total de ventas por cliente y producto.
- Clientes con más compras registradas.
- Cantidad de clientes por grupo de edad.
- Ventas realizadas en un periodo de tiempo.

### 🔴 Consultas Avanzadas
- Detección de tendencias en ventas.
- Identificación de productos más rentables.
- Análisis de estacionalidad en compras.
- Uso de `CTE` para determinar ventas mínimas y máximas.

## 🚀 Conclusión
Este proceso permitió construir un conjunto de datos robusto para análisis en SQL Server. La estructura y relación entre las tablas posibilitan la ejecución de consultas avanzadas para extraer insights valiosos.

## 📌 Próximos Pasos
- ✅ Refinar la generación de datos con distribuciones más realistas.
- ✅ Implementar triggers o procedimientos almacenados para simulaciones dinámicas.
- ✅ Ampliar la base de datos con nuevas tablas como "Métodos de Pago" o "Devoluciones".
