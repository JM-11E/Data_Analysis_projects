#!/usr/bin/env python
# coding: utf-8

# Cargamos la imagen Prueba

# In[78]:


import numpy as np
import scipy as sp
import matplotlib.pyplot as plt


# In[79]:


huella_image = plt.imread(
    'C:/Users/HP/PROCESAMIENTO DE IMAGENES/TAREA 4/012_1_2.jpg')  #imagen por defecto

#mostrar la imagen
plt.imshow(huella_image)
plt.axis('off')
plt.show()


# In[80]:


huella_image.ndim #esacala de grises


# In[81]:


huella_image.shape #nos indica la resolucion de la imagen


# In[82]:


# Verificar si la imagen es RGB (3 canales) o RGBA (4 canales)
if huella_image.ndim == 3:
    # Convertir a escala de grises usando la fórmula de luminosidad
    # f[:, :, 0] es el canal rojo, f[:, :, 1] el verde y f[:, :, 2] el azul
    huella_image = 0.2989 * f[:, :, 0] + 0.5870 * f[:, :, 1] + 0.1140 * f[:, :, 2]
else:
    huella_image = huella_image  # Ya es una imagen en escala de grises

# Mostrar la imagen en escala de grises
plt.imshow(huella_image,cmap='gray')
plt.axis('off')  # Desactiva los ejes
plt.title("Imagen en Escala de Grises")  # Agrega un título si lo deseas
plt.show()


# Calcula la direccion del gradiente con su magnitud

# In[83]:


# Máscaras para calcular gradiente en X y Y (derivadas parciales)
mascara_x = np.array([[-1, 1]])
mascara_y = np.array([[-1], [1]])

# Calcular gradientes en las direcciones X y Y
gradiente_x =  ndimage.convolve(huella_image, mascara_x).astype(np.float32)
gradiente_y =  ndimage.convolve(huella_image, mascara_y).astype(np.float32)

# Calcular la magnitud del gradiente
magnitud_gradiente = np.sqrt(gradiente_x**2 + gradiente_y**2).astype(np.float32)

