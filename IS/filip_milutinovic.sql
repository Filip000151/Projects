-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`vaspitac`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`vaspitac` ;

CREATE TABLE IF NOT EXISTS `mydb`.`vaspitac` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(25) NOT NULL,
  `prezime` VARCHAR(25) NOT NULL,
  `broj_telefona` CHAR(10) NOT NULL,
  `adresa` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `broj_telefona_UNIQUE` (`broj_telefona` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dogadjaji`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`dogadjaji` ;

CREATE TABLE IF NOT EXISTS `mydb`.`dogadjaji` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `datum` VARCHAR(20) NOT NULL,
  `vaspitac_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dogadjaji_vaspitac_idx` (`vaspitac_id` ASC) ,
  CONSTRAINT `fk_dogadjaji_vaspitac`
    FOREIGN KEY (`vaspitac_id`)
    REFERENCES `mydb`.`vaspitac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`srodstvo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`srodstvo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`srodstvo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv_srodstva` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `naziv_srodstva_UNIQUE` (`naziv_srodstva` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staratelj`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staratelj` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staratelj` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(25) NOT NULL,
  `prezime` VARCHAR(25) NOT NULL,
  `broj_telefona` CHAR(10) NOT NULL,
  `srodstvo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `broj_telefona_UNIQUE` (`broj_telefona` ASC) ,
  INDEX `fk_staratelj_srodstvo1_idx` (`srodstvo_id` ASC) ,
  CONSTRAINT `fk_staratelj_srodstvo1`
    FOREIGN KEY (`srodstvo_id`)
    REFERENCES `mydb`.`srodstvo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sastanak`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sastanak` ;

CREATE TABLE IF NOT EXISTS `mydb`.`sastanak` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `vreme` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`zakazani_sastanci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`zakazani_sastanci` ;

CREATE TABLE IF NOT EXISTS `mydb`.`zakazani_sastanci` (
  `sastanak_id` INT NOT NULL,
  `vaspitac_id` INT NOT NULL,
  `staratelj_id` INT NOT NULL,
  INDEX `fk_zakazani_sastanci_sastanak1_idx` (`sastanak_id` ASC) ,
  INDEX `fk_zakazani_sastanci_vaspitac1_idx` (`vaspitac_id` ASC) ,
  INDEX `fk_zakazani_sastanci_staratelj1_idx` (`staratelj_id` ASC) ,
  PRIMARY KEY (`sastanak_id`, `vaspitac_id`, `staratelj_id`),
  CONSTRAINT `fk_zakazani_sastanci_sastanak1`
    FOREIGN KEY (`sastanak_id`)
    REFERENCES `mydb`.`sastanak` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zakazani_sastanci_vaspitac1`
    FOREIGN KEY (`vaspitac_id`)
    REFERENCES `mydb`.`vaspitac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zakazani_sastanci_staratelj1`
    FOREIGN KEY (`staratelj_id`)
    REFERENCES `mydb`.`staratelj` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`soba`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`soba` ;

CREATE TABLE IF NOT EXISTS `mydb`.`soba` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `broj_sobe` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `broj_sobe_UNIQUE` (`broj_sobe` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dnevne_aktivnosti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`dnevne_aktivnosti` ;

CREATE TABLE IF NOT EXISTS `mydb`.`dnevne_aktivnosti` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(50) NOT NULL,
  `vreme` VARCHAR(15) NOT NULL,
  `vaspitac_id` INT NOT NULL,
  `soba_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dnevne_aktivnosti_vaspitac1_idx` (`vaspitac_id` ASC) ,
  INDEX `fk_dnevne_aktivnosti_soba1_idx` (`soba_id` ASC) ,
  CONSTRAINT `fk_dnevne_aktivnosti_vaspitac1`
    FOREIGN KEY (`vaspitac_id`)
    REFERENCES `mydb`.`vaspitac` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dnevne_aktivnosti_soba1`
    FOREIGN KEY (`soba_id`)
    REFERENCES `mydb`.`soba` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pol` ;

CREATE TABLE IF NOT EXISTS `mydb`.`pol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pol` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pol_UNIQUE` (`pol` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dete`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`dete` ;

CREATE TABLE IF NOT EXISTS `mydb`.`dete` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(25) NOT NULL,
  `prezime` VARCHAR(25) NOT NULL,
  `datum_rodjenja` DATE NOT NULL,
  `pol_id` INT NOT NULL,
  `staratelj_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dete_pol1_idx` (`pol_id` ASC) ,
  INDEX `fk_dete_staratelj1_idx` (`staratelj_id` ASC) ,
  CONSTRAINT `fk_dete_pol1`
    FOREIGN KEY (`pol_id`)
    REFERENCES `mydb`.`pol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dete_staratelj1`
    FOREIGN KEY (`staratelj_id`)
    REFERENCES `mydb`.`staratelj` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status_prisutnosti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status_prisutnosti` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status_prisutnosti` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prisustvo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`prisustvo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`prisustvo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dete_id` INT NOT NULL,
  `dnevne_aktivnosti_id` INT NOT NULL,
  `status_prisutnosti_id` INT NOT NULL,
  `datum` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prisustvo_dete1_idx` (`dete_id` ASC) ,
  INDEX `fk_prisustvo_dnevne_aktivnosti1_idx` (`dnevne_aktivnosti_id` ASC) ,
  INDEX `fk_prisustvo_status_prisutnosti1_idx` (`status_prisutnosti_id` ASC) ,
  CONSTRAINT `fk_prisustvo_dete1`
    FOREIGN KEY (`dete_id`)
    REFERENCES `mydb`.`dete` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prisustvo_dnevne_aktivnosti1`
    FOREIGN KEY (`dnevne_aktivnosti_id`)
    REFERENCES `mydb`.`dnevne_aktivnosti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prisustvo_status_prisutnosti1`
    FOREIGN KEY (`status_prisutnosti_id`)
    REFERENCES `mydb`.`status_prisutnosti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`skolarina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`skolarina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`skolarina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rate` VARCHAR(10) NOT NULL,
  `cena` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rate_UNIQUE` (`rate` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`nacin_placanja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`nacin_placanja` ;

CREATE TABLE IF NOT EXISTS `mydb`.`nacin_placanja` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nacin_placanja` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nacin_placanja_UNIQUE` (`nacin_placanja` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`racun`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`racun` ;

CREATE TABLE IF NOT EXISTS `mydb`.`racun` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nacin_placanja_id` INT NOT NULL,
  `staratelj_id` INT NOT NULL,
  `datum_izdavanja` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_racun_nacin_placanja1_idx` (`nacin_placanja_id` ASC) ,
  INDEX `fk_racun_staratelj1_idx` (`staratelj_id` ASC) ,
  CONSTRAINT `fk_racun_nacin_placanja1`
    FOREIGN KEY (`nacin_placanja_id`)
    REFERENCES `mydb`.`nacin_placanja` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_racun_staratelj1`
    FOREIGN KEY (`staratelj_id`)
    REFERENCES `mydb`.`staratelj` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stavka_racuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`stavka_racuna` ;

CREATE TABLE IF NOT EXISTS `mydb`.`stavka_racuna` (
  `skolarina_id` INT NOT NULL,
  `racun_id` INT NOT NULL,
  `cena` FLOAT NOT NULL,
  PRIMARY KEY (`skolarina_id`, `racun_id`),
  INDEX `fk_stavka_racuna_racun1_idx` (`racun_id` ASC) ,
  CONSTRAINT `fk_stavka_racuna_skolarina1`
    FOREIGN KEY (`skolarina_id`)
    REFERENCES `mydb`.`skolarina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stavka_racuna_racun1`
    FOREIGN KEY (`racun_id`)
    REFERENCES `mydb`.`racun` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`vaspitac`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`vaspitac` (`id`, `ime`, `prezime`, `broj_telefona`, `adresa`) VALUES (1, 'Pera', 'Mikic', '0643124536', 'Sulejiceva 7, Smederevska Palanka');
INSERT INTO `mydb`.`vaspitac` (`id`, `ime`, `prezime`, `broj_telefona`, `adresa`) VALUES (2, 'Sonja', 'Gavrilovic', '0621325435', 'Bregalnicka 4, Smederevska Palanka');
INSERT INTO `mydb`.`vaspitac` (`id`, `ime`, `prezime`, `broj_telefona`, `adresa`) VALUES (3, 'Jelena', 'Pesic', '0653158599', 'Dragutina Milutinovica 3, Beograd');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`dogadjaji`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`dogadjaji` (`id`, `naziv`, `datum`, `vaspitac_id`) VALUES (1, 'Izlet', '12/07', 3);
INSERT INTO `mydb`.`dogadjaji` (`id`, `naziv`, `datum`, `vaspitac_id`) VALUES (2, 'Priredba', '27/09', 1);
INSERT INTO `mydb`.`dogadjaji` (`id`, `naziv`, `datum`, `vaspitac_id`) VALUES (3, 'Ekskurzija', '29/12', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`srodstvo`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`srodstvo` (`id`, `naziv_srodstva`) VALUES (1, 'Otac');
INSERT INTO `mydb`.`srodstvo` (`id`, `naziv_srodstva`) VALUES (2, 'Majka');
INSERT INTO `mydb`.`srodstvo` (`id`, `naziv_srodstva`) VALUES (3, 'Drugo');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`staratelj`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`staratelj` (`id`, `ime`, `prezime`, `broj_telefona`, `srodstvo_id`) VALUES (1, 'Petar', 'Djokic', '0654312414', 1);
INSERT INTO `mydb`.`staratelj` (`id`, `ime`, `prezime`, `broj_telefona`, `srodstvo_id`) VALUES (2, 'Snezana', 'Jeremic', '0603158599', 2);
INSERT INTO `mydb`.`staratelj` (`id`, `ime`, `prezime`, `broj_telefona`, `srodstvo_id`) VALUES (3, 'Novica', 'Karaklic', '0632124423', 1);
INSERT INTO `mydb`.`staratelj` (`id`, `ime`, `prezime`, `broj_telefona`, `srodstvo_id`) VALUES (4, 'Darko', 'Stankovic', '0613727334', 3);
INSERT INTO `mydb`.`staratelj` (`id`, `ime`, `prezime`, `broj_telefona`, `srodstvo_id`) VALUES (5, 'Bojana', 'Vuckovic', '0646735525', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`sastanak`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`sastanak` (`id`, `datum`, `vreme`) VALUES (1, '2023-11-12', '11:00');
INSERT INTO `mydb`.`sastanak` (`id`, `datum`, `vreme`) VALUES (2, '2023-11-5', '12:00');
INSERT INTO `mydb`.`sastanak` (`id`, `datum`, `vreme`) VALUES (3, '2023-10-17', '10:00');
INSERT INTO `mydb`.`sastanak` (`id`, `datum`, `vreme`) VALUES (4, '2023-10-26', '11:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`zakazani_sastanci`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`zakazani_sastanci` (`sastanak_id`, `vaspitac_id`, `staratelj_id`) VALUES (4, 2, 1);
INSERT INTO `mydb`.`zakazani_sastanci` (`sastanak_id`, `vaspitac_id`, `staratelj_id`) VALUES (3, 3, 1);
INSERT INTO `mydb`.`zakazani_sastanci` (`sastanak_id`, `vaspitac_id`, `staratelj_id`) VALUES (2, 1, 3);
INSERT INTO `mydb`.`zakazani_sastanci` (`sastanak_id`, `vaspitac_id`, `staratelj_id`) VALUES (1, 3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`soba`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`soba` (`id`, `broj_sobe`) VALUES (1, 1);
INSERT INTO `mydb`.`soba` (`id`, `broj_sobe`) VALUES (2, 2);
INSERT INTO `mydb`.`soba` (`id`, `broj_sobe`) VALUES (3, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`dnevne_aktivnosti`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`dnevne_aktivnosti` (`id`, `naziv`, `vreme`, `vaspitac_id`, `soba_id`) VALUES (1, 'Prijem dece u vrtic', '07:00-08:00', 3, 2);
INSERT INTO `mydb`.`dnevne_aktivnosti` (`id`, `naziv`, `vreme`, `vaspitac_id`, `soba_id`) VALUES (2, 'Obrazovne aktivnosti', '08:00-10:00', 1, 1);
INSERT INTO `mydb`.`dnevne_aktivnosti` (`id`, `naziv`, `vreme`, `vaspitac_id`, `soba_id`) VALUES (3, 'Priprema za uzinu i uzina', '10:00-10:30', 2, 3);
INSERT INTO `mydb`.`dnevne_aktivnosti` (`id`, `naziv`, `vreme`, `vaspitac_id`, `soba_id`) VALUES (4, 'Obrazovne aktivnosti uz boravak na svezem vazduhu', '10:30-11:45', 1, 1);
INSERT INTO `mydb`.`dnevne_aktivnosti` (`id`, `naziv`, `vreme`, `vaspitac_id`, `soba_id`) VALUES (5, 'Ispracaj dece kuci', '11:45-12:00', 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`pol`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`pol` (`id`, `pol`) VALUES (1, 'Musko');
INSERT INTO `mydb`.`pol` (`id`, `pol`) VALUES (2, 'Zensko');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`dete`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (1, 'Milos', 'Karaklic', '2021-12-4', 1, 3);
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (2, 'Stefan', 'Djokic', '2020-3-12', 1, 1);
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (3, 'Milica', 'Mrnjancevic', '2020-9-11', 2, 4);
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (4, 'Jovana', 'Vuckovic', '2021-5-26', 2, 5);
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (5, 'Petar', 'Jeremic', '2021-1-17', 1, 2);
INSERT INTO `mydb`.`dete` (`id`, `ime`, `prezime`, `datum_rodjenja`, `pol_id`, `staratelj_id`) VALUES (6, 'Aleksandra', 'Djokic', '2021-6-13', 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`status_prisutnosti`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`status_prisutnosti` (`id`, `status`) VALUES (1, 'Prisutan');
INSERT INTO `mydb`.`status_prisutnosti` (`id`, `status`) VALUES (2, 'Odsutan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`prisustvo`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (1, 1, 3, 2, '2023-4-16');
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (2, 1, 4, 1, '2023-6-29');
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (3, 2, 4, 1, '2023-7-19');
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (4, 4, 2, 1, '2023-7-26');
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (5, 5, 2, 2, '2023-3-22');
INSERT INTO `mydb`.`prisustvo` (`id`, `dete_id`, `dnevne_aktivnosti_id`, `status_prisutnosti_id`, `datum`) VALUES (6, 1, 2, 1, '2023-8-17');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`skolarina`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`skolarina` (`id`, `rate`, `cena`) VALUES (1, 'Prva', 15);
INSERT INTO `mydb`.`skolarina` (`id`, `rate`, `cena`) VALUES (2, 'Druga', 20);
INSERT INTO `mydb`.`skolarina` (`id`, `rate`, `cena`) VALUES (3, 'Treca', 25);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`nacin_placanja`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`nacin_placanja` (`id`, `nacin_placanja`) VALUES (1, 'Kes');
INSERT INTO `mydb`.`nacin_placanja` (`id`, `nacin_placanja`) VALUES (2, 'Kartica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`racun`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`racun` (`id`, `nacin_placanja_id`, `staratelj_id`, `datum_izdavanja`) VALUES (1, 2, 1, '2023-11-20');
INSERT INTO `mydb`.`racun` (`id`, `nacin_placanja_id`, `staratelj_id`, `datum_izdavanja`) VALUES (2, 1, 3, '2023-9-19');
INSERT INTO `mydb`.`racun` (`id`, `nacin_placanja_id`, `staratelj_id`, `datum_izdavanja`) VALUES (3, 2, 2, '2023-10-21');
INSERT INTO `mydb`.`racun` (`id`, `nacin_placanja_id`, `staratelj_id`, `datum_izdavanja`) VALUES (4, 2, 5, '2023-11-7');
INSERT INTO `mydb`.`racun` (`id`, `nacin_placanja_id`, `staratelj_id`, `datum_izdavanja`) VALUES (5, 1, 4, '2023-10-6');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`stavka_racuna`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (1, 1, 15);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (1, 2, 15);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (1, 3, 15);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (1, 5, 15);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (2, 1, 20);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (2, 3, 20);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (3, 1, 25);
INSERT INTO `mydb`.`stavka_racuna` (`skolarina_id`, `racun_id`, `cena`) VALUES (3, 4, 25);

COMMIT;

