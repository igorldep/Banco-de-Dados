create database pratica1;

-- \c pratica1;

begin transaction;

commit transaction;

rollback transaction;

----------------------------------------------------------------


create table departamento (
	codigo integer NOT NULL PRIMARY KEY,
	nome varchar(50),
	telefone varchar(20),
	faculdade varchar(50),
	numero_escritorio varchar(50),
	curso integer,

	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
);

create table curso(
	codigo integer NOT NULL PRIMARY KEY,
	horas_semestrais integer,
	nome varchar(50),
	nivel varchar(20),
	descricao text,
	programa text,
	
	departamento integer NOT NULL, -- codigo
	reg_disciplina integer, -- numero_disciplina
	aluno integer, -- cpf
	
	CONSTRAINT departamento_fk FOREIGN KEY (departamento)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT reg_disciplina_fk FOREIGN KEY (reg_disciplina)
	REFERENCES reg_disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,	

	CONSTRAINT aluno_fk FOREIGN KEY (aluno)
	REFERENCES aluno(cpf) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
	
);


create table historico (
	nota integer,
	-- conceito - derivado
	disciplina integer,
	aluno integer NOT NULL,

	CONSTRAINT disciplina_fk FOREIGN KEY (disciplina)
	REFERENCES disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT aluno_fk FOREIGN KEY (aluno)
	REFERENCES aluno(cpf) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
);

create table reg_disciplina (
	ano integer,
	semestre integer,
	disciplina integer,
	curso integer,

	CONSTRAINT disciplina_fk FOREIGN KEY (disciplina)
	REFERENCES disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
);

create table disciplina (
	numero integer NOT NULL PRIMARY KEY,
	instrutor integer,
	curso integer,
	historico integer,

	CONSTRAINT disciplina_fk FOREIGN KEY (disciplina)
	REFERENCES disciplina(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
);

create table aluno (
	cpf integer NOT NULL,
	nascimento date, -- AAAA-MM-DD
	sexo varchar(1), -- M ou F
	turma varchar(6), -- 2/2018
	telefone text, -- * numeros
	nome varchar(20),
	matricula integer,
	endereco text, -- * codigo
	curso varchar(50) NOT NULL, -- *
	dep_principal integer NOT NULL, -- * código
	dep_secundario integer, -- * código
	historico integer, -- * numero

	CONSTRAINT cpf_pk PRIMARY KEY (cpf), -- nomeada - imutavel

	CONSTRAINT telefone_pk FOREIGN KEY (telefone)
	REFERENCES telefones(numeros) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT endereco_fk FOREIGN KEY (endereco)
	REFERENCES endereco(cep) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT curso_fk FOREIGN KEY (curso)
	REFERENCES curso(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT dep_principal_fk FOREIGN KEY (dep_principal)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT dep_secundario_fk FOREIGN KEY (dep_secundario)
	REFERENCES departamento(codigo) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT historico_fk FOREIGN KEY (historico)
	REFERENCES historico(numero) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE

);

create table telefones (
	numeros text
);

create table endereco ( -- id ??
	logradouro varchar(30),
	estado varchar(2), -- sigla
	cep varchar(8),
	cidade varchar(15)
);




---------------------------------------------------------------


insert into departamento (codigo, nome) values (9, 'GALVÃO');

update departamento
set codigo = 9
where nome = 'GALVÃOO'

update departamento
set nome = 'GALVÃOOOOO'
where codigo = 9

select * from departamento;

drop table departamento;
