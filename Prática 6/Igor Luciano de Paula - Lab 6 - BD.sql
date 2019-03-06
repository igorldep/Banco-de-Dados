-- 					Igor Luciano de Paula - Lab 6 - BD



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

-- --------

SELECT convidados_tt ('Igor', '03-10-2018');

-------------------------------------------------------------------------------------------------------------


---------------------------------------------------  3  -----------------------------------------------------------

CREATE OR REPLACE VIEW vw_musicos AS
SELECT nm_musico FROM musico
inner join interprete on interprete.nu_musico_interprete = musico.nu_musico
natural join atuacao
GROUP BY nm_musico
HAVING COUNT(*) > 1;

select * from vw_musicos

-----------------------------------------------------------------------------------------------


