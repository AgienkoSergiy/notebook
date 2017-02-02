CREATE TABLE IF NOT EXISTS `notebook`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `age` INT NULL,
  `gender` VARCHAR(1) NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`id`));