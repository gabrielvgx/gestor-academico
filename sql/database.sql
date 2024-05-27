CREATE TABLE IF NOT EXISTS `USUARIO` (
    `ID` varchar(50) NOT NULL UNIQUE,
    `NMUSUARIO` varchar(50) NOT NULL,
    `CARGO` varchar(30) NOT NULL,
    `DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `IDUSERINCLUSAO` varchar(50),
    `EMAIL` varchar(50) NOT NULL UNIQUE,
    `PASSWORD` varchar(100) NOT NULL,
    PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `ESCOLA` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`NMESCOLA` varchar(30) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	PRIMARY KEY (`ID`)
);

ALTER TABLE ESCOLA
ADD CONSTRAINT FK_IDUSERINCLUSAO FOREIGN KEY (IDUSERINCLUSAO) REFERENCES USUARIO(ID);
CREATE TABLE IF NOT EXISTS `TURMA` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`NMTURMA` varchar(50) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	`IDESCOLA` int NOT NULL,
	PRIMARY KEY (`ID`)
);

ALTER TABLE TURMA
ADD CONSTRAINT FK_IDUSERINCLUSAO FOREIGN KEY (IDUSERINCLUSAO) REFERENCES USUARIO(ID);

CREATE TABLE IF NOT EXISTS `USUARIOINSTITUICAO` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`IDTURMA` int,
	`IDESCOLA` int NOT NULL,
	`IDUSUARIO` varchar(50) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`)
);

ALTER TABLE USUARIOINSTITUICAO
ADD CONSTRAINT FK_IDUSUARIO FOREIGN KEY (IDUSUARIO) REFERENCES USUARIO(ID);

CREATE TABLE IF NOT EXISTS `REQUISICAOMATERIAL` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`IDMATERIAL` int NOT NULL,
	`IDESCOLA` int NOT NULL,
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	`STATUS` varchar(20) NOT NULL,
	`QTMATERIAL` int DEFAULT 1,
	`DSJUSTIFICATIVA` varchar(200) NOT NULL,
	`DTUTILIZACAO` timestamp,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`)
);

ALTER TABLE REQUISICAOMATERIAL
ADD CONSTRAINT FK_REQ_MATERIAL_IDUSERINCLUSAO FOREIGN KEY (IDUSERINCLUSAO) REFERENCES USUARIO(ID);

CREATE TABLE IF NOT EXISTS `MATERIAL` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`NMMATERIAL` varchar(20) NOT NULL,
	`DSMATERIAL` varchar(50),
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`)
);

ALTER TABLE MATERIAL
ADD CONSTRAINT FK_MATERIAL_IDUSERINCLUSAO FOREIGN KEY (IDUSERINCLUSAO) REFERENCES USUARIO(ID);

CREATE TABLE IF NOT EXISTS `BNCC` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`CODBNCC` varchar(30) NOT NULL,
	`NMCAMPOEXP` varchar(50) NOT NULL,
	`DSOBJETIVO` varchar(100) NOT NULL,
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `PLANEJAMENTO` (
	`ID` int AUTO_INCREMENT NOT NULL UNIQUE,
	`STATUS` varchar(30) NOT NULL,
	`DTPLANO` timestamp NOT NULL,
	`IDESCOLA` int NOT NULL,
	`IDTURMA` int NOT NULL,
	`DSATIVIDADE` varchar(500) NOT NULL,
	`DSRETORNO` varchar(500),
	`IDBNCC` varchar(500),
	`NRREVISOES` int DEFAULT 0,
	`IDUSERINCLUSAO` varchar(50) NOT NULL,
	`DTINCLUSAO` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`DTULTATU` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`)
);

ALTER TABLE PLANEJAMENTO
ADD CONSTRAINT FK_IDUSERINCLUSAO FOREIGN KEY (IDUSERINCLUSAO) REFERENCES USUARIO(ID);