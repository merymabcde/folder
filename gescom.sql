/*==============================================================*/
/* Table : ARTICLES                                             */
/*==============================================================*/
create table ARTICLES  (
   REFERENCE_ART        VARCHAR2(50)                    not null,
   CODE_CAT             INTEGER                         not null,
   DESIGNATION_ART      VARCHAR2(100),
   PRIX_HT              NUMBER(10,2),
   QUANTITE_STOCK       INTEGER,
   STOCK_MIN            INTEGER,
   STOCK_MAX            INTEGER,
   constraint PK_ARTICLES primary key (REFERENCE_ART)
);

/*==============================================================*/
/* Index : ASSOCIATION_5_FK                                     */
/*==============================================================*/
create index ASSOCIATION_5_FK on ARTICLES (
   CODE_CAT INTEGER
);

/*==============================================================*/
/* Table : CATEGORIES                                           */
/*==============================================================*/
create table CATEGORIES  (
   CODE_CAT             INTEGER                         not null,
   LIBELLE_CAT          VARCHAR2(100),
   constraint PK_CATEGORIES primary key (CODE_CAT)
);

/*==============================================================*/
/* Table : CLIENTS                                              */
/*==============================================================*/
create table CLIENTS  (
   NUMERO_CLI           INTEGER                         not null,
   NOM                  VARCHAR2(50),
   PRENOM               VARCHAR2(50),
   ADRESSE              VARCHAR2(100),
   CODE_POSTAL          NUMBER(5),
   VILLE                VARCHAR2(50),
   PAYS                 VARCHAR2(50),
   TELEPHONE            NUMBER(11),
   FAX                  NUMBER(11),
   constraint PK_CLIENTS primary key (NUMERO_CLI)
);

/*==============================================================*/
/* Table : COMMANDES                                            */
/*==============================================================*/
create table COMMANDES  (
   NUMERO_CDE           INTEGER                         not null,
   NUMERO_SAL           INTEGER                         not null,
   NUMERO_CLI           INTEGER                         not null,
   DATE_CDE             DATE,
   TAUX_REMISE          NUMBER(10,2),
   ETAT_CDE             CHAR(10),
   DATE_ENVOI           DATE,
   TAUX_TVA             NUMBER(10,2),
   constraint PK_COMMANDES primary key (NUMERO_CDE)
);

/*==============================================================*/
/* Index : POSSEDE_FK                                           */
/*==============================================================*/
create index POSSEDE_FK on COMMANDES (
   NUMERO_CLI ASC
);

/*==============================================================*/
/* Index : TRAITE_FK                                            */
/*==============================================================*/
create index TRAITE_FK on COMMANDES (
   NUMERO_SAL ASC
);

/*==============================================================*/
/* Table : LIGNES_COMMANDES                                     */
/*==============================================================*/
create table LIGNES_COMMANDES  (
   NUMERO_LIG           NUMBER(6)                       not null,
   NUMERO_CDE           INTEGER                         not null,
   REFERENCE_ART        VARCHAR2(50)                    not null,
   QUANTITE_CDE         INTEGER,
   constraint PK_LIGNES_COMMANDES primary key (NUMERO_LIG,NUMERO_CDE)
);

/*==============================================================*/
/* Index : APPARTIENT_FK                                        */
/*==============================================================*/
create index APPARTIENT_FK on LIGNES_COMMANDES (
   NUMERO_CDE ASC
);

/*==============================================================*/
/* Index : CONTIENT_FK                                          */
/*==============================================================*/
create index CONTIENT_FK on LIGNES_COMMANDES (
   REFERENCE_ART ASC
);

/*==============================================================*/
/* Table : SALARIES                                             */
/*==============================================================*/
create table SALARIES  (
   NUMERO_SAL           INTEGER                         not null,
   NOM_SAL              VARCHAR2(50),
   PRENOM_SAL           VARCHAR2(50),
   FONCTION             VARCHAR2(50),
   SALAIRE              NUMBER(10,2),
   COMISSION            NUMBER(10,2),
   constraint PK_SALARIES primary key (NUMERO_SAL)
);

alter table ARTICLES
   add constraint FK_ARTICLES_ASSOCIATI_CATEGORI foreign key (CODE_CAT)
      references CATEGORIES (CODE_CAT);

alter table COMMANDES
   add constraint FK_COMMANDE_POSSEDE_CLIENTS foreign key (NUMERO_CLI)
      references CLIENTS (NUMERO_CLI);

alter table COMMANDES
   add constraint FK_COMMANDE_TRAITE_SALARIES foreign key (NUMERO_SAL)
      references SALARIES (NUMERO_SAL);

alter table LIGNES_COMMANDES
   add constraint FK_LIGNES_C_APPARTIEN_COMMANDE foreign key (NUMERO_CDE)
      references COMMANDES (NUMERO_CDE);

alter table LIGNES_COMMANDES
   add constraint FK_LIGNES_C_CONTIENT_ARTICLES foreign key (REFERENCE_ART)
      references ARTICLES (REFERENCE_ART);

