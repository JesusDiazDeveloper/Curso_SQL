# CRUD TABLAS

-- cambiar Tablas ALTER TABLE (EN MYSQL)
alter table productos change column `PAÍSDEORIGEN` PAISDEORIGEN varchar(9);
alter table productos change column `SECCIÓN` SECCION varchar(10);
alter table productos change column `CÓDIGOARTÍCULO` CODIGOARTICULO varchar(4);
alter table productos change column `NOMBREARTÍCULO` NOMBREARTICULO varchar(19);

SELECT * FROM curso_sql.productos;