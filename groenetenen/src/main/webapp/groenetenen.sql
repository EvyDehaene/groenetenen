-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.41-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema groenetenen
--

CREATE DATABASE IF NOT EXISTS groenetenen;
USE groenetenen;

--
-- Definition of table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  KEY `ix_auth_username` (`username`,`authority`) USING BTREE,
  CONSTRAINT `fk_authorities` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authorities`
--

/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` (`username`,`authority`) VALUES 
 ('averell','helpdeskmedewerker'),
 ('averell','magazijnier'),
 ('joe','manager');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;


--
-- Definition of table `filialen`
--

DROP TABLE IF EXISTS `filialen`;
CREATE TABLE `filialen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `naam` varchar(50) NOT NULL,
  `hoofdFiliaal` tinyint(1) NOT NULL,
  `straat` varchar(50) NOT NULL,
  `huisNr` varchar(7) NOT NULL,
  `postcode` smallint(5) unsigned NOT NULL,
  `gemeente` varchar(50) NOT NULL,
  `inGebruikName` date DEFAULT NULL,
  `waardeGebouw` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `filialen`
--

/*!40000 ALTER TABLE `filialen` DISABLE KEYS */;
INSERT INTO `filialen` (`id`,`naam`,`hoofdFiliaal`,`straat`,`huisNr`,`postcode`,`gemeente`,`inGebruikName`,`waardeGebouw`) VALUES 
 (1,'Andros',1,'Keizerslaan','11',1000,'Brussel','2009-01-01','1000.00'),
 (2,'Delos',0,'Oude Vest','17',9200,'Dendermonde','2009-02-02','2000.00'),
 (3,'Gavdos',0,'Europalaan','37',3600,'Genk','2009-03-03','3000.00'),
 (4,'Hydra',0,'Interleuvenlaan','2',3001,'Heverlee','2009-04-04','4000.00'),
 (5,'Ikaria',0,'Vlamingstraat','10',8560,'Wevelgem','2009-05-05','5000.00'),
 (6,'Oinouses',0,'Archimedesstraat','4',8400,'Oostende','2009-06-06','6000.00');
/*!40000 ALTER TABLE `filialen` ENABLE KEYS */;


--
-- Definition of table `gebruikers`
--

DROP TABLE IF EXISTS `gebruikers`;
CREATE TABLE `gebruikers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `naam` varchar(50) NOT NULL,
  `paswoord` varchar(255) NOT NULL,
  `actief` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_Naam` (`naam`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gebruikers`
--

/*!40000 ALTER TABLE `gebruikers` DISABLE KEYS */;
INSERT INTO `gebruikers` (`id`,`naam`,`paswoord`,`actief`) VALUES 
 (1,'joe','theboss',1),
 (2,'averell','hungry',1);
/*!40000 ALTER TABLE `gebruikers` ENABLE KEYS */;


--
-- Definition of table `gebruikersrollen`
--

