SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11789)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2012 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 171 (class 1259 OID 381980)
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fornecedor (
    fcodigo integer NOT NULL,
    fnome character varying(30),
    fstatus integer,
    fcidade character varying(30),
	primary key (fcodigo)
);


ALTER TABLE public.fornecedor OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 381992)
-- Name: fornecedor_fcodigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fornecedor_fcodigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fornecedor_fcodigo_seq OWNER TO postgres;

--
-- TOC entry 2013 (class 0 OID 0)
-- Dependencies: 175
-- Name: fornecedor_fcodigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fornecedor_fcodigo_seq OWNED BY fornecedor.fcodigo;


--
-- TOC entry 173 (class 1259 OID 381986)
-- Name: peca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE peca (
    pcodigo integer NOT NULL,
    pnome character varying(30),
    cor character varying(20),
    peso integer,
    pcidade character varying(30),
	primary key (pcodigo)
);


ALTER TABLE public.peca OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 381994)
-- Name: peca_pcodigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE peca_pcodigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peca_pcodigo_seq OWNER TO postgres;

--
-- TOC entry 2014 (class 0 OID 0)
-- Dependencies: 176
-- Name: peca_pcodigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE peca_pcodigo_seq OWNED BY peca.pcodigo;


--
-- TOC entry 174 (class 1259 OID 381989)
-- Name: projeto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE projeto (
    jcodigo integer NOT NULL,
    jnome character varying(30),
    jcidade character varying(30),
	primary key (jcodigo)
);


ALTER TABLE public.projeto OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 381996)
-- Name: projeto_jcodigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projeto_jcodigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projeto_jcodigo_seq OWNER TO postgres;

--
-- TOC entry 2015 (class 0 OID 0)
-- Dependencies: 177
-- Name: projeto_jcodigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projeto_jcodigo_seq OWNED BY projeto.jcodigo;


--
-- TOC entry 1877 (class 2604 OID 381998)
-- Name: fcodigo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fornecedor ALTER COLUMN fcodigo SET DEFAULT nextval('fornecedor_fcodigo_seq'::regclass);


--
-- TOC entry 1878 (class 2604 OID 381999)
-- Name: pcodigo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peca ALTER COLUMN pcodigo SET DEFAULT nextval('peca_pcodigo_seq'::regclass);


--
-- TOC entry 1879 (class 2604 OID 382000)
-- Name: jcodigo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projeto ALTER COLUMN jcodigo SET DEFAULT nextval('projeto_jcodigo_seq'::regclass);


--
-- TOC entry 172 (class 1259 OID 381983)
-- Name: fornecimento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fornecimento (
    fcodigo integer NOT NULL,
    pcodigo integer NOT NULL,
    jcodigo integer NOT NULL,
    quantidade integer,
	constraint fornecimento_peca_fk foreign key (pcodigo)
	references peca(pcodigo)
	on update restrict on delete restrict,
	constraint fornecimento_fornecedor_fk foreign key (fcodigo)
	references fornecedor(fcodigo)
	on update restrict on delete restrict,
	constraint fornecimento_projeto_fk foreign key(jcodigo)
	references projeto(jcodigo)
	on update restrict on delete restrict,
	primary key (fcodigo,pcodigo,jcodigo)
);


ALTER TABLE public.fornecimento OWNER TO postgres;

insert into fornecedor (fnome, fstatus, fcidade) values ('Loja das Peças', 20, 'Londrina');
insert into fornecedor (fnome, fstatus, fcidade) values ('Peças Brasil', 10, 'Ribeirão Preto');
insert into fornecedor (fnome, fstatus, fcidade) values ('Carrefour', 20, 'Ribeirão Preto');
insert into fornecedor (fnome, fstatus, fcidade) values ('Marks', 20, 'Londrina');
insert into fornecedor (fnome, fstatus, fcidade) values ('Leroy Merlin', 20, 'Vitória');

insert into peca (pnome, cor, peso, pcidade) values ('Porca', 'Vermelho', 12, 'Londrina');
insert into peca (pnome, cor, peso, pcidade) values ('Parafuso de porca', 'Verde', 17, 'Ribeirão Preto');
insert into peca (pnome, cor, peso, pcidade) values ('Parafuso simples', 'Azul', 17, 'Niterói');
insert into peca (pnome, cor, peso, pcidade) values ('Parafuso simples', 'Vermelho', 14, 'Londrina');
insert into peca (pnome, cor, peso, pcidade) values ('Prego', 'Azul', 12, 'Ribeirão Preto');
insert into peca (pnome, cor, peso, pcidade) values ('Roda dentada', 'Vermelho', 19, 'Londrina');

insert into projeto (jnome, jcidade) values ('Raiz','Ribeirão Preto');
insert into projeto (jnome, jcidade) values ('Saraiva','Niterói');
insert into projeto (jnome, jcidade) values ('Pedreira','Vitória');
insert into projeto (jnome, jcidade) values ('RM &  S','Vitória');
insert into projeto (jnome, jcidade) values ('MRV','Londrina');
insert into projeto (jnome, jcidade) values ('Simplus','Osasco');
insert into projeto (jnome, jcidade) values ('Tatico','Londrina');

insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (1,1,1,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (1,1,4,700);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,1,400);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,2,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,3,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,4,500);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,5,600);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,6,400);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,3,7,800);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (2,5,2,100);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (3,3,1,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (3,4,2,500);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (4,6,3,300);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (4,6,7,300);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,2,2,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,2,4,100);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,5,5,500);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,5,7,100);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,6,2,200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,1,4,1000);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,3,4,1200);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,4,4,800);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,5,4,400);
insert into fornecimento (fcodigo, pcodigo, jcodigo, quantidade) values (5,6,4,500);



