drop database if exists foromultitema;
create database foromultitema;
use foromultitema;

CREATE TABLE Usuario (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
	passwd       blob not null,
    rol          ENUM('R','A') NOT NULL -- R para Registrado y A para Admin
)engine InnoDB;
-- Usuario administrador 
INSERT INTO usuario VALUES (null,'Administrador', 'admin@admin.com', sha2('admin123',512), 'Admin');

CREATE TABLE Categoria (
    idCategoria  INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL
) engine InnoDB;
-- Categorías iniciales
INSERT INTO categoria VALUES (null,'Informatica');
INSERT INTO categoria VALUES(null,'Temas varios');
CREATE TABLE Publicacion (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    titulo         VARCHAR(200) NOT NULL,
    contenido      TEXT NOT NULL, 
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario     INT NOT NULL,
    id_categoria   INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(idCategoria)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_usuario (id_usuario),
    INDEX idx_categoria (id_categoria),
    INDEX idx_fecha (fecha_creacion)
) ENGINE = InnoDB;


CREATE TABLE comentario (
    id_comentario  INT AUTO_INCREMENT PRIMARY KEY,
    contenido      TEXT     NOT NULL,
    fecha          DATETIME NOT NULL,
    id_usuario     INT      NOT NULL,
    id_publicacion INT      NOT NULL,
    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_publicacion)
        REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)engine InnoDB;