DROP TABLE IF EXISTS `gebruikersrollen`;
CREATE TABLE `gebruikersrollen` (
  `gebruikerid` int(10) unsigned NOT NULL,
  `rolid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`gebruikerid`,`rolid`),
  KEY `FK_Rollen` (`rolid`),
  CONSTRAINT `FK_gebruikers` FOREIGN KEY (`gebruikerid`) REFERENCES `gebruikers` (`id`),
  CONSTRAINT `FK_Rollen` FOREIGN KEY (`rolid`) REFERENCES `rollen` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gebruikersrollen`
--

/*!40000 ALTER TABLE `gebruikersrollen` DISABLE KEYS */;
INSERT INTO `gebruikersrollen` (`gebruikerid`,`rolid`) VALUES 
 (1,1),
 (2,2),
 (2,3);
/*!40000 ALTER TABLE `gebruikersrollen` ENABLE KEYS */;


--
-- Definition of table `rollen`
--

DROP TABLE IF EXISTS `rollen`;
CREATE TABLE `rollen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `naam` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IX_Naam` (`naam`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rollen`
--

/*!40000 ALTER TABLE `rollen` DISABLE KEYS */;
INSERT INTO `rollen` (`id`,`naam`) VALUES 
 (2,'helpdeskmedewerker'),
 (3,'magazijnier'),
 (1,'manager');
/*!40000 ALTER TABLE `rollen` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`,`password`,`enabled`) VALUES 
 ('averell','hungry',1),
 ('joe','theboss',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `werknemers`
--

DROP TABLE IF EXISTS `werknemers`;
CREATE TABLE `werknemers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voornaam` varchar(50) NOT NULL,
  `familienaam` varchar(50) NOT NULL,
  `filiaalId` int(10) unsigned NOT NULL,
  `wedde` decimal(10,2) NOT NULL,
  `rijksregisterNr` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rijksregisterNr` (`rijksregisterNr`),
  KEY `filiaalID` (`filiaalId`),
  CONSTRAINT `FK_filialen` FOREIGN KEY (`filiaalId`) REFERENCES `filialen` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `werknemers`
--

/*!40000 ALTER TABLE `werknemers` DISABLE KEYS */;
INSERT INTO `werknemers` (`id`,`voornaam`,`familienaam`,`filiaalId`,`wedde`,`rijksregisterNr`) VALUES 
 (1,'Willy','Abbeloos',2,'2130.00',73021113078),
 (2,'Josephke','Achten',3,'2210.00',64030521064),
 (3,'François','Adam',2,'2320.00',82010132079),
 (4,'Jan','Adriaensens',2,'2430.00',74030643009),
 (5,'René','Adriaensens',2,'2530.00',85042253061),
 (6,'Frans','Aerenhouts',2,'2620.00',85042762011),
 (7,'Emile','Aerts',2,'2730.00',70112073081),
 (8,'Jean','Aerts',2,'2830.00',79100883028),
 (9,'Mario','Aerts',2,'2930.00',60112493031),
 (10,'Paul','Aerts',2,'2030.00',89102003059),
 (11,'Stefan','Aerts',2,'2130.00',71120813067),
 (12,'François','Alexander',1,'2210.00',67060821080),
 (13,'Albert','Anciaux',1,'2320.00',83020432054),
 (14,'Urbain','Anseeuw',6,'2420.00',63022042085),
 (15,'Etienne','Antheunis',2,'2510.00',66052851041),
 (16,'Jacques','Arlet',3,'2630.00',62010463039),
 (17,'Wim','Arras',2,'2730.00',68092073050),
 (18,'Roger','Baens',2,'2830.00',80110883107),
 (19,'Dirk','Baert',3,'2930.00',89102493021),
 (20,'Hubert','Baert',3,'2030.00',61122003061),
 (21,'Jean-Pierre','Baert',3,'2130.00',76050813021),
 (22,'Armand','Baeyens',2,'2220.00',73021622048),
 (23,'Jan','Baeyens',2,'2320.00',80110432064),
 (24,'Roger','Baguet',3,'2410.00',81120941083),
 (25,'Serge','Baguet',3,'2510.00',61122551114),
 (26,'Gérard','Balducq',6,'2620.00',83022462094),
 (27,'Koen','Barbé',6,'2730.00',69102073032),
 (28,'Georges','Barras',2,'2810.00',63021781108),
 (29,'Auguste','Baumans',2,'2920.00',84031692032),
 (30,'Arsène','Bauwens',2,'2020.00',83021202108),
 (31,'Henri','Bauwens',2,'2120.00',62012812070),
 (32,'Jules','Bayens',2,'2210.00',61120521094),
 (33,'Albert','Beckaert',3,'2330.00',64031533127),
 (34,'Marcel','Beckaert',3,'2430.00',74030343046),
 (35,'Koen','Beeckman',3,'2530.00',82011953085),
 (36,'Kamiel','Beeckman',3,'2630.00',64030763093),
 (37,'Theophile','Beeckman',3,'2730.00',77062373089),
 (38,'Benoni','Beheyt',3,'2810.00',62011781049),
 (39,'Albert','Beirnaert',3,'2910.00',75040891071),
 (40,'Jean','Belvaux',1,'2020.00',81121202090),
 (41,'Adelin','Benoit',3,'2110.00',82011711096),
 (42,'Auguste','Benoit',3,'2210.00',63020521132),
 (43,'Jef','Berben',3,'2310.00',69102131046),
 (44,'Jean-Pierre','Berckmans',2,'2410.00',60091241073),
 (45,'Albert','Berton',3,'2510.00',62012551093),
 (46,'Frans','Beths',2,'2630.00',60110463138),
 (47,'René','Beyens',2,'2710.00',80110171097),
 (48,'Herman','Beyssens',2,'2830.00',84031183102),
 (49,'Albert','Billiet',3,'2920.00',83021692080),
 (50,'Hector','Billiet',3,'2020.00',83021202128),
 (51,'Marcel','Blavier',1,'2120.00',63022812062),
 (52,'Roger','Blockx',1,'2210.00',61120521114),
 (53,'Maurice','Blomme',6,'2310.00',73022131125),
 (54,'Willytje','Bocklandt',3,'2410.00',87061241119),
 (55,'Emile','Bodart',3,'2510.00',61122551144),
 (56,'Alfons','Boekaerts',2,'2610.00',75041661125),
 (57,'Cesar','Bogaert',3,'2720.00',62011272119),
 (58,'Jan','Bogaert',3,'2820.00',70112882074),
 (59,'Jean','Bogaerts',2,'2930.00',62012793102),
 (60,'Frans','Bonduel',1,'2020.00',82011202069),
 (61,'Tom','Boonen',3,'2110.00',79101711116),
 (62,'Jozef','Boons',2,'2230.00',80112423128),
 (63,'Gabriel','Borra',2,'2330.00',62011233123),
 (64,'Joseph','Bosmans',2,'2420.00',63022042135),
 (65,'Walter','Boucquet',3,'2530.00',84031953156),
 (66,'Marcel','Boumon',3,'2610.00',72011361129),
 (67,'Ferdinand','Bracke',6,'2710.00',85040171158),
 (68,'Adolphe','Braeckeveldt',3,'2810.00',69082381160),
 (69,'Omer','Braekevelt',3,'2920.00',84031992162),
 (70,'Frans','Brands',2,'2010.00',71120101087),
 (71,'Jean','Brankart',3,'2130.00',72011113079),
 (72,'Emile','Brichard',5,'2230.00',83022723131),
 (73,'Georges','Brosteaux',1,'2310.00',76052431151),
 (74,'Emile','Bruneau',4,'2420.00',62012042076),
 (75,'Jean-Marie','Bruyère',6,'2520.00',77060852146),
 (76,'Dave','Bruylandts',2,'2620.00',84032762109),
 (77,'Johan','Bruyneel',1,'2730.00',73022373144),
 (78,'Lucien','Buysse',6,'2810.00',62011781089),
 (79,'Christophe','Brandt',3,'2910.00',76050591090),
 (80,'Norbert','Callens',2,'2020.00',84031202130),
 (81,'Johan','Capiot',3,'2110.00',81121711177),
 (82,'Pino','Cerami',4,'2210.00',60110521172),
 (83,'Georges','Christiaens',2,'2330.00',68071833155),
 (84,'Georges','Claes',2,'2430.00',72012843126),
 (85,'Karel','Clerckx',1,'2520.00',72010852102),
 (86,'Alex','Close',6,'2630.00',89100463158),
 (87,'Yvan','Corbusier',1,'2710.00',83020471130),
 (88,'Hilaire','Couvreur',1,'2830.00',85041183114),
 (89,'Wilfried','Cretskens',2,'2910.00',77060891162),
 (90,'Claude','Criquielion',3,'2030.00',67062603130),
 (91,'Emile','Daems',2,'2130.00',70110813175),
 (92,'Gustave','Danneels',2,'2230.00',85042723095),
 (93,'Fred','De Bruyne',6,'2310.00',73022431158),
 (94,'Arthur','Decabooter',1,'2420.00',66052342171),
 (95,'Hans','De Clerq',6,'2530.00',82011953145),
 (96,'Roger','Decock',6,'2610.00',71121361103),
 (97,'Georges','Decraeye',6,'2730.00',75042373108),
 (98,'Odiel','Defraeye',6,'2830.00',83021183180),
 (99,'Albert','De Jonghe',6,'2910.00',75040891131),
 (100,'Julien','Delbecque',6,'2010.00',75040401179),
 (101,'Alfons','Deloor',1,'2110.00',82011711156),
 (102,'Gustaaf','Deloor',1,'2210.00',63020521192),
 (103,'Hubert','Deltour',1,'2320.00',83020432144),
 (104,'Paul','Deman',3,'2430.00',69102843146),
 (105,'Marc','Demeyer',1,'2520.00',71120852163),
 (106,'Frans','De Mulder',1,'2610.00',74031661106),
 (107,'Johan','De Muynck',6,'2710.00',84030471122),
 (108,'Jef','Demuysere',6,'2810.00',62012081112),
 (109,'Jules','Depoorter',1,'2910.00',74030891169),
 (110,'Richard','Depoorter',1,'2010.00',76050401161),
 (111,'Prosper','Depredomme',6,'2120.00',67060312133),
 (112,'Willy','Derboven',3,'2230.00',83022723171),
 (113,'Germain','Derijcke',6,'2330.00',65041533179),
 (114,'Michel','Dernies',2,'2420.00',63022042185),
 (115,'Charles','Deruyter',1,'2530.00',85041953178),
 (116,'Maurice','Desimpelaere',6,'2610.00',79081961163),
 (117,'Gilbert','Desmet',3,'2710.00',83020171167),
 (118,'Georges','Desplenter',1,'2820.00',77060382145),
 (119,'Léon','Despontin',3,'2910.00',73020891207),
 (120,'Eric','De Vlaeminck',6,'2010.00',76050701164),
 (121,'Roger','De Vlaeminck',6,'2110.00',87062311216),
 (122,'Stijn','Devolder',1,'2230.00',83022723181),
 (123,'Maurice','Dewaele',6,'2320.00',84030432136),
 (124,'Alfons','De Wolf',1,'2420.00',63022042195),
 (125,'Rudy','Dhaenens',2,'2530.00',82011953175),
 (126,'Michel','D\'Hooghe',6,'2630.00',64030763183),
 (127,'Ludo','Dierckxsens',2,'2730.00',75042673131),
 (128,'Frans','Dictus',2,'2810.00',61121781180),
 (129,'Lomme','Driessens',2,'2910.00',74030891189),
 (130,'Gustave','Drioul',1,'2010.00',73020101175),
 (131,'Marcel','Dupont',3,'2110.00',82011711186),
 (132,'Niko','Eeckhout',3,'2230.00',82012723219),
 (133,'Nico','Emonds',2,'2310.00',70112131205),
 (134,'Peter','Farazijn',3,'2430.00',73020343174),
 (135,'Herman','Frison',3,'2510.00',62012551183),
 (136,'Henri','Garnier',1,'2620.00',82012462232),
 (137,'Frans','Gielen',3,'2710.00',81120171159),
 (138,'Romain','Gijssels',2,'2830.00',84031183192),
 (139,'Walter','Godefroot',3,'2910.00',75040891171),
 (140,'Dries','Govaerts',2,'2030.00',63022303202),
 (141,'Sylvain','Grysolle',6,'2130.00',75041113162),
 (142,'Roger','Gyselinck',6,'2210.00',64030821197),
 (143,'Paul','Haghedooren',3,'2330.00',65041833202),
 (144,'Alfred','Hamerlinck',6,'2420.00',66052342221),
 (145,'Louis','Hardiquest',3,'2520.00',75041152168),
 (146,'Emile','Hardy',2,'2630.00',60110463238),
 (147,'Marcel','Hendrikx',1,'2730.00',74032373186),
 (148,'Joseph','Hoevenaers',2,'2820.00',76050382203),
 (149,'Kevin','Hulsmans',2,'2930.00',63022793164),
 (150,'Raymond','Impanis',2,'2020.00',84031202200),
 (151,'Paul','In\'t',3,'2120.00',88092512177),
 (152,'Willy','In\'t',3,'2220.00',69101322213),
 (153,'Marcel','Janssens',2,'2330.00',64031533247),
 (154,'Benjamin','Javaux',1,'2410.00',84030941213),
 (155,'Karel','Kaers',2,'2530.00',80111653184),
 (156,'Francis','Kemplaire',6,'2610.00',76051661197),
 (157,'Norbert','Kerckhove',6,'2710.00',86050471213),
 (158,'Désiré','Keteleer',1,'2830.00',84031183212),
 (159,'Marcel','Kint',3,'2920.00',80111392197),
 (160,'Firmin','Lambot',3,'2010.00',72010101233),
 (161,'Roger','Lambrecht',3,'2110.00',84032011250),
 (162,'Eric','Leman',3,'2230.00',79102423256),
 (163,'Camille','Leroy',2,'2330.00',62011233223),
 (164,'Roland','Liboton',3,'2420.00',63022042235),
 (165,'Jules','Lowie',6,'2530.00',80111653194),
 (166,'André','Lurquin',3,'2620.00',82012462262),
 (167,'Henri','\'Rik\'',4,'2730.00',70112073241),
 (168,'Pierrot','Machiels',2,'2830.00',85041183194),
 (169,'André','Maelbrancke',6,'2930.00',66050293223),
 (170,'Freddy','Maertens',2,'2030.00',64032303204),
 (171,'Romain','Maes',2,'2120.00',60112512189),
 (172,'Sylvère','Maes',2,'2220.00',71121322177),
 (173,'Joseph','Marchand',5,'2330.00',64031533267),
 (174,'René','Martens',2,'2420.00',61122042217),
 (175,'Jacques','Martin',3,'2510.00',63022551195),
 (176,'Emile','père',6,'2620.00',79102162182),
 (177,'Florent','Mathieu',4,'2720.00',64031272183),
 (178,'Nico','Mattan',3,'2810.00',60111781258),
 (179,'Filip','Meirhaeghe',6,'2920.00',85041992244),
 (180,'Axel','Merckx',1,'2010.00',70110101225),
 (181,'Eddy','Merckx',1,'2110.00',80111711208),
 (182,'André','Messelis',2,'2230.00',83022723241),
 (183,'Maurice','Meuleman',3,'2330.00',65041533249),
 (184,'Eloi','Meulenberg',2,'2420.00',64032342220),
 (185,'Frans','Mintjens',2,'2530.00',83021953207),
 (186,'Yvo','Molenaers',2,'2610.00',72011661242),
 (187,'Maurice','Mollin',3,'2710.00',83020171237),
 (188,'Arthur','Mommerency',2,'2820.00',76050382243),
 (189,'Jean-Pierre','Monséré',6,'2920.00',88071692274),
 (190,'Willy','Monty',2,'2030.00',60112003259),
 (191,'Sammie','Moreels',2,'2120.00',63022812202),
 (192,'Alfred','Mottard',5,'2220.00',73021622218),
 (193,'Ernest','Mottart',3,'2320.00',83020432234),
 (194,'Louis','Mottiat',3,'2420.00',62012042196),
 (195,'Johan','Museeuw',6,'2520.00',72010852212),
 (196,'Wilfried','Nelissen',3,'2630.00',66050763197),
 (197,'François','Neuville',6,'2730.00',76052373277),
 (198,'André','Noyelle',6,'2820.00',72012882242),
 (199,'Guy','Nulens',2,'2910.00',69100591225),
 (200,'Nick','Nuyens',2,'2010.00',70110101245),
 (201,'Sven','Nys',2,'2110.00',77081411222),
 (202,'Stan','Ockers',2,'2210.00',60110521292),
 (203,'Petrus','Oellibrandt',3,'2330.00',67061833206),
 (204,'Valère','Ollivier',1,'2430.00',74030343216),
 (205,'Eddy','Peelman',3,'2520.00',71120852263),
 (206,'Edward','Peeters',2,'2620.00',83022462274),
 (207,'Luc','Petitjean',3,'2710.00',82010471278),
 (208,'Victor','\'Louis\'',4,'2820.00',73022882224),
 (209,'Georges','Pintens',2,'2920.00',84031692212),
 (210,'Théodore','Pirmez',3,'2010.00',74030101227),
 (211,'Eddy','Planckaert',3,'2120.00',64030312220),
 (212,'Jo','Planckaert',3,'2220.00',72011922259),
 (213,'Walter','Planckaert',3,'2320.00',86050732260),
 (214,'Willy','Planckaert',3,'2420.00',65042342222),
 (215,'Michel','Pollentier',1,'2520.00',76051152307),
 (216,'Léon','Poncelet',3,'2630.00',62010763232),
 (217,'Louis','Proost',3,'2710.00',81120171239),
 (218,'Robert','Protin',3,'2810.00',62011781229),
 (219,'Albert','Ramon',3,'2930.00',61122493310),
 (220,'Gaston','Rebry',2,'2030.00',61122003261),
 (221,'Jens','Renders',2,'2120.00',61122812301),
 (222,'Guido','Reybrouck',6,'2210.00',64030821277),
 (223,'Marcel','Rijckaert',3,'2310.00',75042431232),
 (224,'Albert','Ritserveldt',3,'2430.00',77060643242),
 (225,'Bert','Roesems',2,'2520.00',71120852283),
 (226,'Louis','Rolus',2,'2630.00',60110463318),
 (227,'Georges','Ronsse',6,'2710.00',83020171277),
 (228,'André','Rosseel',1,'2820.00',72012882272),
 (229,'Félicien','Salmon',3,'2910.00',74030591296),
 (230,'Léopold','Schaeken',3,'2030.00',65042303236),
 (231,'Willy','Scheers',2,'2120.00',62012812270),
 (232,'Alfons','Schepers',2,'2230.00',84032723263),
 (233,'Joseph','Scherens',2,'2330.00',64031533327),
 (234,'Jef','Scherens',2,'2430.00',71120343246),
 (235,'Briek','Schotte',6,'2520.00',72010852252),
 (236,'Frans','Schoubben',3,'2610.00',74031661236),
 (237,'Léon','Scieur',1,'2710.00',80110171287),
 (238,'Félix','Sellier',1,'2820.00',72012882282),
 (239,'Edward','Sels',2,'2920.00',80111392277),
 (240,'Albert','Sercu',4,'2030.00',61122003281),
 (241,'Patrick','Sercu',4,'2130.00',72010813256),
 (242,'Andy','de Smet',3,'2220.00',71121622337),
 (243,'Joseph','Somers',2,'2310.00',72012131246),
 (244,'Tom','Steels',2,'2410.00',79100941262),
 (245,'Ernest','Sterckx',1,'2520.00',73020852331),
 (246,'Lucien','Storme',6,'2610.00',72011361309),
 (247,'Tom','Stubbe',6,'2710.00',79100171325),
 (248,'Roger','Swerts',2,'2810.00',61121781300),
 (249,'Arthur','Targez',3,'2910.00',72010591275),
 (250,'Andrei','Tchmil',1,'2010.00',72010101323),
 (251,'Emmanuel','Thoma',2,'2130.00',73020813335),
 (252,'Philippe','Thys',2,'2220.00',72011322313),
 (253,'Hector','Tiberghien',3,'2320.00',86050732300),
 (254,'Léon','Tommies',2,'2420.00',61122042297),
 (255,'Lode','Troonbeeckx',1,'2530.00',85042253311),
 (256,'Greg','Van Avermaet',3,'2610.00',76051961290),
 (257,'Armand','Van Bruaene',6,'2730.00',77062673302),
 (258,'Georges','Vanconingsloo',4,'2820.00',80090682291),
 (259,'Léon','Van Daele',6,'2910.00',73020891347),
 (260,'Charles','Van Den Born',3,'2010.00',79080701317),
 (261,'Frank','Vandenbroucke',6,'2120.00',68070612345),
 (262,'Odiel','Vanden Meerschaut',3,'2230.00',62110823525),
 (263,'Eric','Vanderaerden',3,'2310.00',76052731334),
 (264,'Kurt','Van de Wouwer',1,'2420.00',67062642306),
 (265,'Richard','Van Genechten',3,'2520.00',80091452335),
 (266,'Martin','Van Geneugden',3,'2620.00',89080262282),
 (267,'Cyrille','Van Hauwaert',3,'2710.00',89080771329),
 (268,'Maurice','Van Herzele',6,'2830.00',88071483300),
 (269,'Jules','Van Hevel',1,'2910.00',74030891329),
 (270,'Edwig','Van Hooydonck',6,'2020.00',88071802291),
 (271,'Lucien','Van Impe',6,'2130.00',74031113320),
 (272,'Henri','Van Kerkhove',6,'2210.00',67061121333),
 (273,'Rik','Van Linden',3,'2320.00',83020732307),
 (274,'Rik','Van Looy',2,'2430.00',71120343286),
 (275,'Willy','Vannitsen',3,'2510.00',64032851357),
 (276,'Peter','Van Petegem',2,'2630.00',66051063367),
 (277,'Peter','Van Santvliet',3,'2720.00',68071872351),
 (278,'Victor','Van Schil',1,'2810.00',65042081295),
 (279,'Herman','van Springel',1,'2910.00',78071191317),
 (280,'Rik','Van Steenbergen',3,'2010.00',78071001358),
 (281,'Guillaume','Van Tongerloo',4,'2120.00',72110612350),
 (282,'Noël','Vantyghem',2,'2210.00',63020821365),
 (283,'Rik','Verbrugghe',6,'2320.00',83020732317),
 (284,'Auguste','Verdyck',6,'2420.00',64032042327),
 (285,'Jozef','Verhaert',3,'2530.00',83021953307),
 (286,'René','Vermandel',1,'2610.00',73021661314),
 (287,'Stive','Vermaut',3,'2720.00',62011272349),
 (288,'Adolf','Verschueren',3,'2830.00',86051483376),
 (289,'Constant','Verschueren',3,'2930.00',69080293558),
 (290,'Johan','Verstrepen',3,'2020.00',85041502305),
 (291,'Félicien','Vervaecke',6,'2110.00',87062011296),
 (292,'Julien','Vervaecke',6,'2210.00',65040821319),
 (293,'Edward','Vissers',2,'2320.00',83020432334),
 (294,'Lucien','Vlaemynck',6,'2410.00',85041241318),
 (295,'André','Vlaeyen',3,'2520.00',72010852312),
 (296,'Jean','Vliegen',3,'2620.00',81122462336),
 (297,'Luc','Wallays',2,'2720.00',60111272331),
 (298,'René','Walschot',3,'2830.00',82011183311),
 (299,'Jean-Marie','Wampers',2,'2920.00',87061692315),
 (300,'Robert','Wancour',1,'2020.00',83021202378),
 (301,'Bart','Wellens',2,'2120.00',61122812381),
 (302,'Wilfried','Wesemael',1,'2230.00',86052723374),
 (303,'Wouter','Weylandt',3,'2330.00',64031533397),
 (304,'Marc','Wauters',2,'2420.00',61122042347),
 (305,'Daniel','Willems',2,'2520.00',73020852391),
 (306,'Jozef','Wouters',2,'2620.00',82012462402),
 (307,'Hendrik','Desmet',3,'2710.00',83020171357),
 (308,'Hendrik','Desmet',3,'2810.00',63021781388),
 (309,'Gerard','Desmet',3,'2910.00',72010591335);
/*!40000 ALTER TABLE `werknemers` ENABLE KEYS */;

grant all on groenetenen.* to 'cursist'@'localhost' identified by 'cursist';


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;