
-- -----------------/* 10. SUBCONSULTAS */ ----------------- --

## Subconsulta escalonada (devuelve 1 solo valor, se utiliza como criterio o filtro)
#Nombre de articulo y seccion de aquellos articulos cuyo precio sea superior a la media

# 1. Cual es la media ?
# 2. Cuales son los Articulos que lo superan.

-- primero elaboro la subconsulta.
select AVG(p2.precio) from productos p2;

-- Luego la uso para comparar
select p.NOMBREARTÍCULO , p.SECCIÓN  , p.precio from productos p
where precio > (select avg(p2.precio) from productos p2);



## Subconsulta de Lista (Devuelve una lista de resultados, 1 sola columna, varios registros)

# mostrar una lista de productos cuyo precio es superior a todos los articulos de ceramica.

select p.precio from productos p where p.SECCIÓN = 'CERÁMICA' order by PRECIO desc;

select p2.NOMBREARTÍCULO, p2.precio from productos p2
where p2.PRECIO > ALL (select p.precio from productos p where p.SECCIÓN = 'CERÁMICA');


## OPERADOR IN
# CONSULTAS EQUIVALENTES
select * from productos where SECCIÓN IN ('JUGUETERÍA', 'DEPORTES' , 'FERRETERÍA' );

select * from productos where SECCIÓN = 'JUGUETERÍA' OR SECCIÓN = 'DEPORTES' OR SECCIÓN = 'FERRETERÍA';

# Todos los productos donde el nombre de seccion empieze con C
select * from productos where SECCIÓN IN (
        SELECT p2.SECCIÓN from productos p2 where p2.SECCIÓN LIKE 'C%');


# Todos los productos donde el nombre no sea BALON..
select * from productos where NOMBREARTÍCULO NOT IN (
    'BALÓN'
    );
# equivalente, pero con NOT IN. Tengo que hacer que la subconsulta sea en Positivo, para
# que devuelva una lista de los registros que SI cumplen con eso que quiero excluir.
SELECT * FROM productos WHERE NOMBREARTÍCULO NOT IN (
    SELECT p2.NOMBREARTÍCULO FROM productos p2 where p2.NOMBREARTÍCULO LIKE 'BALÓN%' -- Esta va en positivo.
    );

SELECT * FROM productos ;

select 1 from productos where CÓDIGOARTÍCULO = 'AR04';

SELECT p2.NOMBREARTÍCULO FROM productos p2 where p2.NOMBREARTÍCULO LIKE 'BALÓN%' ;-- Esta va en positivo.

