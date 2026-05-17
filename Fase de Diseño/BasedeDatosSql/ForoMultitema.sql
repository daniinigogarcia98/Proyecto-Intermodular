DROP DATABASE IF EXISTS foromultitema;
CREATE DATABASE foromultitema;
USE foromultitema;

-- Tabla usuarios
CREATE TABLE usuarios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('U','A') NOT NULL DEFAULT 'U',
    -- U = Usuario común, A = Administrador
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB;

-- Usuario administrador 
-- En laravel se recomienda usar bcrypt, pero para este ejemplo usaremos SHA2 con 512 bits
-- esto no es seguro para producción, solo para fines de demostración
INSERT INTO usuarios (nombre, email, password, rol, created_at)
VALUES ('Administrador', 'admin@admin.com', SHA2('admin1234',512), 'A', NOW());

-- Tabla categorias
CREATE TABLE categorias (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB;

INSERT INTO categorias (nombre) VALUES ('Informatica');
INSERT INTO categorias (nombre) VALUES ('Temas varios');

-- Tabla publicaciones
CREATE TABLE publicaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    usuario_id BIGINT UNSIGNED NOT NULL,
    categoria_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    INDEX (usuario_id),
    INDEX (categoria_id),
    INDEX (created_at)
) ENGINE=InnoDB;

-- Tabla comentarios
CREATE TABLE comentarios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    contenido TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    usuario_id BIGINT UNSIGNED NOT NULL,
    publicacion_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;