-- Igor Luciano de Paula

﻿-- create database CONTROLE_NAVIO;


-- \c controle_navio;


-- begin transaction;

-- commit transaction;

-- rollback transaction;


create table tipo_navio(
	tipo varchar(50) NOT NULL,
	tonelagem integer,
	casco varchar(50),

	CONSTRAINT tipo_pf PRIMARY KEY (tipo)
);

create table estado_pais(
	nome varchar(50) NOT NULL PRIMARY KEY,
	continente varchar(50)
);

create table mar_oceano_lago(
	nome varchar(50) NOT NULL PRIMARY KEY
);
create table movimento_navio(
	data_movimento date NOT NULL, 
	tempo_movimento time,
	longitude varchar(30),
	latitude varchar(30),
	
	nnome varchar(50) NOT NULL
);

create table navio(
	nnome varchar(50) NOT NULL PRIMARY KEY,
	proprietario integer,

	tipo varchar(50),
	origem_nome varchar(50),
	data_chegada date,
	estado_pais varchar(50),
	pjnome varchar(50)
);

create table visita(
	data_chegada date NOT NULL,
	data_partida date,
	
	nnome varchar(50),
	pjnome varchar(50),
	estado_pais varchar(50),

	PRIMARY KEY (data_chegada, nnome, pjnome, estado_pais)
);

create table porto(
	pjnome varchar(50),
	
	estado_pais varchar(50),
	mar_oceano_lago varchar(50),

	CONSTRAINT porto_pk PRIMARY KEY (pjnome, estado_pais)
);

	------------------------- porto ----------------------------

	ALTER TABLE porto ADD
	CONSTRAINT estado_pais_fk FOREIGN KEY (estado_pais)
	REFERENCES estado_pais(nome)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	ALTER TABLE porto ADD
	CONSTRAINT mar_oceano_lago_fk FOREIGN KEY (mar_oceano_lago)
	REFERENCES mar_oceano_lago(nome)
	ON UPDATE RESTRICT ON DELETE RESTRICT;
	
	------------------------------------------------------------
	
	------------------------- movimento_navio ------------------------------

	ALTER TABLE movimento_navio ADD
	CONSTRAINT nnome_fk FOREIGN KEY (nnome)
	REFERENCES navio(nnome)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	ALTER TABLE movimento_navio ADD
	CONSTRAINT date_time_pk PRIMARY KEY (data_movimento, tempo_movimento);

	------------------------------------------------------------------------

	--------------------------------- navio -------------------------------------

	ALTER TABLE navio ADD
	CONSTRAINT tipo_fk FOREIGN KEY (tipo)
	REFERENCES tipo_navio(tipo)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	ALTER TABLE navio ADD
	CONSTRAINT origem_nome_estado_pais_fk FOREIGN KEY (origem_nome, estado_pais)
	REFERENCES porto(pjnome, estado_pais)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	ALTER TABLE navio ADD
	CONSTRAINT navio_visita_fk FOREIGN KEY (data_chegada, nnome, pjnome, estado_pais) 
	REFERENCES visita(data_chegada, nnome, pjnome, estado_pais)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	-----------------------------------------------------------------------------

	------------------------------- visita ----------------------------

	ALTER TABLE visita ADD
	CONSTRAINT nnome_pk FOREIGN KEY (nnome)
	REFERENCES navio(nnome)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	ALTER TABLE visita ADD
	CONSTRAINT pjnome_pk FOREIGN KEY (pjnome, estado_pais)
	REFERENCES porto(pjnome, estado_pais)
	ON UPDATE RESTRICT ON DELETE RESTRICT;

	-------------------------------------------------------------------
