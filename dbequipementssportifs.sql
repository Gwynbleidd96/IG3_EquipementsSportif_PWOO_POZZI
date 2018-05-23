drop table if exists lot;
drop table if exists fournisseur;
drop table if exists elementspanier;
drop table if exists typearticle;
drop table if exists image;
drop table if exists categoriearticle;
drop table if exists panier;
drop table if exists persistable_user;

CREATE TABLE `persistable_user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `authorities` varchar(500) NOT NULL,
  `non_expired` tinyint(1) NOT NULL,
  `non_locked` tinyint(1) NOT NULL,
  `credentials_non_expired` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `mail` varchar(320) NOT NULL,
  `localite` varchar(45) NOT NULL,
  `rue` varchar(45) NOT NULL,
  `codepostal` int(9) NOT NULL,
  `numtelephone` int(13) DEFAULT NULL,
  `dateNaissance` date NOT NULL,
  `isMale` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `fournisseur` (
  `numeroTVA` int(10) NOT NULL,
  `localite` varchar(50) NOT NULL,
  `rue` varchar(50) NOT NULL,
  `codePostal` int(9) NOT NULL,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`numeroTVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `image` (
  `url` varchar(200) NOT NULL,
  `description_fr` varchar(200) NOT NULL,
  `description_en` varchar(200) NOT NULL,
  PRIMARY KEY (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `categoriearticle` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `libelle_fr` varchar(50) NOT NULL,
  `libelle_en` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `panier` (
  `numTicket` int(9) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `username_fk` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`numTicket`),
  KEY `fk_username` (`username_fk`),
  CONSTRAINT `fk_username` FOREIGN KEY (`username_fk`) REFERENCES `persistable_user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `typearticle` (
  `codeBarre` int(9) NOT NULL auto_increment,
  `libelle_fr` varchar(50) NOT NULL,
  `libelle_en` varchar(50) NOT NULL,
  `description_fr` varchar(200) NOT NULL,
  `description_en` varchar(200) DEFAULT NULL,
  `prix` double NOT NULL,
  `existeEnPlusieursTailles` tinyint(1) not null,
  `taille`	char(1) null,
  `id_categorie_fk` int(9) NOT NULL,
  `url_image_fk` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codeBarre`),
  KEY `fk_categorie` (`id_categorie_fk`),
  KEY `fk_image` (`url_image_fk`),
  CONSTRAINT `fk_categorie` FOREIGN KEY (`id_categorie_fk`) REFERENCES `categoriearticle` (`id`),
  CONSTRAINT `fk_image` FOREIGN KEY (`url_image_fk`) REFERENCES `image` (`url`)
) ENGINE=InnoDB auto_increment=1 CHARSET=utf8;

CREATE TABLE `lot` (
  `id`				int(9) not null auto_increment,
  `quantite`		int(10) not null,
  `dateFourniture`	date null,
  `dateCommande`	date not null,
  `numeroTVA_fk` 	int(10) not null,
  `codeBarre_fk`	int(9) not null,
  PRIMARY KEY (`id`),
  KEY `fk_numeroTVA` (`numeroTVA_fk`),
  KEY `fk_codeBarre_typearticle` (`codeBarre_fk`),
  CONSTRAINT `fk_numeroTVA` FOREIGN KEY (`numeroTVA_fk`) REFERENCES `fournisseur` (`numeroTVA`),
  CONSTRAINT `fk_codeBarre_typearticle` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`)
) ENGINE=InnoDB auto_increment=1 CHARSET=utf8;

CREATE TABLE `elementspanier` (
  `quantite`		int(10) not null,
  `prixReel`		double not null,
  `codeBarre_fk`	int(9) not null,
  `numTicket_fk`	int(9) not null,
  PRIMARY KEY (`codeBarre_fk`, `numTicket_fk`),
  KEY `fk_codeBarre` (`codeBarre_fk`),
  KEY `fk_numTicket` (`numTicket_fk`),
  CONSTRAINT `fk_codeBarre` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`),
  CONSTRAINT `fk_numTicket` FOREIGN KEY (`numTicket_fk`) REFERENCES `panier` (`numTicket`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `dbequipementssportifs`.`persistable_user`
(`username`,
`password`,
`authorities`,
`non_expired`,
`non_locked`,
`credentials_non_expired`,
`enabled`,
`nom`,
`prenom`,
`mail`,
`localite`,
`rue`,
`codepostal`,
`numtelephone`,
`dateNaissance`,
`isMale`)
VALUES
('Aless', '$2a$10$Y8dfdYBpUaJwWyPeyZxczOdJ6tIuIMm5Rss7.FVTZ5eRM8uNUBifS', 'ROLE_USER', 1, 1, 1, 1, 'POZZI', 'Alessandro', 'alessandro.pozzi72@gmail.com', 'Falmagne', 'Place du bati', 5500, 473227085, '1996-07-14', 1);

INSERT INTO `dbequipementssportifs`.`fournisseur`
(`numeroTVA`,
`localite`,
`rue`,
`codePostal`,
`nom`)
VALUES
(0112569874, 'Namur', 'Boulevard du nord', 5000, 'Futur Computer');

INSERT INTO `dbequipementssportifs`.`image`
(`url`,
`description_fr`,
`description_en`)
VALUES
('/images/articles/t-shirt.jpg', 'T-shirt pour courir', 'T-shirt for running'), ('/images/articles/benchPress', 'Banc de développé couché premium', 'Bench press premium'), ('/images/articles/basicbenchPress', 'Banc de développé couché basique', 'Basic bench press');

INSERT INTO `dbequipementssportifs`.`categoriearticle`
(`id`,
`libelle_fr`,
`libelle_en`)
VALUES
(null, 'Musculation', 'Bodybuilding'), (null, 'Crossfit', 'Crossfit');

INSERT INTO `dbequipementssportifs`.`panier`
(`numTicket`,
`date`,
`username_fk`)
VALUES
(null, sysdate(), 'Aless');

INSERT INTO `dbequipementssportifs`.`typearticle`
(`codeBarre`,
`libelle_fr`,
`libelle_en`,
`description_fr`,
`description_en`,
`prix`,
`existeEnPlusieursTailles`,
`taille`,
`id_categorie_fk`,
`url_image_fk`)
VALUES
(null, 'Banc de développer coucher premium', 'Bench press premium', 'Fait en cuir de haute qualité avec un aspect premium', 'Made of high quality leather with a premium look', 150, false, null, 1, '/images/articles/benchPress'), (null, 'T-shirt sport haute intensité', 'T-shirt high intensity sport', 'Créer spécialement pour le crossfit, ne se déchire pas après 3 entrainements', 'Create especially for the crossfit, do not tear after 3 trainings', 29.99, true, 'L', 2, '/images/articles/t-shirt.jpg'), (null, 'Banc de développer coucher basique', 'Basic bench press', 'Simple banc de DC pour commencer', 'Simple bench press for beginners', 99.99, false, null, 1, '/images/articles/basicbenchPress');

INSERT INTO `dbequipementssportifs`.`lot`
(`id`,
`quantite`,
`dateFourniture`,
`dateCommande`,
`numeroTVA_fk`,
`codeBarre_fk`)
VALUES
(null, 1500, null, '2018-02-25', 0112569874, 1);

INSERT INTO `dbequipementssportifs`.`elementspanier`
(`quantite`,
`prixReel`,
`codeBarre_fk`,
`numTicket_fk`)
VALUES
(20, 130.99, 1, 1);


select *
from categoriearticle;

