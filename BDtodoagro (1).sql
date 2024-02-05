-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema todoagrobd
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `todoagrobd` ;

-- -----------------------------------------------------
-- Schema todoagrobd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `todoagrobd` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `todoagrobd`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`usuario` (
  `usu_usuarioid` INT(11) NOT NULL AUTO_INCREMENT,
  `usu_tipodocumento` VARCHAR(45) NULL DEFAULT NULL,
  `usu_numerodocumento` BIGINT(12) NULL DEFAULT NULL,
  `usu_nombres` VARCHAR(45) NULL DEFAULT NULL,
  `usu_apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `usu_correo` VARCHAR(45) NULL DEFAULT NULL,
  `usu_clave` VARCHAR(45) NULL DEFAULT NULL,
  `usu_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `usu_direccion` VARCHAR(45) NULL DEFAULT NULL,
  `usu_estado` TINYINT(4) NULL DEFAULT 1,
  PRIMARY KEY (`usu_usuarioid`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`pqrs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pqrs` (
  `idpqrs` INT NOT NULL AUTO_INCREMENT,
  `codigo_radicado` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `usuario_usu_usuarioid` INT(11) NOT NULL,
  `ciudad` VARCHAR(45) NULL,
  PRIMARY KEY (`idpqrs`),
  INDEX `fk_pqrs_usuario_idx` (`usuario_usu_usuarioid` ASC) ,
  CONSTRAINT `fk_pqrs_usuario`
    FOREIGN KEY (`usuario_usu_usuarioid`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pqrs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pqrs` (
  `idtipo_pqrs` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo_pqrs`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pqrs_has_pqrs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pqrs_has_pqrs` (
  `tipo_pqrs_idtipo_pqrs` INT NOT NULL,
  `pqrs_idpqrs` INT NOT NULL,
  PRIMARY KEY (`tipo_pqrs_idtipo_pqrs`, `pqrs_idpqrs`),
  INDEX `fk_tipo_pqrs_has_pqrs_pqrs1_idx` (`pqrs_idpqrs` ASC) ,
  INDEX `fk_tipo_pqrs_has_pqrs_tipo_pqrs1_idx` (`tipo_pqrs_idtipo_pqrs` ASC) ,
  CONSTRAINT `fk_tipo_pqrs_has_pqrs_tipo_pqrs1`
    FOREIGN KEY (`tipo_pqrs_idtipo_pqrs`)
    REFERENCES `mydb`.`tipo_pqrs` (`idtipo_pqrs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_pqrs_has_pqrs_pqrs1`
    FOREIGN KEY (`pqrs_idpqrs`)
    REFERENCES `mydb`.`pqrs` (`idpqrs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `todoagrobd` ;

-- -----------------------------------------------------
-- Table `todoagrobd`.`bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`bodega` (
  `bdg_bodegaid` INT(11) NOT NULL AUTO_INCREMENT,
  `bdg_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `bdg_direccion` VARCHAR(255) NULL DEFAULT NULL,
  `bdg_telefono` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`bdg_bodegaid`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`categoria` (
  `cat_categoriaid` INT(11) NOT NULL AUTO_INCREMENT,
  `cat_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `cat_descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`cat_categoriaid`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`factura` (
  `fac_facturaid` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_vendedor` INT(11) NULL DEFAULT NULL,
  `fk_cliente` INT(11) NULL DEFAULT NULL,
  `fac_fecha` DATE NULL DEFAULT NULL,
  `fac_totalproductos` INT(11) NULL DEFAULT NULL,
  `fac_valortotal` DOUBLE NULL DEFAULT NULL,
  `fac_impuestos` DOUBLE NULL DEFAULT NULL,
  `fac_dirrecionentrega` VARCHAR(255) NULL DEFAULT NULL,
  `fac_telefono` VARCHAR(30) NULL DEFAULT NULL,
  `fac_ciudad` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`fac_facturaid`),
  INDEX `fk_vendedorf_idx` (`fk_vendedor` ASC) ,
  INDEX `fk_clientef_idx` (`fk_cliente` ASC) ,
  CONSTRAINT `fk_clientef`
    FOREIGN KEY (`fk_cliente`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendedorf`
    FOREIGN KEY (`fk_vendedor`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`producto` (
  `pdt_productoid` INT(11) NOT NULL AUTO_INCREMENT,
  `pdt_nombre` VARCHAR(255) NULL DEFAULT NULL,
  `pdt_descripcion` VARCHAR(255) NULL DEFAULT NULL,
  `pdt_valorventa` DOUBLE NULL DEFAULT NULL,
  `fk_categoria` INT(11) NULL DEFAULT NULL,
  `pdt_total` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`pdt_productoid`),
  INDEX `fk_categoriap_idx` (`fk_categoria` ASC) ,
  CONSTRAINT `fk_categoriap`
    FOREIGN KEY (`fk_categoria`)
    REFERENCES `todoagrobd`.`categoria` (`cat_categoriaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`factura_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`factura_producto` (
  `fpt_facturaproductoid` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_factura` INT(11) NULL DEFAULT NULL,
  `fk_producto` INT(11) NULL DEFAULT NULL,
  `fpt_valorunidad` DOUBLE NULL DEFAULT NULL,
  `fpt_cantidad` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`fpt_facturaproductoid`),
  INDEX `fk_facturaf_idx` (`fk_factura` ASC) ,
  INDEX `fk_producto_idx` (`fk_producto` ASC) ,
  CONSTRAINT `fk_facturaf`
    FOREIGN KEY (`fk_factura`)
    REFERENCES `todoagrobd`.`factura` (`fac_facturaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto`
    FOREIGN KEY (`fk_producto`)
    REFERENCES `todoagrobd`.`producto` (`pdt_productoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`ordencompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`ordencompra` (
  `odc_ordencompraid` INT(11) NOT NULL AUTO_INCREMENT,
  `odc_ordennumero` VARCHAR(45) NULL DEFAULT NULL,
  `odc_catidad` INT(11) NULL DEFAULT NULL,
  `odc_valorcompra` DOUBLE NULL DEFAULT NULL,
  `odc_novedad` VARCHAR(255) NULL DEFAULT NULL,
  `odc_fecha_ingreso` DATE NULL DEFAULT NULL,
  `fk_operario` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`odc_ordencompraid`),
  INDEX `fk_operario_idx` (`fk_operario` ASC) ,
  CONSTRAINT `fk_operario`
    FOREIGN KEY (`fk_operario`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`ordencompra_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`ordencompra_producto` (
  `orp_ordencompraproductoid` INT(11) NOT NULL AUTO_INCREMENT,
  `orp_cantidad` INT(11) NULL DEFAULT NULL,
  `orp_valorcompra` DOUBLE NULL DEFAULT NULL,
  `fk_producto` INT(11) NULL DEFAULT NULL,
  `fk_proveedor` INT(11) NULL DEFAULT NULL,
  `fk_bodega` INT(11) NULL DEFAULT NULL,
  `fk_ordencompra` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`orp_ordencompraproductoid`),
  INDEX `fk_producto_idx` (`fk_producto` ASC) ,
  INDEX `fk_proveedoro_idx` (`fk_proveedor` ASC) ,
  INDEX `fk_bodegao_idx` (`fk_bodega` ASC) ,
  INDEX `fk_ordencomprao_idx` (`fk_ordencompra` ASC) ,
  CONSTRAINT `fk_bodegao`
    FOREIGN KEY (`fk_bodega`)
    REFERENCES `todoagrobd`.`bodega` (`bdg_bodegaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordencomprao`
    FOREIGN KEY (`fk_ordencompra`)
    REFERENCES `todoagrobd`.`ordencompra` (`odc_ordencompraid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productoo`
    FOREIGN KEY (`fk_producto`)
    REFERENCES `todoagrobd`.`producto` (`pdt_productoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedoro`
    FOREIGN KEY (`fk_proveedor`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`rol` (
  `rol_rolid` INT(11) NOT NULL AUTO_INCREMENT,
  `rol_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `rol_descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`rol_rolid`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `todoagrobd`.`usuario_has_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todoagrobd`.`usuario_has_rol` (
  `fk_usuarioid` INT(11) NULL DEFAULT NULL,
  `fk_rolid` INT(11) NULL DEFAULT NULL,
  INDEX `fk_usu_idx` (`fk_usuarioid` ASC) ,
  INDEX `fk_rol_idx` (`fk_rolid` ASC) ,
  CONSTRAINT `fk_rol`
    FOREIGN KEY (`fk_rolid`)
    REFERENCES `todoagrobd`.`rol` (`rol_rolid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usu`
    FOREIGN KEY (`fk_usuarioid`)
    REFERENCES `todoagrobd`.`usuario` (`usu_usuarioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;