INSERT INTO CLIENTS VALUES(10,'Harabazan','Hamid','16 rue Lavoisier',92200, 'Asni�res','France',null,null);
INSERT INTO CLIENTS VALUES(17,'Camihort','Marie','1 chemin Lacanau',33000, 'Bordeaux','France',null,null);
INSERT INTO CLIENTS VALUES(22,'Ossola','Christophe','17 Lieudit Segola',47190, 'Aiguillon','France',null,null);
INSERT INTO CLIENTS VALUES(23,'Monnin','Gilles','27 avenue Lorraine',09500, 'Mirepoix','France',0561605825,null);
INSERT INTO CLIENTS VALUES(57,'Dupond','David','57 rue Bayeux',31000, 'Toulouse','France',0582021425,null);
INSERT INTO CLIENTS VALUES(28,'Rossato','Xavier','37 passage du canal',47190, 'Aiguillon','France',null,null);
INSERT INTO CLIENTS VALUES(37,'Vasso','Marie','7 rue dud G�n�ral De Gaulle',31000, 'Toulouse','France',null,null);

INSERT INTO CATEGORIES VALUES (1,'Informatique');
INSERT INTO CATEGORIES VALUES (2,'Livres');
INSERT INTO CATEGORIES VALUES (3,'Accessoires');

INSERT INTO SALARIES VALUES(1,'Andrieu','Michel','Vendeur',2700.00,null);
INSERT INTO SALARIES VALUES(2,'Orlando','John','Vendeur',2400.00,null);
INSERT INTO SALARIES VALUES(3,'Gustave','Gabriel','Commercial',3200.00,2000.00);
INSERT INTO SALARIES VALUES(4,'Bobka','Vincent','Directeur',4700.00,null);

INSERT INTO ARTICLES VALUES('INFYBVF12024',1,'Ecran IIYAMA 20 pouces',220.00,10,5,20);
INSERT INTO ARTICLES VALUES('INFYBVF12027',1,'Ecran IIYAMA 24 pouces',320.00,5,5,20);
INSERT INTO ARTICLES VALUES('INFQRS202525',1,'NoteBook R15',770.00,2,1,10);
INSERT INTO ARTICLES VALUES('INFKMNOP2525',1,'Imprimante multifonction 1736nw',129.00,6,5,10);
INSERT INTO ARTICLES VALUES('INFRSFG25369',1,'Desktop HP 1025',335.00,2,1,10);
INSERT INTO ARTICLES VALUES('LIV302547369',2,'Mission Appolo',27.00,5,1,10);
INSERT INTO ARTICLES VALUES('LIV302547377',2,'Un long fleuve tranquille',42.00,5,1,10);
INSERT INTO ARTICLES VALUES('ACC302547369',3,'Cl� USB 128 Go',54.00,5,1,10);


INSERT INTO COMMANDES VALUES(1000,1,10,'10/02/2010',null,'TRAITEE','12/02/2010',20.00);
INSERT INTO COMMANDES VALUES(1001,1,10,'21/07/2010',null,'EN COURS',null,20.00);
INSERT INTO COMMANDES VALUES(1002,1,17,'27/04/2010',20.00,'TRAITEE','28/04/2010',20.00);
INSERT INTO COMMANDES VALUES(1003,1,17,'25/05/2010',20.00,'TRAITEE','26/05/2010',20.00);
INSERT INTO COMMANDES VALUES(1004,2,22,'25/05/2010',10.00,'TRAITEE','26/05/2010',20.00);
INSERT INTO COMMANDES VALUES(1005,2,23,'12/06/2010',null,'TRAITEE','13/06/2010',20.00);
INSERT INTO COMMANDES VALUES(1006,1,37,'07/08/2011',10.00,'TRAITEE','09/08/2011',20.00);
INSERT INTO COMMANDES VALUES(1007,1,37,'25/11/2011',10.00,'TRAITEE','29/11/2011',20.00);
INSERT INTO COMMANDES VALUES(1008,2,23,'22/06/2011',20.00,'TRAITEE','25/06/2011',20.00);

INSERT INTO LIGNES_COMMANDES VALUES(1,1000,'INFYBVF12024',1);
INSERT INTO LIGNES_COMMANDES VALUES(2,1000,'INFKMNOP2525',1);
INSERT INTO LIGNES_COMMANDES VALUES(1,1001,'INFQRS202525',2);
INSERT INTO LIGNES_COMMANDES VALUES(1,1002,'LIV302547369',3);
INSERT INTO LIGNES_COMMANDES VALUES(1,1003,'ACC302547369',1);
INSERT INTO LIGNES_COMMANDES VALUES(2,1003,'INFYBVF12027',1);
INSERT INTO LIGNES_COMMANDES VALUES(3,1003,'INFKMNOP2525',1);
INSERT INTO LIGNES_COMMANDES VALUES(1,1004,'ACC302547369',1);
INSERT INTO LIGNES_COMMANDES VALUES(1,1005,'INFRSFG25369',2);
INSERT INTO LIGNES_COMMANDES VALUES(1,1006,'LIV302547369',1);
INSERT INTO LIGNES_COMMANDES VALUES(2,1006,'LIV302547377',1);
INSERT INTO LIGNES_COMMANDES VALUES(1,1007,'INFQRS202525',5);
INSERT INTO LIGNES_COMMANDES VALUES(2,1007,'INFYBVF12027',5);
INSERT INTO LIGNES_COMMANDES VALUES(1,1008,'INFYBVF12024',2);
INSERT INTO LIGNES_COMMANDES VALUES(2,1008,'INFYBVF12027',2);
INSERT INTO LIGNES_COMMANDES VALUES(3,1008,'INFKMNOP2525',2);
INSERT INTO LIGNES_COMMANDES VALUES(4,1008,'INFRSFG25369',1);
INSERT INTO LIGNES_COMMANDES VALUES(5,1008,'ACC302547369',2);
