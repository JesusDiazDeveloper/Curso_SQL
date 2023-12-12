use curso_sql;

SELECT * FROM clientes;

select * From clientes c where POBLACIÓN like '%ID';

/* ------ Video 4 ------ */

-- se puede ordenar por mas de 1 columna, primero ordena por la primera (seccion), y luego dentro 
-- de cada seccion, ordeno por precio. (se puede ordenar ASC o DESC tambien)
SELECT * FROM PRODUCTOS WHERE SECCIÓN='DEPORTES' OR SECCIÓN='CERÁMICA' ORDER BY SECCIÓN, PRECIO DESC;


/* ------ Video 5 ------ */ -- Funciones de agregacion o totales

#calculos por grupo. Agrupamos los registros de una tabla por determinado criterio, y luego a ese
# grupo le realizamos ciertos calculos. 

# 	Función 			Descripción
#  	AVG 				Calcula el promedio de un campo
#	COUNT 				Cuenta los registros que tienen el mismo valor en dicho campo
#  	SUM 				Suma los valores de un campo
#  	MAX 				Devuelve registro que tiene el valor mas alto
#  	MIN 				Devuelve registro que tiene el valor mas bajo



-- Calcular la suma de los precios de todos los productos de cada seccion.
-- para hacerlo necesitamos 1 campo para agrupar(SECCION), y 1 campo para sumar(PRECIO). 
-- importante, cuando hago order by, lo que mira la consulta es la tabla resultante, no la consultada. 
-- entonces, si quiero ordenar por precio mayor, tengo que darle un alias "suma_articulos" para poder ordenar por ese alias.

SELECT SECCIÓN, SUM(PRECIO) as suma_articulos FROM PRODUCTOS p GROUP BY SECCIÓN order by suma_articulos desc; 

-- NOMBREARTICULO esta mal, porque hay muchos articulos, y aca esta haciendo un agrupamiento, por eso estaria mal consultar asi.
SELECT SECCIÓN, SUM(PRECIO) as suma_articulos , NOMBREARTÍCULO FROM PRODUCTOS p GROUP BY SECCIÓN order by suma_articulos desc; 


-- CANTIDAD DE ARTICULOS POR PAIS
SELECT PAÍSDEORIGEN , COUNT(*) FROM PRODUCTOS GROUP BY PAÍSDEORIGEN;

-- LA MEDIA DE LOS ARTICULOS DE DEPORTES Y CERAMICA
SELECT AVG(PRECIO) , COUNT(*) , sum(PRECIO) AS TOTAL , 1748.1621 / 16 AS COMPROBACION FROM productos where SECCIÓN = 'CERÁMICA' OR SECCIÓN = 'DEPORTES';

-- LA MEDIA DE LOS ARTICULOS DE DEPORTES Y CERAMICA PERO HECHO EN EL VIDEO, ES DISTINTA.
SELECT SECCIÓN, AVG(PRECIO) AS MEDIA_ARTICULOS , COUNT(*)  FROM PRODUCTOS
        GROUP BY SECCIÓN HAVING SECCIÓN='DEPORTES' OR SECCIÓN='CONFECCIÓN' ORDER BY MEDIA_ARTICULOS DESC;

-- CUANTOS CLIENTES HAY POR CADA PAIS
SELECT C.POBLACIÓN , COUNT(*) AS CANTIDAD FROM clientes c  GROUP BY POBLACIÓN ORDER BY CANTIDAD DESC  ;
-- (SON CONSULTAS EQUIVALENTES)
SELECT POBLACIÓN, COUNT(CÓDIGOCLIENTE) AS N_CLIENTES FROM CLIENTES GROUP BY POBLACIÓN ORDER BY N_CLIENTES DESC;

-- EL PRECIO DEL ARTICULO MAS CARO DE LA SECCION CONFECCION
-- este esta mal, porque al ser una funcion de agregacion, debe solo tener 2 campos,
# 1. por lo que voy a agrupar (SECCION)
# 2. que estoy buscando (contar, promedio, max o min).
-- al poner el NOMBREARTÍCULO, me trae cualquiera, el primero que se encuentra, en lugar de
-- el registro que tiene ese precio. Es porque es una Funcion de Agregacion.
SELECT NOMBREARTÍCULO, PRECIO, MAX(PRECIO) from productos group by SECCIÓN HAVING SECCIÓN = 'CONFECCIÓN';

-- De esta manera se podria resolver esa Query anterior, sabiendo cual es el articulo con ese precio.
SELECT NOMBREARTÍCULO, PRECIO , SECCIÓN FROM productos WHERE SECCIÓN = 'CONFECCIÓN' ORDER BY  PRECIO DESC LIMIT 1;


SELECT * FROM productos;


/* ------ Video 6 ------ */ -- Funciones de agregacion o totales

