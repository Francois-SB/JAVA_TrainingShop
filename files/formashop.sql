-- ------------------------------------------------------------------------------
-- - Reconstruction de la base de données                                     ---
-- ------------------------------------------------------------------------------
DROP DATABASE IF EXISTS formashop;
CREATE DATABASE formashop;
USE formashop;

-- -----------------------------------------------------------------------------
-- - Construction de la table des utilisateurs                               ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Users (
	IdUser				int(4)		PRIMARY KEY AUTO_INCREMENT,
	Login				varchar(20)	NOT NULL UNIQUE,
	Password			varchar(20)	NOT NULL
) ENGINE = InnoDB;

INSERT INTO T_Users (IdUser, Login, Password) VALUES ( 1, 'Anderson' ,	'Neo' );
INSERT INTO T_Users (IdUser, Login, Password) VALUES ( 2, 'Skywalker',	'Luke' );
INSERT INTO T_Users (IdUser, Login, Password) VALUES ( 3, 'Plissken' ,	'Snake' );
INSERT INTO T_Users (IdUser, Login, Password) VALUES ( 4, 'Ripley'   ,	'Ellen' );
INSERT INTO T_Users (IdUser, Login, Password) VALUES ( 5, 'Bond'     ,	'James' );

SELECT * FROM T_Users;

-- -----------------------------------------------------------------------------
-- - Construction de la table des clients	                                 ---
-- -----------------------------------------------------------------------------

CREATE TABLE T_Customers (
	IdCustomer				int(4)		PRIMARY KEY AUTO_INCREMENT,
	Name					varchar(30)	NOT NULL,
	FirstName				varchar(30)	NOT NULL,
	Email 					varchar(30)	NOT NULL unique,
	Phone 					varchar(20)	,
	Address					varchar(50)	,
	IdUser					int(4)		NOT NULL,
	FOREIGN KEY (idUser)	REFERENCES T_Users(idUser)
) ENGINE = InnoDB;

-- -----------------------------------------------------------------------------
-- - Construction de la table des catégories d'articles
-- -----------------------------------------------------------------------------

CREATE TABLE T_Categories (
	IdCategory 				INT(4) 		 PRIMARY KEY AUTO_INCREMENT,
	CatName 				VARCHAR(30)  NOT NULL,
	Description 			VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

insert into T_Categories (IdCategory, CatName, Description) values (1 , 'developpement' , 'web, systeme, securite');
insert into T_Categories (IdCategory, CatName, Description) values (2 , 'bureautique' , 'Concernant office, libreOffice etc');
insert into T_Categories (IdCategory, CatName, Description) values (3 , 'Manager' , 'formations allant de a');


select * from t_categories;

-- -----------------------------------------------------------------------------
-- - Construction de la table des formations en vente                         ---
-- -----------------------------------------------------------------------------
CREATE TABLE T_Trainings (
	IdTraining				int(4)		PRIMARY KEY AUTO_INCREMENT,
	Name					varchar(30)	NOT NULL,
	Duration				int(4) 		NOT NULL,
	Description				varchar(40)	NOT NULL,
	UnitaryPrice			float(8)	NOT NULL DEFAULT 0,
	IdCategory				int(4),
	FOREIGN KEY (IdCategory)	REFERENCES T_Categories(IdCategory),
	workFromHome			varchar(30)	NOT NULL
) ENGINE = InnoDB;

INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Java'     ,	20, 'Java SE 8 : Syntaxe & Poo'	,500, 1 ,'both');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Java avancé'  ,	20, 'Exceptions, fichiers, Jdbc, thread',500, 1 ,'both');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Spring'     ,	20, 'Spring core/Mvc/security'	,500, 1 ,'both');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Php frameworks'     ,	15, 'Symphony'	,300, 1 ,'both');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'C#'     ,	20, 'DotNet Core'	,370, 1 ,'AtTheOffice');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Excel débutant'     ,	5, 'Excel débutant desc'	,50, 2 ,'workFromHome');
INSERT INTO T_Trainings ( name, duration, description, unitaryPrice , IdCategory ,workFromHome) VALUES ( 'Chef Projet info'     ,	20, 'Chef Projet info desc'	,500, 3 ,'AtTheOffice');

SELECT * FROM T_Trainings;

-- ALTER TABLE t_articles ADD COLUMN IdCategory INT(4);
-- ALTER TABLE T_Articles ADD FOREIGN KEY(IdCategory) REFERENCES T_Categories(IdCategory);

-- select IdArticle,T_Articles.Description,Brand,UnitaryPrice,T_Articles.IdCategory,CatName,T_Categories.Description 
-- from t_articles inner join t_categories where t_articles.IdCategory = t_categories.IdCategory and IdArticle=1;

-- SELECT IdArticle,t_articles.Description,brand,UnitaryPrice,CatName FROM t_articles 
-- INNER JOIN t_categories WHERE t_articles.IdCategory=t_categories.IdCategory AND IdArticle>10 ORDER BY UnitaryPrice;

CREATE TABLE T_Orders (
	IdOrder				int(4)		PRIMARY KEY AUTO_INCREMENT,
	TotalAmount				float(4)	NOT NULL DEFAULT 0,
	DateOrder 			DATE		NOT NULL DEFAULT NOW(),
	IdCustomer          INT(4)   	NOT NULL,
	FOREIGN KEY(IdCustomer) REFERENCES T_Customers(IdCustomer)
) ENGINE = InnoDB;



CREATE TABLE T_Order_Items (
	IdOrderItem			int(4)	PRIMARY KEY AUTO_INCREMENT,
	
	IdTraining          INT(4)   NOT NULL,
	FOREIGN KEY(IdTraining) REFERENCES T_Trainings(IdTraining),
	
	Quantity			FLOAT(4) NOT NULL DEFAULT 1,
	UnitaryPrice		FLOAT(4)	NOT NULL DEFAULT 0,
	
	IdOrder             INT(4)   NOT NULL,
	FOREIGN KEY(IdOrder) REFERENCES T_Orders(IdOrder)
) ENGINE = InnoDB;

CREATE TABLE T_UserRole (
	IdUserRole				int(4)		PRIMARY KEY AUTO_INCREMENT,
	Login				varchar(20)	NOT NULL UNIQUE,
	Role				varchar(20)	NOT NULL
) ENGINE = InnoDB;

CREATE TABLE T_Role (
	IdRole				int(4)		PRIMARY KEY AUTO_INCREMENT,
	Role				varchar(20)	NOT NULL
) ENGINE = InnoDB;