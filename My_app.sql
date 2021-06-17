-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PanoramicCars
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PanoramicCars
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PanoramicCars` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema2
-- -----------------------------------------------------
USE `PanoramicCars` ;

-- -----------------------------------------------------
-- Table `PanoramicCars`.`CustomerContactInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`CustomerContactInfo` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_Name` VARCHAR(45) NOT NULL,
  `Phone_Number` CHAR(10) NOT NULL,
  `Contact_LastName` VARCHAR(45) NOT NULL,
  `Contact_FirstName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`Territories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`Territories` (
  `Territory_ID` INT NOT NULL AUTO_INCREMENT,
  `Territory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Territory_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`Countries` (
  `Country_ID` INT NOT NULL AUTO_INCREMENT,
  `Country` CHAR(2) NOT NULL,
  `Territory_ID` INT NOT NULL,
  PRIMARY KEY (`Country_ID`),
  INDEX `Territory_ID_idx` (`Territory_ID` ASC) VISIBLE,
  CONSTRAINT `Territory_ID`
    FOREIGN KEY (`Territory_ID`)
    REFERENCES `PanoramicCars`.`Territories` (`Territory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`CustomerDeliveryInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`CustomerDeliveryInfo` (
  `Delivery_ID` INT NOT NULL,
  `Address_Line1` VARCHAR(100) NOT NULL,
  `Address_Line2` VARCHAR(100) NULL,
  `City` VARCHAR(50) NOT NULL,
  `State` CHAR(2) NOT NULL,
  `Postal_Code` CHAR(10) NOT NULL,
  `Country_ID` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`Delivery_ID`),
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Country_ID_idx` (`Country_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `PanoramicCars`.`CustomerContactInfo` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Country_ID`
    FOREIGN KEY (`Country_ID`)
    REFERENCES `PanoramicCars`.`Countries` (`Country_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`ProductData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`ProductData` (
  `Product_ID` INT NOT NULL,
  `Product_Line` VARCHAR(50) NULL,
  `Product_Code` INT NULL,
  `Deal_Size` INT NULL,
  `MSRP` VARCHAR(10) NULL,
  `Price_Each` VARCHAR(10) NULL,
  PRIMARY KEY (`Product_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`OrderInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`OrderInfo` (
  `Order_ID` INT NOT NULL,
  `Order_Number` INT NOT NULL,
  `Quantity_Ordered` INT NOT NULL,
  `Order_LineNumber` INT NOT NULL,
  `Order_Date` DATE NOT NULL,
  `Status` VARCHAR(20) NOT NULL,
  `Delivery_ID` INT NOT NULL,
  `Product_ID` INT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Delivery_ID_idx` (`Delivery_ID` ASC) VISIBLE,
  INDEX `Product_ID_idx` (`Product_ID` ASC) VISIBLE,
  CONSTRAINT `Delivery_ID`
    FOREIGN KEY (`Delivery_ID`)
    REFERENCES `PanoramicCars`.`CustomerDeliveryInfo` (`Delivery_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Product_ID`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `PanoramicCars`.`ProductData` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`Month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`Month` (
  `Month_ID` INT NOT NULL,
  `Month` CHAR(3) NOT NULL,
  PRIMARY KEY (`Month_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`Year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`Year` (
  `Year_ID` INT NOT NULL,
  `Year` CHAR(10) NOT NULL,
  PRIMARY KEY (`Year_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`Quarter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`Quarter` (
  `OTR_ID` INT NOT NULL,
  `Quarter` CHAR(1) NULL,
  PRIMARY KEY (`OTR_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PanoramicCars`.`SalesDate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PanoramicCars`.`SalesDate` (
  `Sales_ID` INT NOT NULL,
  `Sales` INT NULL,
  `Month_ID` INT NULL,
  `Year_ID` INT NULL,
  `QTR_ID` INT NULL,
  `Order_ID` INT NOT NULL,
  PRIMARY KEY (`Sales_ID`),
  INDEX `Month_ID_idx` (`Month_ID` ASC) VISIBLE,
  INDEX `Year_ID_idx` (`Year_ID` ASC) VISIBLE,
  INDEX `QTR_ID_idx` (`QTR_ID` ASC) VISIBLE,
  INDEX `Order_ID_idx` (`Order_ID` ASC) VISIBLE,
  CONSTRAINT `Month_ID`
    FOREIGN KEY (`Month_ID`)
    REFERENCES `PanoramicCars`.`Month` (`Month_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Year_ID`
    FOREIGN KEY (`Year_ID`)
    REFERENCES `PanoramicCars`.`Year` (`Year_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `QTR_ID`
    FOREIGN KEY (`QTR_ID`)
    REFERENCES `PanoramicCars`.`Quarter` (`OTR_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `PanoramicCars`.`OrderInfo` (`Order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
