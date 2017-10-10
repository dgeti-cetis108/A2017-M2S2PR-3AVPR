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
    descripcion ENUM('DOCENTE','ESTUDIANTE','ADMINISTRATIVO','OTROS') NOT NULL
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

CREATE TABLE IF NOT EXISTS editoriales (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    pais_id INT UNSIGNED NOT NULL,
    domicilio VARCHAR(200) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    email VARCHAR(200) NOT NULL DEFAULT 'sin@correo',
    web VARCHAR(200) NOT NULL DEFAULT 'http://sin.web/',
    CONSTRAINT fk_editoriales_paises
		FOREIGN KEY (pais_id)
        REFERENCES paises (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS personas (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    curp CHAR(18) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tipo_persona_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_personas_tipo_personas
		FOREIGN KEY (tipo_persona_id)
        REFERENCES tipo_personas (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS alumnos (
	persona_id INT UNSIGNED PRIMARY KEY,
    no_control CHAR(14) NOT NULL,
    generacion CHAR(9) NOT NULL,
    turno ENUM('MATUTINO','VESPERTINO'),
    carrera VARCHAR(200) NOT NULL,
    CONSTRAINT fk_alumnos_personas
		FOREIGN KEY (persona_id)
        REFERENCES personas (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS libros (
	id INT UNSIGNED PRIMARY KEY,
    isbn CHAR(17) NOT NULL DEFAULT '',
    titulo VARCHAR(200) NOT NULL,
    editorial_id INT UNSIGNED NOT NULL,
    año_edicion YEAR NOT NULL,
    paginas SMALLINT(4) UNSIGNED NOT NULL,
    idioma_id INT UNSIGNED NOT NULL,
    categoria_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_libros_editoriales
		FOREIGN KEY (editorial_id)
		REFERENCES editoriales (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	CONSTRAINT fk_libros_idiomas
		FOREIGN KEY (idioma_id)
        REFERENCES idiomas (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	CONSTRAINT fk_libros_categorias
		FOREIGN KEY (categoria_id)
        REFERENCES categorias (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS libros_has_autores (
	libro_id INT UNSIGNED,
    autor_id INT UNSIGNED,
    PRIMARY KEY (libro_id, autor_id),
    CONSTRAINT fk_libros_autores
		FOREIGN KEY (autor_id)
        REFERENCES autores (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	CONSTRAINT fk_autores_libros
		FOREIGN KEY (libro_id)
        REFERENCES libros (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS prestamos (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNSIGNED NOT NULL,
    persona_id INT UNSIGNED NOT NULL,
    fecha_salida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_regreso DATETIME NOT NULL DEFAULT '1999-01-01',
    grupo_actual CHAR(7) NOT NULL,
    CONSTRAINT fk_prestamos_usuarios
		FOREIGN KEY (usuario_id)
        REFERENCES usuarios (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	CONSTRAINT fk_prestamos_personas
		FOREIGN KEY (persona_id)
        REFERENCES personas (id)
			ON DELETE RESTRICT
            ON UPDATE CASCADE
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_general_ci;











