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

CREATE TABLE IF NOT EXISTS paises (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    nombre_alfa2 CHAR(2) NOT NULL
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS categorias (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS idiomas (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS tipo_personas (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion ENUM('DOCENTE','ALUMNO','ADMINISTRATIVO','OTROS') NOT NULL
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS usuarios (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    username VARCHAR(16) NOT NULL,
    password VARCHAR(200) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY idu_username (username)
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;