# Mostrar resultados
plt.figure(figsize=(12, 4))
plt.subplot(1, 4, 1)
plt.title("Imagen original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 4, 2)
plt.title("Magnitud del Gradiente")
plt.imshow(magnitud_gradiente, cmap='gray')
plt.axis('off')

plt.subplot(1, 4, 3)
plt.title("Gradiente X")
plt.imshow(np.abs(gradiente_x), cmap='gray')
plt.axis('off')

plt.subplot(1, 4, 4)
plt.title("Gradiente Y")
plt.imshow(np.abs(gradiente_y), cmap='gray')
plt.axis('off')

plt.show()


# In[84]:


# Definir las máscaras de Prewitt para las direcciones X e Y
prewitt_x = np.array([[ -1, 0, 1],
                      [ -1, 0, 1],
                      [ -1, 0, 1]])

prewitt_y = np.array([[ -1, -1, -1],
                      [  0,  0,  0],
                      [  1,  1,  1]])

# Asegurar que la imagen esté en formato compatible (float64)
huella_image = huella_image.astype(np.float64)

# Aplicar las máscaras para calcular los gradientes en X e Y
Gx = ndimage.convolve(huella_image, prewitt_x).astype(np.float64)
Gy = ndimage.convolve(huella_image, prewitt_y).astype(np.float64)

# Calcular la magnitud del gradiente
magnitud_gradiente = np.sqrt(Gx**2 + Gy**2)

# Calcular la dirección del gradiente (en grados)
Gdir = np.arctan2(Gy, Gx) * (180 / np.pi)

# Mostrar los resultados
plt.figure(figsize=(12, 4))

plt.subplot(1, 3, 1)
plt.title("Imagen Original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 3, 2)
plt.title("Magnitud del Gradiente (Prewitt)")
plt.imshow(magnitud_gradiente, cmap='gray')
plt.axis('off')

plt.subplot(1, 3, 3)
plt.title("Dirección del Gradiente (Prewitt)")
plt.imshow(Gdir, cmap='hsv')  # Usar colormap 'hsv' para ver direcciones mejor
plt.axis('off')

plt.show()


# Normalizar los valores de la imagen, para asegurarse de que
# se encuentren en un rango de 0 a 255. Para esto, es
# necesario:
# 1. Encontrar el valor mínimo de intensidad en la imagen.
# 
# 2. Restar el valor mínimo encontrado a cada uno de los valores de la imagen. 
# 
# 3. Encontrar el valor máximo de intensidad en los nuevos valores de la imagen y dividirlo entre 255.
# 
# 4. Por último, multiplicar cada uno de los valores de la imagen por el resultado obtenido de la  división en el paso anterior.  
# 

# In[85]:


# Paso 1: Encontrar el valor mínimo de intensidad en la imagen
min_val = np.min(magnitud_gradiente)

# Paso 2: Restar el valor mínimo encontrado a cada uno de los valores de la imagen
imagen_normalizada = magnitud_gradiente - min_val

# Paso 3: Encontrar el valor máximo de intensidad en la imagen ajustada y dividir por 255
max_val = np.max(imagen_normalizada)
factor_normalizacion =  max_val / 255

# Paso 4: Multiplicar cada valor por el factor de normalización
#imagen_normalizada = imagen_normalizada * factor_normalizacion
imagen_normalizada = magnitud_gradiente * factor_normalizacion

# Convertir la imagen a enteros de 8 bits para visualización
imagen_normalizada = imagen_normalizada.astype(np.float32)

# Mostrar la imagen antes y después de la normalización
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Gradiente")
plt.imshow(magnitud_gradiente, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Imagen Normalizada")
plt.imshow(imagen_normalizada, cmap='gray')
plt.axis('off')

plt.show()


# Binarizar la imagen normalizada, utilizando como umbral el
# cálculo de la media de la imagen

# In[86]:


# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_normalizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada = np.where(imagen_normalizada >= media_umbral, 255, 0).astype(np.uint8)

# Mostrar resultados
plt.figure(figsize=(12, 4))
plt.subplot(1, 2, 1)
plt.title("Imagen Normalizada")
plt.imshow(imagen_normalizada, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Imagen Binarizada")
plt.imshow(imagen_binarizada, cmap='gray')
plt.axis('off')

plt.show()


# Aplicar un filtro de promediado a la imagen binarizada,
# utilizando una máscara de convolución con coeficientes de
# valor 1/fc, donde f representa el número de filas de la
# máscara y c representa el numero de columnas de la
# máscara.

# In[87]:


# Crear la máscara de promediado de 19x19
f = 19  # número de filas
c = 19  # número de columnas
valor_filtro = 1 / (f * c)
mascara_promediado = np.full((f, c), valor_filtro)

# Aplicar el filtro de promediado a la imagen binarizada
imagen_suavizada = convolve(imagen_binarizada.astype(np.float32), mascara_promediado, mode='reflect')

# Mostrar la imagen binarizada y la imagen suavizada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Binarizada")
plt.imshow(imagen_binarizada, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Imagen Suavizada")
plt.imshow(imagen_suavizada, cmap='gray')
plt.axis('off')

plt.show()


# Binarizar nuevamente la imagen filtrada, obteniendo
# nuevamente la media de la imagen para que ésta sea usada
# como umbral.

# In[88]:


# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_suavizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada_2 = np.where(imagen_suavizada >= media_umbral, 255, 0).astype(np.uint8)

# Mostrar resultados
plt.figure(figsize=(12, 4))
plt.subplot(1, 3, 1)
plt.title("Imagen Binarizada 1")
plt.imshow(imagen_binarizada, cmap='gray')
plt.axis('off')

plt.subplot(1, 3, 2)
plt.title("Imagen Promedio")
plt.imshow(imagen_suavizada, cmap='gray')
plt.axis('off')

plt.subplot(1, 3, 3)
plt.title("Imagen Binarizada 2")
plt.imshow(imagen_binarizada_2, cmap='gray')
plt.axis('off')

plt.show()


# Obtener la matriz de etiquetas de la imagen binaria
# utilizando algún algoritmo de etiquetado, en este trabajo se
# utilizó el mismo algoritmo.

# In[89]:


# Aplicar el algoritmo de etiquetado
estructura = np.ones((3, 3), dtype=int)  # Estructura de conectividad
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Mostrar la imagen original y la matriz de etiquetas
plt.figure(figsize=(10, 5))

plt.subplot(1, 2, 1)
plt.title("Imagen Binarizada 2")
plt.imshow(imagen_binarizada_2, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Matriz de Etiquetas")
plt.imshow(etiquetas, cmap='nipy_spectral')  # Utiliza un mapa de colores diferente para distinguir etiquetas
plt.axis('off')

plt.show()

# Número total de regiones etiquetadas
print(f"Número total de etiquetas: {num_etiquetas}")


# In[90]:


# Definir la estructura de conectividad (3x3 para 8-conectividad)
estructura = np.ones((3, 3), dtype=int)

# Aplicar el algoritmo de etiquetado
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Encontrar la etiqueta con el mayor número de ocurrencias, excluyendo el fondo
# Suponiendo que el fondo está etiquetado como 0
# Aplanar la matriz de etiquetas y filtrar el fondo
etiquetas_aplanadas = etiquetas.flatten()
etiquetas_filtradas = etiquetas_aplanadas[etiquetas_aplanadas > 0]

# Encontrar la etiqueta con más ocurrencias
etiqueta_mas_frecuente = mode(etiquetas_filtradas).mode[0]
ocurrencias = np.sum(etiquetas_filtradas == etiqueta_mas_frecuente)

# Imprimir resultados
print(f'Etiqueta más frecuente: {etiqueta_mas_frecuente}')
print(f'Ocurrencias de la etiqueta: {ocurrencias}')
# Número total de regiones etiquetadas
print(f"Número total de etiquetas: {num_etiquetas}")


# In[91]:


# Supongamos que 'imagen_binarizada_2' es la imagen binarizada de entrada
# Definir la estructura de conectividad (3x3 para 8-conectividad)
estructura = np.ones((3, 3), dtype=int)

# Aplicar el algoritmo de etiquetado
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Aplanar la matriz de etiquetas y filtrar el fondo
etiquetas_aplanadas = etiquetas.flatten()
etiquetas_filtradas = etiquetas_aplanadas[etiquetas_aplanadas > 0]

# Encontrar la etiqueta con más ocurrencias
etiqueta_mas_frecuente = mode(etiquetas_filtradas).mode[0]

# Crear una máscara para la huella dactilar
mascara = np.zeros_like(etiquetas, dtype=np.uint8)
mascara[etiquetas == etiqueta_mas_frecuente] = 255  # Mantener solo la región más grande

# Visualizar la imagen segmentada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Binarizada")
plt.imshow(imagen_binarizada_2, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Huella Dactilar Segmentada")
plt.imshow(mascara, cmap='gray')
plt.axis('off')

plt.show()


# In[92]:


huella_image = plt.imread('C:/Users/HP/PROCESAMIENTO DE IMAGENES/TAREA 4/012_1_2.jpg')  #imagen por defecto
# Aplicar la máscara a la imagen original para extraer solo la huella dactilar
# Suponiendo que 'imagen_original' es la imagen de entrada original
huella_segmentada = np.zeros_like(huella_image)  # Inicializar imagen en negro

# Aplicar la máscara sobre la imagen original
# Si 'imagen_original' está en escala de grises
huella_segmentada[mascara == 255] = huella_image[mascara == 255]

# Si 'imagen_original' está en color (3 canales), el proceso es similar:
# huella_segmentada[mascara == 255] = imagen_original[mascara == 255]

# Visualizar la imagen original y la imagen segmentada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Huella Dactilar Segmentada en la Imagen Original")
plt.imshow(huella_segmentada, cmap='gray')
plt.axis('off')

plt.show()


# In[93]:


# Inicializar la imagen segmentada en blanco en lugar de negro
huella_segmentada = np.ones_like(huella_image) * 255  # Fondo blanco

# Aplicar la máscara sobre la imagen original
# Copiar solo la región de interés (huella dactilar) desde la imagen original
huella_segmentada[mascara == 255] = huella_image[mascara == 255]

# Visualizar la imagen original y la imagen segmentada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Huella Dactilar Segmentada con Fondo Blanco")
plt.imshow(huella_segmentada, cmap='gray')
plt.axis('off')

plt.show()


# # **Optimización de Código**

# En esta sección se junto todo el código en uno solo y se dividio para dos casos para una máscara de matriz en dos dimensiones y luego para tres dimensiones.

# In[94]:


import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from scipy.ndimage import convolve
from scipy import ndimage
from scipy.ndimage import label
from scipy.stats import mode


# In[100]:


huella_image = plt.imread(
    'C:/Users/HP/PROCESAMIENTO DE IMAGENES/TAREA 4/012_1_5.jpg')  #imagen por defecto

#mostrar la imagen
plt.imshow(huella_image)
plt.axis('off')
plt.show()


# In[101]:


# Verificar si la imagen es RGB (3 canales) o RGBA (4 canales)
if huella_image.ndim == 3:
    # Convertir a escala de grises usando la fórmula de luminosidad
    # f[:, :, 0] es el canal rojo, f[:, :, 1] el verde y f[:, :, 2] el azul
    huella_image = 0.2989 * f[:, :, 0] + 0.5870 * f[:, :, 1] + 0.1140 * f[:, :, 2]
else:
    huella_image = huella_image  # Ya es una imagen en escala de grises

# Mostrar la imagen en escala de grises
plt.imshow(huella_image,cmap='gray')
plt.axis('off')  # Desactiva los ejes
plt.title("Imagen en Escala de Grises")  # Agrega un título si lo deseas
plt.show()


# **USADO MASCARA DE DOS DIMENSION**

# In[102]:


# Máscaras para calcular gradiente en X y Y (derivadas parciales)
mascara_x = np.array([[-1, 1]])
mascara_y = np.array([[-1], [1]])

# Calcular gradientes en las direcciones X y Y
gradiente_x =  ndimage.convolve(huella_image, mascara_x).astype(np.float32)
gradiente_y =  ndimage.convolve(huella_image, mascara_y).astype(np.float32)

# Calcular la magnitud del gradiente
magnitud_gradiente = np.sqrt(gradiente_x**2 + gradiente_y**2).astype(np.float32)

# Paso 1: Encontrar el valor mínimo de intensidad en la imagen
min_val = np.min(magnitud_gradiente)

# Paso 2: Restar el valor mínimo encontrado a cada uno de los valores de la imagen
imagen_normalizada = magnitud_gradiente - min_val

# Paso 3: Encontrar el valor máximo de intensidad en la imagen ajustada y dividir por 255
max_val = np.max(imagen_normalizada)
factor_normalizacion =  max_val / 255

# Paso 4: Multiplicar cada valor por el factor de normalización
#imagen_normalizada = imagen_normalizada * factor_normalizacion
imagen_normalizada = magnitud_gradiente * factor_normalizacion

# Convertir la imagen a enteros de 8 bits para visualización
imagen_normalizada = imagen_normalizada.astype(np.float32)

# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_normalizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada = np.where(imagen_normalizada >= media_umbral, 255, 0).astype(np.uint8)

# Crear la máscara de promediado de 19x19
f = 19  # número de filas
c = 19  # número de columnas
valor_filtro = 1 / (f * c)
mascara_promediado = np.full((f, c), valor_filtro)

# Aplicar el filtro de promediado a la imagen binarizada
imagen_suavizada = convolve(imagen_binarizada.astype(np.float32), mascara_promediado, mode='reflect')

# Crear la máscara de promediado de 19x19
f = 19  # número de filas
c = 19  # número de columnas
valor_filtro = 1 / (f * c)
mascara_promediado = np.full((f, c), valor_filtro)

# Aplicar el filtro de promediado a la imagen binarizada
imagen_suavizada = convolve(imagen_binarizada.astype(np.float32), mascara_promediado, mode='reflect')

# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_suavizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada_2 = np.where(imagen_suavizada >= media_umbral, 255, 0).astype(np.uint8)

# Aplicar el algoritmo de etiquetado
estructura = np.ones((3, 3), dtype=int)  # Estructura de conectividad
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Definir la estructura de conectividad (3x3 para 8-conectividad)
estructura = np.ones((3, 3), dtype=int)

# Aplicar el algoritmo de etiquetado
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Aplanar la matriz de etiquetas y filtrar el fondo
etiquetas_aplanadas = etiquetas.flatten()
etiquetas_filtradas = etiquetas_aplanadas[etiquetas_aplanadas > 0]

# Encontrar la etiqueta con más ocurrencias
etiqueta_mas_frecuente = mode(etiquetas_filtradas).mode[0]

# Crear una máscara para la huella dactilar
mascara = np.zeros_like(etiquetas, dtype=np.uint8)
mascara[etiquetas == etiqueta_mas_frecuente] = 255  # Mantener solo la región más grande


# In[103]:


# Inicializar la imagen segmentada en blanco en lugar de negro
huella_segmentada = np.ones_like(huella_image) * 255  # Fondo blanco

# Aplicar la máscara sobre la imagen original
# Copiar solo la región de interés (huella dactilar) desde la imagen original
huella_segmentada[mascara == 255] = huella_image[mascara == 255]

# Visualizar la imagen original y la imagen segmentada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Huella Dactilar Segmentada con Fondo Blanco")
plt.imshow(huella_segmentada, cmap='gray')
plt.axis('off')

plt.show()


# **USADO MASCARA DE TRES DIMENSION**

# In[104]:


# Definir las máscaras de Prewitt para las direcciones X e Y
prewitt_x = np.array([[ -1, 0, 1],
                      [ -1, 0, 1],
                      [ -1, 0, 1]])

prewitt_y = np.array([[ -1, -1, -1],
                      [  0,  0,  0],
                      [  1,  1,  1]])

# Asegurar que la imagen esté en formato compatible (float64)
huella_image = huella_image.astype(np.float64)

# Aplicar las máscaras para calcular los gradientes en X e Y
Gx = ndimage.convolve(huella_image, prewitt_x).astype(np.float64)
Gy = ndimage.convolve(huella_image, prewitt_y).astype(np.float64)

# Calcular la magnitud del gradiente
magnitud_gradiente = np.sqrt(Gx**2 + Gy**2)

# Calcular la dirección del gradiente (en grados)
Gdir = np.arctan2(Gy, Gx) * (180 / np.pi)

# Paso 1: Encontrar el valor mínimo de intensidad en la imagen
min_val = np.min(magnitud_gradiente)

# Paso 2: Restar el valor mínimo encontrado a cada uno de los valores de la imagen
imagen_normalizada = magnitud_gradiente - min_val

# Paso 3: Encontrar el valor máximo de intensidad en la imagen ajustada y dividir por 255
max_val = np.max(imagen_normalizada)
factor_normalizacion =  max_val / 255

# Paso 4: Multiplicar cada valor por el factor de normalización
#imagen_normalizada = imagen_normalizada * factor_normalizacion
imagen_normalizada = magnitud_gradiente * factor_normalizacion

# Convertir la imagen a enteros de 8 bits para visualización
imagen_normalizada = imagen_normalizada.astype(np.float32)

# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_normalizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada = np.where(imagen_normalizada >= media_umbral, 255, 0).astype(np.uint8)

# Crear la máscara de promediado de 19x19
f = 19  # número de filas
c = 19  # número de columnas
valor_filtro = 1 / (f * c)
mascara_promediado = np.full((f, c), valor_filtro)

# Aplicar el filtro de promediado a la imagen binarizada
imagen_suavizada = convolve(imagen_binarizada.astype(np.float32), mascara_promediado, mode='reflect')

# Crear la máscara de promediado de 19x19
f = 19  # número de filas
c = 19  # número de columnas
valor_filtro = 1 / (f * c)
mascara_promediado = np.full((f, c), valor_filtro)

# Aplicar el filtro de promediado a la imagen binarizada
imagen_suavizada = convolve(imagen_binarizada.astype(np.float32), mascara_promediado, mode='reflect')

# Calcular la media de la imagen normalizada
media_umbral = np.mean(imagen_suavizada)

# Binarizar la imagen usando el umbral calculado
imagen_binarizada_2 = np.where(imagen_suavizada >= media_umbral, 255, 0).astype(np.uint8)

# Aplicar el algoritmo de etiquetado
estructura = np.ones((3, 3), dtype=int)  # Estructura de conectividad
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Definir la estructura de conectividad (3x3 para 8-conectividad)
estructura = np.ones((3, 3), dtype=int)

# Aplicar el algoritmo de etiquetado
etiquetas, num_etiquetas = label(imagen_binarizada_2, structure=estructura)

# Aplanar la matriz de etiquetas y filtrar el fondo
etiquetas_aplanadas = etiquetas.flatten()
etiquetas_filtradas = etiquetas_aplanadas[etiquetas_aplanadas > 0]

# Encontrar la etiqueta con más ocurrencias
etiqueta_mas_frecuente = mode(etiquetas_filtradas).mode[0]

# Crear una máscara para la huella dactilar
mascara = np.zeros_like(etiquetas, dtype=np.uint8)
mascara[etiquetas == etiqueta_mas_frecuente] = 255  # Mantener solo la región más grande


# In[105]:


# Inicializar la imagen segmentada en blanco en lugar de negro
huella_segmentada = np.ones_like(huella_image) * 255  # Fondo blanco

# Aplicar la máscara sobre la imagen original
# Copiar solo la región de interés (huella dactilar) desde la imagen original
huella_segmentada[mascara == 255] = huella_image[mascara == 255]

# Visualizar la imagen original y la imagen segmentada
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.title("Imagen Original")
plt.imshow(huella_image, cmap='gray')
plt.axis('off')

plt.subplot(1, 2, 2)
plt.title("Huella Dactilar Segmentada con Fondo Blanco")
plt.imshow(huella_segmentada, cmap='gray')
plt.axis('off')

plt.show()


# Nos da como resultado la parte segmentada donde se aprecia el correcto funcionamiento del código empleado y basado en el árticulo que se mando a trabajar. Este resultado es de útil importancia para la parte de reconocimiento de imágenes, debido a que con estas imágenes segmentadas se puede trabajar en un algoritmo de reconocimiento y obtener un mejor resultado, utilizando este método.
