-- 				Igor Luciano de Paula - Lab 9



-- a)
-- 

CREATE OR REPLACE FUNCTION TG_quest1 ()
RETURNS TRIGGER AS
$$
	DECLARE
		qtde INTEGER;
	BEGIN
		select INTO qtde count(*) from encomenda;
		IF(qtde > 5)
		THEN
			RAISE NOTICE 'A quantidade de encomendas pendentes é maior que 5';
		END IF;
		RETURN NULL;
	END;
$$
LANGUAGE 'plpgsql'

SELECT * FROM TG_quest1();

CREATE TRIGGER "questao1"
BEFORE INSERT ON encomenda
FOR EACH ROW
EXECUTE PROCEDURE TG_quest1();

INSERT INTO encomenda values (15,10,10,'1998-03-03',10)

-----------------------


--------------------- b


select pl.id_pedido, sum(vl_quantidade), p.vl_total_pago from pedido p 
inner join pedido_livro pl on pl.id_pedido = p.id_pedido
group by (pl.id_pedido, p.vl_total_pago)


CREATE OR REPLACE FUNCTION TG_quest2 ()
RETURNS TRIGGER AS
$$
	DECLARE
		qtde INTEGER;
		reg RECORD;
		vl_desconto FLOAT;
	BEGIN
		FOR reg IN select pl.id_pedido, sum(vl_quantidade), p.vl_total_pago from pedido p 
		inner join pedido_livro pl on pl.id_pedido = p.id_pedido
		group by (pl.id_pedido, p.vl_total_pago)
		LOOP
			IF(reg.sum >= 3) -- (reg.sum >= 10)
			THEN
				vl_desconto := (0.9 * reg.vl_total_pago);
				RAISE NOTICE 'O valor, com desconto, do pedido % é de: %', reg.id_pedido, vl_desconto;
			END IF;
		END LOOP;
		RETURN NULL;
	END;
$$
LANGUAGE 'plpgsql'

select * from TG_questaoo2();

CREATE TRIGGER "quest2"
AFTER INSERT ON pedido_livro
FOR EACH ROW
EXECUTE PROCEDURE TG_quest2();

INSERT INTO pedido_livro values (0000000010, 4,10)

-- -----------------------------------------------------------------------------

-- c)

CREATE OR REPLACE FUNCTION TG_quest3()
RETURNS TRIGGER AS
$$
	DECLARE
		qtde INTEGER;
		reg RECORD;
		reg2 RECORD;
		vl_desconto FLOAT;
	BEGIN
		FOR reg IN select * from pedido p
		inner join cliente c ON c.id_cliente = p.id_cliente
		inner join pedido_livro pl ON pl.id_pedido = p.id_pedido
		inner join livro l ON l.id_isbn = pl.id_isbn
		inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
		inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
		where extract (year from p.dt_pedido) <= (extract (year from CURRENT_DATE) - 1) -- analisando apenas o ano
		and pc.te_descricao in (select pc.te_descricao from livro l
		inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
		inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
		where extract (year from l.dt_publicacao) > 1998 -- considerando > 1998 como recente
		)
		LOOP
			RAISE NOTICE 'Ola %, confira nossos novos lançamentos: %; baseado em um de seus pedidos', reg.nm_cliente, reg.nm_titulo;
		END LOOP;

		FOR reg2 IN select * from encomenda e
		inner join cliente c ON c.id_cliente = e.id_cliente
		inner join encomenda_livro el ON el.id_encomenda = e.id_encomenda
		inner join livro l ON l.id_isbn = el.id_isbn
		inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
		inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
		where extract (year from e.dt_encomenda) <= (extract (year from CURRENT_DATE) - 1)
		and pc.te_descricao in (select pc.te_descricao from livro l
		inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
		inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
		where extract (year from l.dt_publicacao) > 1998
		)
		LOOP
			RAISE NOTICE 'Ola %, confira nossos novos lançamentos: %; baseado em uma de suas encomendas', reg2.nm_cliente, reg2.nm_titulo;
		END LOOP;
		RETURN NULL;
	END;
$$
LANGUAGE 'plpgsql'


select * from TG_quest3();

CREATE TRIGGER "quest33333"
AFTER INSERT ON editora
FOR EACH ROW
EXECUTE PROCEDURE TG_quest3();

INSERT INTO editora values (10, 'CEFET-MG', 66666666)


-----------
select * from editora

inner join encomenda_livro 

select * from livro
select * from palavra_chave pc
inner join palavra_chave_livro pcl ON pc.id_palavra_chave = pcl.id_palavra_chave

select * from pedido p
inner join cliente c ON c.id_cliente = p.id_cliente
inner join pedido_livro pl ON pl.id_pedido = p.id_pedido
inner join livro l ON l.id_isbn = pl.id_isbn
inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
where extract (year from p.dt_pedido) <= (extract (year from CURRENT_DATE) - 1) -- analisando apenas o ano
and pc.te_descricao in (select pc.te_descricao from livro l
inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
where extract (year from l.dt_publicacao) > 1998 -- considerando > 1998 como recente
)

select * from encomenda e
inner join cliente c ON c.id_cliente = e.id_cliente
inner join encomenda_livro el ON el.id_encomenda = e.id_encomenda
inner join livro l ON l.id_isbn = el.id_isbn
inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
where extract (year from e.dt_encomenda) <= (extract (year from CURRENT_DATE) - 1)
and pc.te_descricao in (select pc.te_descricao from livro l
inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
where extract (year from l.dt_publicacao) > 1998 -- considerando > 1998 como recente
)


select pc.te_descricao from livro l
inner join palavra_chave_livro pcl ON pcl.id_isbn = l.id_isbn
inner join palavra_chave pc ON pc.id_palavra_chave = pcl.id_palavra_chave
where extract (year from l.dt_publicacao) > 1998 -- considerando > 1998 como recente


select * from CURRENT_DATE

select * from encomenda_livro


select * from encomenda

select * from pedido



