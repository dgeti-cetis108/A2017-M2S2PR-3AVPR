/*
	BIDKAR ARAGON CARDENAS
    Database: biblioteca
    Fecha: 2017-10-03 08:25
*/

-- autores,libros,editoriales,idiomas,paises,usuarios,
-- personas,alumnos,prestamo,tipo_persona

CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE IF NOT EXISTS autores (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(200) NOT NULL DEFAULT 'sin@correo'
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;











