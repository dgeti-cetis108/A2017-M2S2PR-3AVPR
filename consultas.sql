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

# Consulta que devuelva cuantos libros hay por cada categoria
SELECT
	c.*,
	(SELECT COUNT(id) FROM libros WHERE categoria_id = c.id) as 'libros'
FROM categorias c;

# Consulta que devuelva cuantos libros tiene cada autor
SELECT
	concat(a.nombre, ' ', a.apellidos) as 'autor',
	(SELECT COUNT(libro_id) FROM libros_has_autores WHERE autor_id = a.id) as 'libros'
FROM autores a;

# Consulta que devuelva cuantos autores tiene cada libro
SELECT
	l.titulo as 'libro',
	(SELECT COUNT(autor_id) FROM libros_has_autores WHERE libro_id = l.id) as 'libros'
FROM libros l;

# Consulta que devuelva el nombre de editoriales y nombre de pais al que pertenece
SELECT
	e.nombre as 'editorial',
	(SELECT nombre FROM paises WHERE id = e.pais_id) as 'pais'
FROM editoriales e;

# Consulta que devuelva el total de editoriales por pais con el total de libros editados
# ordenados por editoriales y libros de forma descendente
SELECT
	nombre as 'pais',
	(SELECT COUNT(id) FROM editoriales WHERE pais_id = p.id) as 'editoriales',
	(SELECT COUNT(id) FROM libros WHERE editorial_id
		IN (SELECT id FROM editoriales WHERE pais_id = p.id)
	) as 'libros'
FROM paises p
ORDER BY
	editoriales DESC, libros DESC;



# Consulta que devuelva registros de editoriales y el nombre de pais
SELECT
	e.id as 'editorial_id',
	e.nombre as 'editorial',
	p.nombre as 'pais'
FROM editoriales e
INNER JOIN paises p ON
	e.pais_id = p.id;

# Consulta que devuelva los paises que no tengan editoriales registradas
SELECT
	p.id as 'pais_id',
	p.nombre as 'pais'
FROM paises p
LEFT JOIN editoriales e ON	p.id = e.pais_id
WHERE	e.id IS NULL
ORDER BY 	p.id;

# Reliza la consulta anterior utilizando RIGHT JOIN
SELECT
	p.id as 'pais_id',
	p.nombre as 'pais'
FROM editoriales e
RIGHT JOIN paises p ON p.id = e.pais_id
WHERE	e.id IS NULL
ORDER BY 	p.id;

# Consulta que muestre todos los paises con o sin editoriales
SELECT
	p.id as 'pais_id',
	p.nombre as 'pais',
	IF(e.id IS NULL, 'NO', 'SI') as 'tiene_editorial'
FROM paises p
LEFT JOIN editoriales e ON
	p.id = e.pais_id;

# Consulta que devuelva paises donde haya editoriales vinculadas a estos
SELECT
	p.id as 'pais_id',
	p.nombre as 'pais'
FROM paises p
LEFT JOIN editoriales e ON	p.id = e.pais_id
WHERE	e.id IS NOT NULL
GROUP BY p.id
ORDER BY 	p.id;


# Consulta que muestre los libros registrados, idioma, categoria, editorial y pais de editorial
SELECT
	l.isbn,
	l.titulo,
	l.año_edicion,
	i.nombre as 'idioma',
	c.nombre as 'categoria',
	e.nombre as 'editorial',
	p.nombre as 'pais_editorial'
FROM libros l
	INNER JOIN idiomas i ON l.idioma_id = i.id
	INNER JOIN categorias c ON l.categoria_id = c.id
	INNER JOIN editoriales e ON l.editorial_id = e.id
		INNER JOIN paises p ON e.pais_id = p.id;

# Consulta M:M que muestre los libros registrados con sus respectivos autores
SELECT
	l.isbn,
	l.titulo,
	l.año_edicion,
	a.nombre as 'autor'
FROM libros_has_autores la
	INNER JOIN autores a ON la.autor_id = a.id
	INNER JOIN libros l ON la.libro_id = l.id;
	
# Consulta que muestre los libros registrados, idioma, categoria, editorial y pais de editorial, asi como el nombre de los autores y correo electronico del mismo
SELECT
	l.isbn,
	l.titulo,
	l.año_edicion,
	i.nombre as 'idioma',
	c.nombre as 'categoria',
	e.nombre as 'editorial',
	p.nombre as 'pais_editorial',
	CONCAT(a.nombre, ' ', a.apellidos) as 'autor',
	a.email as 'correo-electronico'
FROM libros l
	INNER JOIN idiomas i ON l.idioma_id = i.id
	INNER JOIN categorias c ON l.categoria_id = c.id
	INNER JOIN editoriales e ON l.editorial_id = e.id
		INNER JOIN paises p ON e.pais_id = p.id
	INNER JOIN libros_has_autores la ON l.id = la.libro_id
		INNER JOIN autores a ON la.autor_id = a.id;


DESCRIBE autores;





