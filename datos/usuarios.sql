USE biblioteca_cetis108;

LOAD DATA LOCAL INFILE '/Users/bidkar/Documents/CETis108/2017-1 (AGO17-ENE18)/M2S2_3AV-PR/Segundo Parcial/SQL-Queries/datos/usuarios.csv'
INTO TABLE usuarios
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nombre,apellidos,username,password);

-- DML para borrar todos los registros de una tabla
DELETE FROM usuarios;

-- DDL para reiniciar campos auto_increment
ALTER TABLE usuarios AUTO_INCREMENT = 1;

SELECT * FROM usuarios;