SELECT DATE_FORMAT('2023-01-15', '%m-%d-%Y');

SELECT DATEDIFF('2023-01-01', '2022-12-01');

--
SELECT NOMBREARTÍCULO, SECCIÓN, PRECIO, FECHA,
       NOW() AS DIA_DE_HOY, DATEDIFF(NOW(), FECHA) AS DIFERENCIA
        FROM PRODUCTOS WHERE SECCIÓN='DEPORTES';


/*
1. Realizar una consulta que visualice los campos NOMBRE ARTÍCULO,
SECCIÓN, PRECIO de la tabla PRODUCTOS y un campo nuevo que
nombramos con el texto “DESCUENTO_7”. Debe mostrar el resultado de aplicar
sobre el campo PRECIO un descuento de un 7 %. El formato del nuevo campo
para debe aparecer con 2 lugares decimales.
*/
SELECT NOMBREARTÍCULO, SECCIÓN , PRECIO ,
        round(PRECIO - (PRECIO*0.07), 2) AS "7%", -- solo para verificar
        round(PRECIO - (PRECIO*0.07), 2) AS DESCUENTO_7
FROM productos ORDER BY PRECIO DESC;

/*
2. Realizar una consulta visualizando los campos FECHA, SECCIÓN, NOMBRE
ARTÍCULO y PRECIO de la tabla PRODUCTOS y un campo nuevo que
nombramos con el texto “DTO2 €_EN_CERÁMICA”. Debe mostrar el resultado
de aplicar sobre el campo PRECIO la resta de 2 € sólo a los artículos de la sección
CERÁMICA. El formato del nuevo campo debe aparecer con 2 lugares decimales.
Ordenar el resultado de la consulta por el campo FECHA descendente.
*/

SELECT FECHA, SECCIÓN, NOMBREARTÍCULO, PRECIO,
       ROUND( PRECIO-2 ,2) AS "DTO2 €_EN_CERÁMICA"
       FROM productos WHERE SECCIÓN = 'CERÁMICA' ORDER BY FECHA DESC;


/*
3. Realizar una consulta visualizando los campos NOMBRE ARTÍCULO,
SECCIÓN, PRECIO de la tabla PRODUCTOS y un campo nuevo que
nombramos con el texto “PRECIO_AUMENTADO_EN_2”. Debe mostrar el
PRECIO con un incremento de un 2% del PRECIO. Sólo debemos tener en cuenta
los registros de la sección FERRETERÍA. El nuevo campo debe aparecer en Euros
y con 2 lugares decimales.
*/

SELECT NOMBREARTÍCULO, SECCIÓN, ROUND (PRECIO,2) AS PRECIO ,
       ROUND (PRECIO*0.02 , 2 )AS '2%',
       ROUND (PRECIO*1.02 , 2 )AS 'PRECIO_AUMENTADO_EN_2'
FROM productos WHERE SECCIÓN = 'FERRETERÍA';




/* ------ Video 7 ------ */ -- Consultas Multi Tablas

# UNION
SELECT * FROM PRODUCTOS WHERE SECCIÓN = 'DEPORTES'
UNION
SELECT * FROM PRODUCTOSNUEVOS WHERE SECCIÓN = 'DEPORTES DE RIESGO';

SELECT * FROM PRODUCTOS WHERE PRECIO > 500
UNION
SELECT * FROM PRODUCTOSNUEVOS WHERE SECCIÓN = 'ALTA COSTURA';

SELECT SECCIÓN , NOMBREARTÍCULO , PRECIO , PAÍSDEORIGEN FROM productos WHERE PAÍSDEORIGEN = 'MARRUECOS'
UNION
SELECT SECCIÓN,NOMBREARTÍCULO , PRECIO , PAÍSDEORIGEN  FROM productosnuevos WHERE PAÍSDEORIGEN = 'MARRUECOS' OR PAÍSDEORIGEN = 'ESPAÑA';


# Ahora ordenandolos:
SELECT * FROM (
    SELECT SECCIÓN, NOMBREARTÍCULO, PRECIO, PAÍSDEORIGEN FROM productos WHERE PAÍSDEORIGEN = 'MARRUECOS'
    UNION
    SELECT SECCIÓN, NOMBREARTÍCULO, PRECIO, PAÍSDEORIGEN FROM productosnuevos WHERE PAÍSDEORIGEN IN ('MARRUECOS', 'ESPAÑA')
) AS Resultados
ORDER BY NOMBREARTÍCULO;

SELECT * FROM  productosnuevos;

SELECT * FROM productos;

SELECT PAÍSDEORIGEN , COUNT(*) FROM productos WHERE PAÍSDEORIGEN = 'ESPAÑA';

SELECT PAÍSDEORIGEN , COUNT(*) FROM productosnuevos WHERE PAÍSDEORIGEN = 'ESPAÑA';



