drop table if exists lignecommande;
drop table if exists image;
drop table if exists disponible;
drop table if exists disponibleEnCouleur;
drop table if exists TranslationArticle;
drop table if exists TranslationCategorie;
drop table if exists TranslationCouleur;
drop table if exists Taille;
drop table if exists Langage;
drop table if exists Couleur;
drop table if exists typearticle;
drop table if exists categoriearticle;
drop table if exists commande;
drop table if exists client;

CREATE TABLE `client` (
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `authorities` varchar(500) NOT NULL,
  `non_expired` tinyint(1) NOT NULL,
  `non_locked` tinyint(1) NOT NULL,
  `credentials_non_expired` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `mail` varchar(320) NOT NULL unique,
  `localite` varchar(45) NOT NULL,
  `rue` varchar(45) NOT NULL,
  `codepostal` int(9) NOT NULL,
  `numtelephone` int(13) DEFAULT NULL,
  `dateNaissance` date NOT NULL,
  `isMale` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `categoriearticle` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `url_image`	varchar(200) not null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB auto_increment=1 CHARSET=utf8;

CREATE TABLE `Taille` (
  `tailleArticle`		varchar(4) not null,
  PRIMARY KEY (`tailleArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Couleur` (
	`ID`	INT(9) not null auto_increment,
    primary key (`ID`)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHARSET=utf8;

CREATE TABLE `Langage` (
	`langageID`		varchar(6) not null,
    primary key (`langageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `commande` (
  `numTicket` int(9) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL,
  `username_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`numTicket`),
  CONSTRAINT `fk_username` FOREIGN KEY (`username_fk`) REFERENCES `client` (`username`)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHARSET=utf8;

CREATE TABLE `typearticle` (
  `codeBarre` int(9) NOT NULL auto_increment,
  `prix` double NOT NULL,
  `id_categorie_fk` int(9) NOT NULL,
  PRIMARY KEY (`codeBarre`),
  CONSTRAINT `fk_categorie` FOREIGN KEY (`id_categorie_fk`) REFERENCES `categoriearticle` (`id`),
  check (`prix` >=0)
) ENGINE=InnoDB auto_increment=1 CHARSET=utf8;

CREATE TABLE `image` (
  `url` 			varchar(200) NOT NULL,
  `codeBarre_fk`	INT(9) not null,
  PRIMARY KEY (`url`),
  CONSTRAINT `FK_CodeBarre_img` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Disponible` (
  `taille_fk`		varchar(4) not null,
  `codeBarre_fk`	INT(9) not null,
  PRIMARY KEY (`taille_fk`, `codeBarre_fk`),
  CONSTRAINT `fk_taille` FOREIGN KEY (`taille_fk`) REFERENCES `Taille` (`tailleArticle`),
  CONSTRAINT `fk_codeBarre_Dispo` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `DisponibleEnCouleur` (
  `couleur_fk`		INT(9) not null,
  `codeBarre_fk`	INT(9) not null,
  PRIMARY KEY (`couleur_fk`, `codeBarre_fk`),
  CONSTRAINT `fk_couleur` FOREIGN KEY (`couleur_fk`) REFERENCES `Couleur` (`id`),
  CONSTRAINT `fk_codeBarre_DispoCouleur` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TranslationArticle` (
	`langageID_FK`	varchar(6) not null,
    `codeBarre_FK` 	INT(9) not null,
    `libelle`		varchar(200) not null,
    `description`	varchar(400) not null,
    primary key (`langageID_FK`, `codeBarre_FK`),
	CONSTRAINT `fk_langageID_Article` FOREIGN KEY (`langageID_FK`) REFERENCES `Langage` (`langageID`),
	CONSTRAINT `fk_codeBarre_TranslationArticle` FOREIGN KEY (`codeBarre_FK`) REFERENCES `typearticle` (`codeBarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TranslationCategorie` (
	`langageID_FK`	varchar(6) not null,
    `idCategorie_FK` 	INT(9) not null,
    `libelle`		varchar(200) not null,
    primary key (`langageID_FK`, `idCategorie_FK`),
	CONSTRAINT `fk_langageID_Categorie` FOREIGN KEY (`langageID_FK`) REFERENCES `Langage` (`langageID`),
	CONSTRAINT `fk_idCategorie_TranslationArticle` FOREIGN KEY (`idCategorie_FK`) REFERENCES `categoriearticle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TranslationCouleur` (
	`langageID_FK`	varchar(6) not null,
    `idCouleur_FK` 	INT(9) not null,
    `libelle`		varchar(200) not null,
    primary key (`langageID_FK`, `idCouleur_FK`),
	CONSTRAINT `fk_langageID_Couleur` FOREIGN KEY (`langageID_FK`) REFERENCES `Langage` (`langageID`),
	CONSTRAINT `fk_idCouleur_TranslationCouleur` FOREIGN KEY (`idCouleur_FK`) REFERENCES `Couleur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lignecommande` (
  `quantite`		int(9) not null,
  `prixReel`		double not null,
  `codeBarre_fk`	int(9) not null,
  `numTicket_fk`	int(9) not null,
  `taille_fk`		varchar(4),
  `couleur_fk`		int(9),
  PRIMARY KEY (`codeBarre_fk`, `numTicket_fk`),
  CONSTRAINT `fk_codeBarre_commande` FOREIGN KEY (`codeBarre_fk`) REFERENCES `typearticle` (`codeBarre`),
  CONSTRAINT `fk_numTicket` FOREIGN KEY (`numTicket_fk`) REFERENCES `commande` (`numTicket`),
  CONSTRAINT `fk_taille_ligneCommande` FOREIGN KEY (`taille_fk`) REFERENCES `taille` (`tailleArticle`),
  CONSTRAINT `fk_couleur_ligneCommande` FOREIGN KEY (`couleur_fk`) REFERENCES `couleur` (`ID`),
  check (`quantite` >= 0),
  check (`prixReel` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `dbequipementssportifs`.`client`
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
('Aless', '$2a$10$Y8dfdYBpUaJwWyPeyZxczOdJ6tIuIMm5Rss7.FVTZ5eRM8uNUBifS', 'ROLE_ADMIN', 1, 1, 1, 1, 'POZZI', 'Alessandro', 'alessandro.pozzi72@gmail.com', 'Falmagne', 'Place du bati', 5500, 473227085, '1996-07-14', 1),
('ConstentinDu06', '$2a$10$NsXhCQOsLGt8x6zZiHKWZuOMah4pWOHHN2B6a5btHOwAx3vT4HuB2', 'ROLE_USER', 1, 1, 1, 1, 'PENEURE', 'Constentin', 'constentin@gmail.com', 'Grenoble', 'Rue du mimosa', 7413, NULL, '2003-07-05', 1);

INSERT INTO `dbequipementssportifs`.`langage`
(`langageID`)
VALUES
('fr'), ('en');

INSERT INTO `dbequipementssportifs`.`categoriearticle`
(`id`,
`url_image`)
VALUES
(null, '/images/categories/musculation.jpg'),
(null, '/images/categories/course.jpg'),
(null, '/images/categories/velo.jpg'),
(null, '/images/categories/randonnee.jpg'),
(null, '/images/categories/football.jpg'),
(null, '/images/categories/boxeAnglaise.jpg'),
(null, '/images/categories/natation.jpg'),
(null, '/images/categories/tennis.jpeg'),
(null, '/images/categories/yoga.jpg'),
(null, '/images/categories/kayak.jpg'),
(null, '/images/categories/escrime.jpg'),
(null, '/images/categories/airsoft.jpg');

INSERT INTO `dbequipementssportifs`.`commande`
(`numTicket`,
`date`,
`username_fk`)
VALUES
(null, sysdate(), 'Aless');

INSERT INTO `dbequipementssportifs`.`typearticle`
(`codeBarre`,
`prix`,
`id_categorie_fk`)
VALUES
(null, 149.99, 1),
(null, 29.99, 2),
(null, 99.99, 1),
(null, 49.99, 2),
(null, 529.99, 3),
(null, 349.99, 3),
(null, 69.99, 4),
(null, 9.99, 5),
(null, 59.99, 5),
(null, 39.99, 6),
(null, 5.99, 6),
(null, 19.99, 1),
(null, 23.59, 7),
(null, 27.59, 7),
(null, 75.99, 8),
(null, 19.99, 8),
(null, 9.99, 9),
(null, 4.99, 9),
(null, 269.99, 10),
(null, 7.99, 10),
(null, 49.99, 11),
(null, 29.99, 11),
(null, 249.99, 12),
(null, 4.99, 12),
(null, 4.99, 12),
(null, 49.99, 4),
(null, 39.99, 6),
(null, 29.99, 1),
(null, 59.99, 1),
(null, 44.99, 1),
(null, 7.99, 1),
(null, 249.99, 11),
(null, 109.99, 11),
(null, 4.99, 9),
(null, 29.99, 9),
(null, 14.99, 10),
(null, 23.99, 10),
(null, 59.99, 8);

INSERT INTO `dbequipementssportifs`.`image`
(`url`,
`codeBarre_fk`)
VALUES
('/images/articles/t-shirtHomme.jpg', 2),
('/images/articles/t-shirtHomme_Bleu.jpg', 2),
('/images/articles/benchPress.jpg', 1),
('/images/articles/basicbenchPress.jpg', 3),
('/images/articles/chaussureCourse.jpg', 4),
('/images/articles/vtt.png', 5),
('/images/articles/veloRoute.png', 6),
('/images/articles/chaussureMarche.jpg', 7),
('/images/articles/balle.jpg', 8),
('/images/articles/chaussureCrampons.jpg', 9),
('/images/articles/casque.jpg', 10),
('/images/articles/bandesPoignet.jpg', 11),
('/images/articles/veloRouteV2.jpg', 6),
('/images/articles/haltere20Kg.jpg', 12),
('/images/articles/maillotHomme.jpg', 13),
('/images/articles/maillotFemme.jpg', 14),
('/images/articles/raquette.jpg', 15),
('/images/articles/lotBalles.jpg', 16),
('/images/articles/tapisYoga.jpg', 17),
('/images/articles/briqueYoga.jpg', 18),
('/images/articles/kayakRivière.jpg', 19),
('/images/articles/pagaie.jpg', 20),
('/images/articles/pagaieEntière.jpg', 20),
('/images/articles/fleuret.jpg', 21),
('/images/articles/casqueEscrime.jpg', 22),
('/images/articles/FNScarHNoir.jpg', 23),
('/images/articles/FNScarHNoirV2.jpg', 23),
('/images/articles/billesBio.jpg', 24),
('/images/articles/billes.jpg', 25),
('/images/articles/batonMarcheNoir.jpg', 26),
('/images/articles/batonMarcheRose.jpg', 26),
('/images/articles/gantsBoxeRouge.jpg', 27),
('/images/articles/gantsBoxeBleu.jpg', 27),
('/images/articles/tapisDomyosNoir.jpg', 28),
('/images/articles/barreDeTraction.jpg', 29),
('/images/articles/barresParalleles.jpg', 30),
('/images/articles/DebardeurCrossTrainingBlanc.jpg', 31),
('/images/articles/DebardeurCrossTrainingBleu.jpg', 31),
('/images/articles/vesteAllstarEcostarHomme.jpg', 32),
('/images/articles/chaussuresAdidaDartagnan.jpg', 33),
('/images/articles/SangleYogaEnCotonÉcru.jpg', 34),
('/images/articles/LeggingRéversibleYOGAFemmeNoir.jpg', 35),
('/images/articles/LeggingRéversibleYOGAFemmeOlive.jpg', 35),
('/images/articles/ShortKayak.jpg', 36),
('/images/articles/ShortyDébardeurFemmeNopreneBleu.jpg', 37),
('/images/articles/ShortyDébardeurFemmeNopreneGris.jpg', 37),
('/images/articles/sacSportRaquetteWilson.jpg', 38);

INSERT INTO `dbequipementssportifs`.`taille`
(`tailleArticle`)
VALUES
('S'), ('M'), ('L'), ('XL'), ('XXL'), ('38'),('39'),('40'), ('41'), ('42'), ('43'), ('44'), ('45');

INSERT INTO `dbequipementssportifs`.`couleur`
(`id`)
VALUES
(null), (null), (null), (null), (null), (null), (null), (null);

INSERT INTO `dbequipementssportifs`.`TranslationCouleur`
(`langageID_FK`,
`idCouleur_FK`,
`libelle`)
values
('fr', 1, 'Rouge'), ('en', 1, 'Red'),
('fr', 2, 'Bleu'), ('en', 2, 'Blue'),
('fr', 3, 'Blanc'), ('en', 3, 'White'),
('fr', 4, 'Bleu foncé'), ('en', 4, 'Dark blue'),
('fr', 5, 'Rose'), ('en', 5, 'Pink'),
('fr', 6, 'Noir'), ('en', 6, 'Black'),
('fr', 7, 'Olive'), ('en', 7, 'Olive'),
('fr', 8, 'Gris'), ('en', 8, 'Grey');

INSERT INTO `dbequipementssportifs`.`disponible`
(`taille_fk`,
`codeBarre_fk`)
VALUES
('S', 2), ('M', 2), ('L', 2),
('38', 9),('39', 9),('40', 9),('41', 9),('42', 9), ('43', 9), ('44', 9), ('45', 9),
('38', 4),('39', 4),('40', 4),('41', 4),('42', 4), ('43', 4), ('44', 4), ('45', 4),
('S', 10), ('M', 10), ('L', 10),
('38', 7),('39', 7),('40', 7),('41', 7),('42', 7), ('43', 7), ('44', 7), ('45', 7),
('S', 13), ('M', 13), ('L', 13),
('S', 14), ('M', 14), ('L', 14),
('S', 22), ('M', 22),
('S', 27), ('M', 27),
('S', 30), ('M', 30), ('L', 30),
('S', 31), ('M', 31), ('L', 31),
('43', 32), ('44', 32), ('45', 32),
('38', 33), ('39', 33), ('40', 33),
('S', 35), ('M', 35), ('L', 35),
('S', 36), ('M', 36), ('L', 36),
('S', 37), ('M', 37), ('L', 37);

INSERT INTO `dbequipementssportifs`.`disponibleencouleur`
(`couleur_fk`,
`codeBarre_fk`)
VALUES
(4, 2), (2, 2),
(2, 10), (3, 10),
(1, 5), (3, 5),
(3, 11), (1, 11),
(5, 26), (6, 26),
(1, 27), (2, 27),
(3, 31), (2, 31),
(6, 35), (7, 35),
(2, 37), (8, 37);


INSERT INTO `dbequipementssportifs`.`translationcategorie`
(`langageID_FK`,
`idCategorie_FK`,
`libelle`)
VALUES
('fr', 1, 'Musculation'), ('en', 1, 'Bodybuilding'),
('fr', 2, 'Course'), ('en', 2, 'Running'),
('fr', 3, 'Vélo'), ('en', 3, 'Bike'),
('fr', 4, 'Randonnée'), ('en', 4, 'Hiking'),
('fr', 5, 'Football'), ('en', 5, 'Soccer'),
('fr', 6, 'Boxe anglaise'), ('en', 6, 'Boxing'),
('fr', 7, 'Natation'), ('en', 7, 'Swimming'),
('fr', 8, 'Tennis'), ('en', 8, 'Tennis'),
('fr', 9, 'Yoga'), ('en', 9, 'Yoga'),
('fr', 10, 'Kayak'), ('en', 10, 'Kayak'),
('fr', 11, 'Escrime'), ('en', 11, 'Fencing'),
('fr', 12, 'Airsoft'), ('en', 12, 'Airsoft');

INSERT INTO `dbequipementssportifs`.`translationarticle`
(`langageID_FK`,
`codeBarre_FK`,
`libelle`,
`description`)
VALUES
('fr', 1, 'Banc de développer coucher premium', 'Fait en cuir de haute qualité avec un aspect premium'), ('en', 1, 'Premium bench press', 'Made of high quality leather with a premium look'),
('fr', 2, 'T-shirt sport haute intensité', 'Créer spécialement pour la course, ne se déchire pas après 3 jours'), ('en', 2, 'T-shirt high intensity sport', 'Create especially for the crossfit, do not tear after 3 trainings'),
('fr', 3, 'Banc de développer coucher basique', 'Simple banc de DC pour débutants'), ('en', 3, 'Basic bench press', 'Simple bench press for beginners'),
('fr', 4, 'Chaussures', 'Chaussures de course qui vous permettra de courir plus vite grâce à l\'adhérence de ses semelles !'), ('en', 4, 'Shoes', 'Running shoes that will allow you to run faster thanks to the grip of its soles!'),
('fr', 5, 'VTT', 'VTT conçu pour être robuste, fiable et rapide. Aussi léger qu\'une plume et aussi réisitant que l\'acier !'), ('en', 5, 'ATV', 'ATV designed to be robust, reliable and fast. As light as a plum and as reisiting as steel!'),
('fr', 6, 'Vélo de route', 'Vélo destiné à un public adulte cherchant à pratiquer du vélo de temps en temps ou encore pour se rendre à son lieu de travail'), ('en', 6, 'Road bike', 'Bike for an adult audience seeking to cycle from time to time or to get to their place of work'),
('fr', 7, 'Chaussures de marche', 'Envie d\'une petite balade en montagne ? N\'attendez plus, ces chaussures sont fait pour vous !'), ('en', 7, 'Walking shoes', 'Want a little ride in the mountains? Do not wait, these shoes are for you!'),
('fr', 8, 'Balle', 'Simple balle de foot pour s\'amuser entre amis'), ('en', 8, 'Ball', 'Simple soccer ball to have fun with friends'),
('fr', 9, 'Chaussures à crampons', 'Chaussures destiné à des joueurs de foot aguerri, une fois qu\'on a des crampons, ça ne rigole plus !'), ('en', 9, 'Stud shoes', 'Shoes for seasoned football players, once you have crampons, it does not laugh anymore!'),
('fr', 10, 'Casque', 'Casque de combat protégeant efficacement le nez, les joues, les yeux et le front. Attention : Combattre n\'est pas un jeu.'), ('en', 10, 'Helmet', 'Combat helmet effectively protects the nose, cheeks, eyes and forehead. Warning: Fighting is not a game.'),
('fr', 11, 'Bande poignet', 'Bandes pour poignet élastiques protégeant efficacement les poignets et les phalanges. Attention : Combatre n\'est pas un jeu.'), ('en', 11, 'Wrist bands', 'Elastic wrist bands effectively protect wrists and knuckles. Warning: Combatre is not a game'),
('fr', 12, 'Haltere 20Kg', 'Conçu pour la musculation et les entraînements fonctionnels type cross training. Idéal pour la préparation physique. L\'haltère polyvalent, pour les mouvements de musculation et les exercices fonctionnels (type pompe).'), ('en', 12, 'Dumbbell', 'Designed for weight training and functional training like cross training. Ideal for physical preparation. The versatile dumbbell, for bodybuilding movements and functional exercises (pump type).'),
('fr', 13, 'Maillot homme', 'Conçu pour Le nageur confirmé qui progresse et qui a besoin de maintien et de liberté de mouvements. Maillot très résistant au chlore. Sa doublure et son cordon de serrage intérieurs offriront un confort maximal et un ajustement parfait.'), ('en', 13, 'Man swimsuit', 'Designed for advanced swimmers who are progressing and in need of support and freedom of movement. Jersey very resistant to chlorine. The interior lining and drawcord provide maximum comfort and a perfect fit.'),
('fr', 14, 'Maillot femme', 'Conçu pour la nageuse confirmée qui progresse et qui a besoin de maintien et de liberté de mouvements. Un maillot de bain de natation très résistant au chlore, avec une coupe dégagée pour une grande liberté de mouvements.'), ('en', 14, 'Women swimsuit', 'Designed for the advanced swimmer who is progressing and in need of support and freedom of movement. A swimsuit swimming very resistant to chlorine, with a clear cut for a great freedom of movement.'),
('fr', 15, 'Raquette', 'Conçu pour le joueur de tennis expert à la recherche de puissance et de maniabilité. Jouer en puissance, maîtriser le jeu. Raquette à la fois puissante et plus légère pour une meilleure maniabilité.'), ('en', 15, 'Racket', 'Designed for the expert tennis player looking for power and maneuverability. Play power, master the game. Racket both powerful and lighter for better maneuverability.'),
('fr', 16, 'Lot de balles', 'Conçu pour le joueur de tennis recherchant une balle d\'entraînement convenant aussi en compétition. Balles munies d\'un colorant spécial donnant un jaune plus visible.'), ('en', 16, 'Batch of balls', 'Designed for the tennis player looking for a suitable training ball also in competition. Balls with a special dye giving a more visible yellow.'),
('fr', 17, 'Tapis', 'Le tapis de yoga premier prix pour débuter un yoga doux, léger et facile à transporter, sans PVC.'), ('en', 17, 'Mat', 'The first price yoga mat to start a soft, light and easy to carry yoga, without PVC.'),
('fr', 18, 'Brique', 'Une aide précieuse aux postures ! Légère et douce , pratique à emmener au cours de yoga , pour l\'assise ou les postures.'), ('en', 18, 'Brick', 'A precious help to postures! Light and gentle, convenient to take to yoga class, for sitting or postures.'),
('fr', 19, 'Kayak de rivière', 'Conçu spécialement pour la vitesse ce kayak vous amènera où bon vous semble ! Robuste et élancé vous serez maitre de l\'eau. (Pour nageur aguerri seulement). Uniquement pour les rivières, lacs ou en mer douce.'), ('en', 19, 'River kayak', 'Designed specifically for speed this kayak will take you wherever you want! Robust and slender you will be master of the water. (For experienced swimmer only). Only for rivers, lakes or in the fresh sea.'),
('fr', 20, 'Pagaie', 'Pagaie séparable en 2 destiné aux kayaks de rivière, lac ou de mer douce.'), ('en', 20, 'Paddle', 'Separable paddle in 2 for kayaks of river, lake or soft sea.'),
('fr', 21, 'Fleuret', 'Le fleuret est une arme d’estoc (on touche avec la pointe) et de convention (c’est à dire qu\'il y a un système de priorité dans l\'attribution d’une touche) avec la caractéristique d\'une lame à base carrée.'), ('en', 21, 'Foil', 'The foil is a thrust weapon (one touches with the tip) and conventional (ie there is a priority system in the assignment of a key) with the characteristic of a blade to square base.'),
('fr', 22, 'Masque', 'Indispensable à l\'escrime, le masque vous garantira une protection total de la tête jusqu\'au cou. Disponible en taille enfant ou adulte.'), ('en', 22, 'Mask', 'Essential to fencing, the mask will guarantee total protection from head to neck. Available in child or adult size.'),
('fr', 23, 'FN Scar H Noir', 'Réplique livrée avec une batterie 8.4V/1100mAh, un chargeur de batterie, un chargeur supplémentaire de billes.'), ('en', 23, 'FN Scar H Black', 'Replica comes with a 8.4V / 1100mAh battery, a battery charger, an additional charger of balls.'),
('fr', 24, 'Billes BIO 0.25g', 'Redécouvrez le plaisir de jouer avec une bille airsoft biodégradable haut de gamme dont la finition est étudiée pour toutes les répliques. Elles possèdent une homogénéité élevée dans leurs dimensions et sont adaptées à tous les répliques d\'armes Spring et les AEG standards (800 billes disponibles).'), ('en', 24, 'BIO balls 0.25g', 'Rediscover the pleasure of playing with a premium airsoft biodegradable ball whose finish is studied for all replicas. They have high homogeneity in their dimensions and are suitable for all Spring weapon replicas and standard AEGs (800 balls availables).'),
('fr', 25, 'Billes 0.25g', 'Redécouvrez le plaisir de jouer avec une bille airsoft haut de gamme dont la finition est étudiée pour toutes les répliques. Elles possèdent une homogénéité élevée dans leurs dimensions et sont adaptées à tous les répliques d\'armes Spring et les AEG standards(800 billes disponibles).'), ('en', 25, 'Balles 0.25g', 'Rediscover the pleasure of playing with a high-end airsoft ball whose finish is studied for all replicas. They have high homogeneity in their dimensions and are suitable for all Spring weapon replicas and standard AEGs (800 balls availables).'),
('fr', 26, 'Baton de marche', 'Conçu pour marcher 3 fois par semaine ou plus par tout temps. Performez avec les bâtons de marche nordique Newfeel Propulse Walk 900 qui allient propulsion et légèreté. '), ('en', 26, 'Walking stick', 'Designed for walking 3 times a week or more in any weather. Perform with the Newfeel Propulse Walk 900 Nordic walking sticks that combine propulsion and lightness.'),
('fr', 27, 'Gants de boxe', 'Conçu pour le boxeur expert recherchant un gant en cuir naturel. Le gant en cuir qui résiste aux entraînements intensifs. '), ('en', 27, 'Boxing gloves', 'Designed for the expert boxer looking for a natural leather glove. The leather glove that resists intensive training.'),
('fr', 28, 'Tapis Domyos', 'Tapis de protection à mettre sous votre matériel de fitness cardio pour protèger efficacement votre sol et diminuer le bruit lors de votre pratique.'), ('en', 28, 'Domyos mat', 'Protective mats to put under your cardio fitness equipment to effectively protect your floor and reduce noise during your practice.'),
('fr', 29, 'Barre de traction', 'Conçu pour se muscler le haut du corps. Variez l\'écartement et la position des mains pour les tractions en pronation ou en supination, prises larges, serrés et marteau. Pour une stabilité maximum, ancrez le produit sur un mur porteur.'), ('en', 29, 'Pull up bar', 'Designed to build your upper body. Vary the spacing and position of the hands for pronation or supine pulls, wide, tight grips and hammer. For maximum stability, anchor the product on a load-bearing wall.'),
('fr', 30, 'Barres parallèles', 'Station d\'entraînement : nomade, compact et complète qui permet de travailler l\'ensemble des muscles au poids, en statique ou en dynamique.'), ('en', 30, 'Parallel bars', 'Training station: nomadic, compact and complete that allows all muscles to work on weight, static or dynamic.'),
('fr', 31, 'Débardeur cross training', 'Débardeur femme de Crosstraining ultra léger et résistant. Il vous permettra d\'être en confort lors de la réalisation de vos WODs et de vos entraînements.'), ('en', 31, 'cross training tank top', 'Crosstraining women\'s tank top ultra light and resistant. It will allow you to be comfortable during the realization of your WODs and your training.'),
('fr', 32, 'Veste Ecostar', 'La veste "Ecostar" FIE 800N vous apportera tout le confort dont vous aurez besoin lors de vos assauts à l\'entrainement ou en compétition, cette veste alliant souplesse et résistance est totalement élastiss. Composition 80% Polyamide 20% Polyester. Lavage Facile'), ('en', 32, 'jacket Ecostar', 'The jacket "Ecostar" FIE 800N will bring you all the comfort that you will need during your assaults in training or in competition, this jacket combining flexibility and resistance is fully elastiss. Composition 80% Polyamide 20% Polyester. Easy wash'),
('fr', 33, 'CHAUSSURES ADIDAS DARTAGNAN IV', 'Une nouvelle version des chaussures d\'escrime classiques avec un design léger et flexible. Allège la chaussure, la semelle extérieure présente une haute résistance à l’usure.'), ('en', 33, 'SHOES ADIDAS DARTAGNAN IV', 'A new version of classic fencing shoes with a lightweight and flexible design. Lighten the shoe, the outsole has a high resistance to wear.'),
('fr', 34, 'Sangle Yoga en coton écru', 'Conçu pour la pratique du yoga. Une aide précieuse à la recherche de souplesse ! Taille : 2,5 mètres - largeur 3,5 cm.'), ('en', 34, 'Yoga strap in ecru cotton', 'Designed for yoga practice. A precious help in search of flexibility! Size: 2.5 meters - width 3.5 cm.'),
('fr', 35, 'Legging Réversible YOGA', 'Envie de changer de legging entre 2 séances de yoga ? Nos yogis l\'ont conçu réversible (uni / imprimé) sans oublier ses autres qualités : opaque, respirant, et maintien de la sangle abdominale !'), ('en', 35, 'YOGA Reversible Legging', 'Want to change leggings between 2 yoga sessions? Our yogis have designed reversible (plain / printed) without forgetting its other qualities: opaque, breathable, and maintaining the abdominal strap!'),
('fr', 36, 'Short Kayak', 'Ce short à la coupe allongée dans le dos permet d’avoir le bas du dos couvert même en position assise. La souplesse du néoprène assure un confort optimal même pour une longue durée de pratique'), ('en', 36, 'Kayak Shorts', 'These shorts with the elongated cut in the back allows to have the lower back covered even in sitting position. The softness of the neoprene ensures optimal comfort even for a long period of practice'),
('fr', 37, 'SHORTY Débardeur KAYAK', 'Ce modèle est conçu pour les sports de pagaie. Il libère les épaules pour faciliter la rame, apporter la thermicité nécessaire en mi saison et disposer d\'une poche zippée.'), ('en', 37, 'Shortly KAYAK Tank', 'This model is designed for paddle sports. It frees the shoulders to facilitate paddling, provide the necessary warmth in mid season and have a zipped pocket.'),
('fr', 38, 'Sac de sport Wilson', 'Ce sac de tennis Wilson FEDERER rouge a la particularité d\'être très léger et propose un design épuré et une bonne protection de vos raquettes et de votre matériel. Il est aussi facile à transporter.'), ('en', 38, 'Wilson sports bag', 'This Wilson FEDERER red tennis bag has the distinction of being very light and offers a clean design and good protection of your rackets and your equipment. It is also easy to carry.');

INSERT INTO `dbequipementssportifs`.`lignecommande`
(`quantite`,
`prixReel`,
`codeBarre_fk`,
`numTicket_fk`)
VALUES
(20, 130.99, 1, 1);

