-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TikTok
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TikTok
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TikTok` DEFAULT CHARACTER SET utf8 ;
USE `TikTok` ;

-- -----------------------------------------------------
-- Table `TikTok`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Comentarios` (
  `ID_Comentario` INT NOT NULL,
  `ID_Video` VARCHAR(30) NOT NULL,
  `ID_Usuario` VARCHAR(8) NOT NULL,
  `Texto_comentario` VARCHAR(45) NOT NULL,
  `Fecha_comentrario` DATE NOT NULL,
  PRIMARY KEY (`ID_Comentario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Likes` (
  `ID_Like` VARCHAR(30) NOT NULL,
  `ID_Video` VARCHAR(30) NOT NULL,
  `ID_Usuario` INT NOT NULL,
  `fecha_like` DATE NOT NULL,
  PRIMARY KEY (`ID_Like`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Videos` (
  `ID_Video` VARCHAR(30) NOT NULL,
  `ID_Usuario` VARCHAR(8) NOT NULL,
  `Titulo_video` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Fecha_publicacion` DATE NOT NULL,
  `Duracion` INT NOT NULL,
  `Comentarios_ID_Comentario` INT NOT NULL,
  `Likes_ID_Like` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID_Video`),
  INDEX `fk_Videos_Comentarios1_idx` (`Comentarios_ID_Comentario` ASC) VISIBLE,
  INDEX `fk_Videos_Likes1_idx` (`Likes_ID_Like` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Comentarios1`
    FOREIGN KEY (`Comentarios_ID_Comentario`)
    REFERENCES `TikTok`.`Comentarios` (`ID_Comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_Likes1`
    FOREIGN KEY (`Likes_ID_Like`)
    REFERENCES `TikTok`.`Likes` (`ID_Like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Usuarios` (
  `ID_Usuario` VARCHAR(8) NOT NULL,
  `nombre_usuario` VARCHAR(8) NOT NULL,
  `correo_electronico` VARCHAR(20) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `pais_origen` VARCHAR(20) NOT NULL,
  `Videos_ID_Video` VARCHAR(30) NOT NULL,
  `Comentarios_ID_Comentario` INT NOT NULL,
  `Likes_ID_Like` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID_Usuario`),
  INDEX `fk_Usuarios_Videos_idx` (`Videos_ID_Video` ASC) VISIBLE,
  INDEX `fk_Usuarios_Comentarios1_idx` (`Comentarios_ID_Comentario` ASC) VISIBLE,
  INDEX `fk_Usuarios_Likes1_idx` (`Likes_ID_Like` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Videos`
    FOREIGN KEY (`Videos_ID_Video`)
    REFERENCES `TikTok`.`Videos` (`ID_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Comentarios1`
    FOREIGN KEY (`Comentarios_ID_Comentario`)
    REFERENCES `TikTok`.`Comentarios` (`ID_Comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Likes1`
    FOREIGN KEY (`Likes_ID_Like`)
    REFERENCES `TikTok`.`Likes` (`ID_Like`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Seguidores` (
  `ID_Seguidor` VARCHAR(8) NOT NULL,
  `ID_Usuario` INT NOT NULL,
  `ID_Seguido` VARCHAR(8) NOT NULL,
  `Fecha_seguimiento` DATE NOT NULL,
  PRIMARY KEY (`ID_Seguidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Usuarios_has_Seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Usuarios_has_Seguidores` (
  `Usuarios_ID_Usuario` VARCHAR(8) NOT NULL,
  `Seguidores_ID_Seguidor` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`Usuarios_ID_Usuario`, `Seguidores_ID_Seguidor`),
  INDEX `fk_Usuarios_has_Seguidores_Seguidores1_idx` (`Seguidores_ID_Seguidor` ASC) VISIBLE,
  INDEX `fk_Usuarios_has_Seguidores_Usuarios1_idx` (`Usuarios_ID_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_has_Seguidores_Usuarios1`
    FOREIGN KEY (`Usuarios_ID_Usuario`)
    REFERENCES `TikTok`.`Usuarios` (`ID_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Seguidores_Seguidores1`
    FOREIGN KEY (`Seguidores_ID_Seguidor`)
    REFERENCES `TikTok`.`Seguidores` (`ID_Seguidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE TikTok;

-- --------------------------
-- Tabla Usuarios
-- --------------------------
INSERT INTO Usuarios (ID_Usuario, nombre_usuario, correo_electronico, fecha_registro, pais_origen, Videos_ID_Video, Comentarios_ID_Comentario, Likes_ID_Like)
VALUES
('U001', 'ana123', 'ana@mail.com', '2023-05-01', 'España', 'V001', 1, 'L001'),
('U002', 'juan99', 'juan@mail.com', '2023-06-10', 'México', 'V002', 2, 'L002'),
('U003', 'maria77', 'maria@mail.com', '2023-07-15', 'Argentina', 'V003', 3, 'L003');

-- --------------------------
-- Tabla Videos
-- --------------------------
INSERT INTO Videos (ID_Video, ID_Usuario, Titulo_video, Descripcion, Fecha_publicacion, Duracion, Comentarios_ID_Comentario, Likes_ID_Like)
VALUES
('V001', 'U001', 'Bailando Salsa', 'Video de baile en grupo', '2023-06-01', 120, 1, 'L001'),
('V002', 'U002', 'Receta Pastel', 'Cómo hacer pastel de chocolate', '2023-06-05', 300, 2, 'L002'),
('V003', 'U003', 'Viaje a la playa', 'Vacaciones en Cancún', '2023-06-10', 180, 3, 'L003');

-- --------------------------
-- Tabla Comentarios
-- --------------------------
INSERT INTO Comentarios (ID_Comentario, ID_Video, ID_Usuario, Texto_comentario, Fecha_comentrario)
VALUES
(1, 'V001', 'U002', '¡Qué buen ritmo!', '2023-06-02'),
(2, 'V002', 'U003', 'Se ve delicioso 😋', '2023-06-06'),
(3, 'V003', 'U001', 'Qué envidia esas vacaciones', '2023-06-11');

-- --------------------------
-- Tabla Likes
-- --------------------------
INSERT INTO Likes (ID_Like, ID_Video, ID_Usuario, fecha_like)
VALUES
('L001', 'V001', 2, '2023-06-02'),
('L002', 'V002', 3, '2023-06-06'),
('L003', 'V003', 1, '2023-06-11');

-- --------------------------
-- Tabla Seguidores
-- --------------------------
INSERT INTO Seguidores (ID_Seguidor, ID_Usuario, ID_Seguido, Fecha_seguimiento)
VALUES
('S001', 1, 'U002', '2023-06-01'),
('S002', 2, 'U003', '2023-06-03'),
('S003', 3, 'U001', '2023-06-05');

-- --------------------------
-- Tabla Usuarios_has_Seguidores
-- --------------------------
INSERT INTO Usuarios_has_Seguidores (Usuarios_ID_Usuario, Seguidores_ID_Seguidor)
VALUES
('U001', 'S001'),
('U002', 'S002'),
('U003', 'S003');

select * from seguidores;