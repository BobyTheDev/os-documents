
CREATE TABLE `player_documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner` VARCHAR(45) NOT NULL,
  `data` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`)
  );
