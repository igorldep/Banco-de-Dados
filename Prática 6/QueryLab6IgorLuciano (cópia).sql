
select * from atuacao;

select * from banda;

select * from composicao;

select * from compositor;

select * from evento;

select * from interprete;

select * from local;

select * from musica;

select * from musico;

select * from show;

CREATE LANGUAGE plpgsql

begin transaction

rollback transaction

--------------------------------------------  1  -----------------------------------------------------------

-- ------ Criar Coluna 

ALTER TABLE musico
ADD COLUMN email_musico varchar(50);


-- ------ Inserir Dados

CREATE OR REPLACE FUNCTION insere_email ()
RETURNS VOID
AS
$$ DECLARE
	executado BOOLEAN;
	registro RECORD;
	qtde INTEGER;
BEGIN
	
	
	qtde := 0;
	FOR registro IN SELECT * FROM musico m
	LOOP
		UPDATE musico set email_musico = TRIM(registro.nm_musico)||'@gmail.com'
		WHERE nu_musico = registro.nu_musico;
		
	END LOOP;
END;
$$
LANGUAGE 'plpgsql';

---

SELECT insere_email();

SELECT * from musico;

---


-- ------ Criar Convite

CREATE OR REPLACE FUNCTION convite (varchar(10))
RETURNS INTEGER
AS
$$ DECLARE
	registro RECORD;
	qtde INTEGER;
BEGIN
	qtde := 0;
	FOR registro IN SELECT * FROM musico m
	INNER JOIN interprete i ON m.nu_musico = i.nu_musico_interprete
	LOOP
		qtde := qtde + 1;
		IF(registro.nm_instrumento = $1)
		THEN
			RAISE NOTICE ' Prezado %,
			Você foi selecionado em nosso banco de dados em virtude da sua habilidade em tocar piano. Atualmente, surgiu uma vaga para pianista na Orquestra Municipal e, caso você tenha interesse, entre contato através do telefone (31) 3321-2323.', registro.nm_musico;
		END IF;
	END LOOP;
	RETURN qtde;
END;
$$
LANGUAGE 'plpgsql'

-- ---------

SELECT convite ('violin');


-- -----------------------------------------------------------------------------------------------------------


---------------------------------------------------  2  -----------------------------------------------------------

-- ------ Criar Convite para os convidados

CREATE OR REPLACE FUNCTION convidados_tt (varchar(10), date)
RETURNS VOID AS
$$ 
	DECLARE
		registro RECORD;
		data alias for $2;
	BEGIN
		FOR registro IN SELECT * FROM musico m
		-- LEFT JOIN interprete i ON m.nu_musico = i.nu_musico_interprete -- SELECT count(nm_musico) FROM musico
		INNER JOIN show sh ON sh.nu_musico_condutor = m.nu_musico
		INNER JOIN evento e ON e.nu_evento = sh.nu_evento
		INNER JOIN local l ON l.nu_local = e.nu_local_evento
		LOOP	
			RAISE NOTICE ' Prezado %,
			% tem o prazer de convidá-lo para o evento que irá ocorrer no dia % no % em %, %. Seria uma honra poder contar com sua presença.', registro.nm_musico, $1, data, registro.nm_auditorio, registro.nm_cidade, registro.nm_pais;
		END LOOP;
	END;
$$
LANGUAGE 'plpgsql'

-- ---------

SELECT convidados_tt ('Igor', '03-10-2018');

-------------------------------------------------------------------------------------------------------------










-----------------------------------------------------------------------------------------------
--AULA:

create table produto (
	num_produto INTEGER PRIMARY KEY,
	nome_produto TEXT,
	preco_produto NUMERIC (10, 2),

	CONSTRAINT ck_preco CHECK (preco_produto > 0)
);

select * from produto;
insert into produto (num_produto, nome_produto, preco_produto) VALUES (1, 'dell', 50);
insert into produto (num_produto, nome_produto, preco_produto) VALUES (2, 'iphone', 54.22);

-- ERRO:
insert into produto (num_produto, nome_produto, preco_produto) VALUES (1, 'dell', -2);


CREATE DOMAIN ck_sexo as VARCHAR (1)
CHECK (VALUE = 'F' OR VALUE = 'M');

create table empregado(
	cod_empregado INTEGER PRIMARY KEY,
	sexo_empreago ck_sexo NOT NULL
);

insert into empregado values (1, 'F');

-- ERRO:
insert into empregado values (1, 'X');

-- ERRO: quando já tem algo lá. NOT NULL ERRO
ALTER TABLE empregado 
ADD COLUMN nome_empreagado varchar(50) NOT NULL;

------------------ CERTO: --------------------------
ALTER TABLE empregado 
ADD COLUMN nome_empregado varchar(50);

UPDATE empregado
set nome_empregado = 'CR7'
where cod_empregado = 1;

ALTER TABLE empregado 
ALTER COLUMN nome_empregado SET NOT NULL;

-----------------------------------------------------

-- VIEW:
 --create or replace

CREATE VIEW vw_emp_depto AS
SELECT nome_empregado, sexo_empreago FROM empregado

SELECT nome_empregado FROM vw_emp_depto

