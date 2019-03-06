-- 						Prática 4 - Igor Luciano de Paula

﻿select * from curso;

select * from empregado;

select * from empregado_curso;

select * from historico_emprego;

select * from departamento;


------------------------------ 1 ---------------------------------

select nm_empregado, nm_sobrenome from empregado e 
inner join historico_emprego he ON e.nu_empregado = he.nu_empregado
where he.nm_cargo = 'Accountant';

------------------------------------------------------------------


------------------------------ 2 ---------------------------------

select e.nm_empregado as NomeEmpregado, e.nm_sobrenome as SobrenomeEmpregado from empregado e 
inner join empregado_curso ec ON ec.nu_empregado = e.nu_empregado
inner join curso c ON ec.nu_curso = c.nu_curso
where c.nm_curso = 'Ada' OR c.nm_curso = 'LANs';

------------------------------------------------------------------


------------------------------ 3 ---------------------------------

select c.nm_curso , count(*) from empregado e 
inner join empregado_curso ec ON ec.nu_empregado = e.nu_empregado
inner join curso c ON ec.nu_curso = c.nu_curso
group by c.nm_curso
having (count(c.nm_curso) < 10)
order by 1 desc;

------------------------------------------------------------------


------------------------------ 4 ---------------------------------

select d.nm_depto, count(*) from departamento d 
inner join empregado e ON e.nu_depto = d.nu_depto
group by (d.nm_depto)
order by 1 asc;

------------------------------------------------------------------


------------------------------ 5 ---------------------------------

select d.nm_depto, count(*) from departamento d 
inner join empregado e ON e.nu_depto = d.nu_depto
group by (d.nm_depto)
having (count(*) > 6)

------------------------------------------------------------------


------------------------------ 6 ---------------------------------

select e.nm_empregado, e.nm_sobrenome from departamento d 
inner join empregado e ON e.nu_depto = d.nu_depto
where d.nm_depto IN (
	select d.nm_depto from departamento d 
	inner join empregado e ON e.nu_depto = d.nu_depto
	group by (d.nm_depto)
	having (count(*) = 6)
);
------------------------------------------------------------------


------------------------------ 7 ---------------------------------

select e.nm_empregado, e.nm_sobrenome from historico_emprego he
NATURAL join empregado e 
where (
	(extract (year from he.dt_fim) - extract (year from he.dt_inicio) > 3)
)
group by (e.nm_empregado, e.nm_sobrenome);

------------------------------------------------------------------


------------------------------ 8 ---------------------------------

select c.nm_curso, c.dt_curso from curso c
NATURAL join curso ce
where ((ce.dt_curso = c.dt_curso) AND (c.nm_curso != ce.nm_curso));

------------------------------------------------------------------


------------------------------ 9 ---------------------------------

select nm_curso from curso
where nm_curso NOT IN (
	select c.nm_curso from curso c
	NATURAL join empregado e
	NATURAL join empregado_curso ec
);

------------------------------------------------------------------


------------------------------ 10 ---------------------------------

select nm_curso from curso 
where ( (extract (month from dt_curso) = 10) );

------------------------------------------------------------------


------------------------------ 11 ---------------------------------

select c.nm_curso, count(*) as num from empregado e 
inner join empregado_curso ec ON ec.nu_empregado = e.nu_empregado
inner join curso c ON ec.nu_curso = c.nu_curso
group by c.nm_curso
having (count(c.nm_curso) > 0)
order by 2 desc
limit 2

------------------------------------------------------------------


------------------------------ 12 ---------------------------------

select nm_sobrenome, nm_empregado from empregado
order by dt_nascimento LIMIT 3

------------------------------------------------------------------
