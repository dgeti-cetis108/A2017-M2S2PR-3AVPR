use biblioteca_cetis108;
# DML -> Data Manipulation Language
# consulta que me devuelva todos los registros de la tabla usuarios
SELECT * FROM usuarios;

# consulta que me devuelva todos los registros donde el id sea mayor que 10
SELECT * FROM usuarios
WHERE id > 10;

# consulta que devuelva todos los registros con el id entre 10 y 50
SELECT * FROM usuarios
WHERE id > 10 AND id < 50;

# consulta que devuelva todos los registros con valores opuestos a la anterior consulta
SELECT * FROM usuarios
WHERE id <= 10 OR id >= 50;

# consulta para validar que el usuario y la contraseña dadas son correctas y existen en la tabla usuarios (debe regresar id,nombre,apellidos)
SELECT id,nombre,apellidos FROM usuarios
WHERE username = 'tcarncross21' AND password = 'YJ5wqs';

# consulta que devuelva cuantos paises estan registrados
SELECT
	COUNT(id) as 'paises'
FROM paises;

# consulta que devuelva el id del país Mexico en caso de existir
SELECT id FROM paises
WHERE nombre = 'Mexico'; -- Mexico Id = 45

# consulta que devuelva cuantas editoriales existen
SELECT
	COUNT(id) as 'Editoriales'
FROM editoriales;

# consulta que devuelva cuantas editoriales de Mexico existen
SELECT
	COUNT(id) as 'Editoriales en Mexico'
FROM editoriales
WHERE pais_id = 45;

# consulta anterior con SUM e IF (bonus)
SELECT
	SUM(IF(pais_id = 45, 1, 0)) as 'Es de Mexico?'
FROM editoriales;

# consulta que devuelva cuantos usuarios existen que su nombre inicie con la letra a
SELECT
	COUNT(id) as 'usuarios con nombre que inicia con a'
FROM usuarios
WHERE
	nombre LIKE 'a%';
	
# consulta que devuelva los nombres de usuarios que el mismo inicie con la letra a
SELECT nombre FROM usuarios
WHERE nombre LIKE 'a%';

# consulta que devuelva los nombres de usuarios que el mismo termine con la letra a
SELECT nombre FROM usuarios
WHERE nombre LIKE '%a';


# consulta para validar que el usuario y la contraseña dadas son correctas y existen en la tabla usuarios (debe regresar id,nombre,apellidos)
set @usuario = 'tcarncross21';
set @contraseña = 'YJ5wqs';

SELECT id,nombre,apellidos FROM usuarios
WHERE username = @usuario AND password = @contraseña;

select @usuario,@contraseña;

# CRUD - Create Read Update Delete

# consulta que muestre la lista de usuarios (id, nombre, apellidos, username)
SELECT
	id, nombre, apellidos, username
FROM usuarios;

# consulta que permita cambiar la contraseña de un usuario
set @newpassword = '123456';
set @id = 1;
UPDATE usuarios SET password = @newpassword
WHERE id = @id;

SELECT @newpassword,@id;

# consulta para cambiar nombre y apellidos de un usuario
UPDATE usuarios SET
	nombre = 'Bidkar',
	apellidos = 'Aragon Cardenas'
WHERE
	id = 1;




