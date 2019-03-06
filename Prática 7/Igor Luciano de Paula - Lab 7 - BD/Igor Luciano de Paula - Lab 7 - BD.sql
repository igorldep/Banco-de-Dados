﻿--					  Igor Luciano de Paula - Lab 7



-- ---------------------------------------------------- A ------------------------------------------------------------

create user "Igor Luciano"

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- B ------------------------------------------------------------

CREATE OR REPLACE VIEW quest2 AS
select DISTINCT (f.nm_funcionario), f.dt_admissao  from funcionario f
inner join encomenda e ON e.id_funcionario = f.id_funcionario
inner join cliente c ON c.id_cliente = e.id_cliente  
where c.nm_cidade_cliente != f.nm_cidade_funcionario
UNION
select  DISTINCT (f.nm_funcionario), f.dt_admissao from funcionario f
inner join pedido p ON p.id_funcionario = f.id_funcionario 
inner join cliente c ON c.id_cliente = p.id_cliente

select * from quest2;

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- C ------------------------------------------------------------

create user "Eduardo Junqueira"
alter user "Eduardo Junqueira" WITH PASSWORD '123456dudu';

GRANT ALL PRIVILEGES ON DATABASE lab7 TO "Eduardo Junqueira"
GRANT SELECT ON quest2 TO "Eduardo Junqueira"

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- D ------------------------------------------------------------

GRANT EXECUTE ON FUNCTION livros_vendidos(varchar(40))
TO "Eduardo Junqueira"

GRANT EXECUTE ON FUNCTION VendidosPorMesAno()
TO "Eduardo Junqueira"

GRANT EXECUTE ON FUNCTION PedidosPorCliente (integer)
TO "Eduardo Junqueira"

GRANT EXECUTE ON FUNCTION ClientesComPrazoVencido ()


-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- E ------------------------------------------------------------

CREATE OR REPLACE FUNCTION livros_vendidos (varchar(40))
RETURNS VOID AS
$$ 
	DECLARE
		x RECORD;
		nome_livro alias for $1;
		quantidade INTEGER;
	BEGIN
		quantidade := 0;
		
		SELECT INTO quantidade vl_quantidade FROM livro l
		INNER JOIN encomenda_livro el ON el.id_isbn = l.id_isbn
		WHERE nm_titulo = nome_livro;

		RAISE NOTICE ' quantidade de livros % encomendados: %', nome_livro, quantidade;
		
	END;
$$
LANGUAGE 'plpgsql'

select * from livros_vendidos ('Helena');

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- F ------------------------------------------------------------

CREATE OR REPLACE FUNCTION VendidosPorMesAno ()
RETURNS VOID AS
$$ 
	DECLARE
		reg RECORD;
		qtde INTEGER;
	BEGIN
		qtde := 0;
		FOR reg IN SELECT extract (year from dt_encomenda) ano, extract (month from dt_encomenda) mes, count(*) soma FROM livro l
		INNER JOIN encomenda_livro el ON el.id_isbn = l.id_isbn
		INNER JOIN encomenda e ON e.id_encomenda = el.id_encomenda
		group by (extract (year from dt_encomenda), extract (month from dt_encomenda))
		order by 1 asc
		LOOP
			qtde := qtde + 1;
			RAISE NOTICE '% - ano: % , mês: % -> total: % ', qtde, reg.ano, reg.mes, reg.soma;
		END LOOP;
	END;
$$
LANGUAGE 'plpgsql'

select * from VendidosPorMesAno ();

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- G ------------------------------------------------------------

CREATE OR REPLACE FUNCTION PedidosPorCliente (integer)
RETURNS VOID AS
$$ 
	DECLARE
		nomeCliente alias for $1;
		reg RECORD;
		qtde INTEGER;
	BEGIN
		qtde := 0;
		FOR reg IN SELECT c.id_cliente, l.nm_titulo, pcl.id_palavra_chave FROM cliente c
 		INNER JOIN pedido p ON c.id_cliente = p.id_cliente
 		INNER JOIN pedido_livro pl ON p.id_pedido = pl.id_pedido
 		INNER JOIN livro l ON l.id_isbn = pl.id_isbn
 		INNER JOIN palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
 		group by (c.id_cliente, l.nm_titulo, pcl.id_palavra_chave)
		LOOP
			IF(reg.id_cliente = nomeCliente)
			THEN
				qtde := qtde + 1;
				RAISE NOTICE '% - % ', qtde, reg.nm_titulo;
			END IF;	
		END LOOP;
	END;
$$
LANGUAGE 'plpgsql'
 		

select * from PedidosPorCliente(1);

-- -------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------- H ------------------------------------------------------------

CREATE OR REPLACE FUNCTION ClientesComPrazoVencido ()
RETURNS VOID AS
$$ 
	DECLARE
		reg RECORD;
		qtde INTEGER;
	BEGIN
		qtde := 0;
		FOR reg IN SELECT * FROM cliente c
 		INNER JOIN encomenda e ON c.id_cliente = e.id_cliente
 		INNER JOIN encomenda_livro el ON e.id_encomenda = el.id_encomenda
 		INNER JOIN livro l ON l.id_isbn = el.id_isbn
 		INNER JOIN palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
		LOOP
			IF(reg.nu_prazo_estimado > 7)
			THEN
				qtde := qtde + 1;
				RAISE NOTICE '% - Dados do cliente: % - % - % - % - % ...', qtde, reg.nm_cliente, reg.nu_telefone_cliente, reg.nu_rg_cliente, reg.nu_cep_cliente, reg.nu_residencia_cliente;
			END IF;	
		END LOOP;
	END;
$$
LANGUAGE 'plpgsql'

select * from ClientesComPrazoVencido();

-- -------------------------------------------------------------------------------------------------------------------

