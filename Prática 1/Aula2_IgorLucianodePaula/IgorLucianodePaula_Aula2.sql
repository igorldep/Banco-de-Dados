-- Igor Luciano de Paula - Prática 2 - Banco de Dados

-- create database IgorLdeP_pratica1;


-- \c pratica1;


-- 	begin transaction;

-- 	commit transaction;

-- 	rollback transaction;


-- --------------------------------------------------------------


create table departamento (
	codigo integer NOT NULL PRIMARY KEY,
	nome varchar(50),
	telefone varchar(20),
	faculdade varchar(50),
	numero_escritorio varchar(50)
);

create table telefones (
	aluno integer NOT NULL, -- * CPF
	numero varchar(20),

	CONSTRAINT aluno_numero_pk PRIMARY KEY (aluno, numero) -- FK(aluno) como PK de telefones
);

create table endereco (
	aluno integer NOT NULL, -- * CPF
	cep varchar(8) NOT NULL,
	numero varchar(10) NOT NULL,
	logradouro varchar(30),
	estado varchar(2), -- Sigla
	cidade varchar(15),

	CONSTRAINT cep_numero_pk PRIMARY KEY (aluno, cep, numero)
);

create table curso( 
	codigo integer NOT NULL PRIMARY KEY,
	horas_semestrais integer,
	nome varchar(50),
	nivel varchar(20),
	descricao text,
	programa text,
	
	departamento integer NOT NULL -- codigo
	
);

create table historico (
	nota integer,
	disciplina integer,
	aluno integer NOT NULL -- * CPF
);


create table reg_disciplina (
	ano integer, 
	semestre integer,
	disciplina integer, -- * Numero
	curso integer -- * codigo
);

create table disciplina (
	numero integer NOT NULL PRIMARY KEY,
	instrutor integer
);	

create table aluno (
	cpf integer NOT NULL,
	nascimento date, -- AAAA-MM-DD
	sexo varchar(1), -- M ou F
	turma varchar(6), -- 2/2018
	nome varchar(40),
	matricula integer,
	curso integer NOT NULL, -- * código
	dep_principal integer NOT NULL, -- * código
	dep_secundario integer, -- * código
	historico integer, -- * numero

	CONSTRAINT cpf_pk PRIMARY KEY (cpf) -- nomeada 
);

-- ----------------------------------Telefones-----------------------------------

	ALTER TABLE telefones ADD
	CONSTRAINT aluno_fk FOREIGN KEY (aluno)
	REFERENCES aluno(cpf) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;

-- -------------------------------------------------------------------------


-- ------------------------- curso -----------------------------------------

	ALTER TABLE curso ADD
	CONSTRAINT departamento_fk FOREIGN KEY (departamento)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------------------


-- -------------------------Historico---------------------------------

	ALTER TABLE historico ADD
	CONSTRAINT disciplina_fk FOREIGN KEY (disciplina)
	REFERENCES disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;

	ALTER TABLE historico ADD
	CONSTRAINT aluno_fk FOREIGN KEY (aluno)
	REFERENCES aluno(cpf) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
-- -------------------------------------------------------------------


-- -------------------------Reg_Disciplina---------------------------------

	ALTER TABLE reg_disciplina ADD	
	CONSTRAINT disciplina_fk FOREIGN KEY (disciplina)
	REFERENCES disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
	ALTER TABLE reg_disciplina ADD	
	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	
-- --------------------------------------------------------------------------

-- ----------------------------------Aluno-----------------------------------

	ALTER TABLE aluno ADD
	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
    
	ALTER TABLE aluno ADD
	CONSTRAINT dep_principal_fk FOREIGN KEY (dep_principal)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
    
	ALTER TABLE aluno ADD
	CONSTRAINT dep_secundario_fk FOREIGN KEY (dep_secundario)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
    
-- ------------------------------------------------------------------
