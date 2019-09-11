-- QUESTÕES DESAFIO


-- 30. Selecione o ssn, o nome, e a diferença salarial em relação à média por sexo dos funcionários.
select e.ssn, e.pnome, e.salario, (e.salario - a.media) as diferenca_salarial
from empregado as e
inner join (select avg(e.salario) as media, e.sexo
			from empregado as e
			group by e.sexo) as a
on (e.sexo = a.sexo)
group by e.pnome;


-- 31. Selecione o ssn e o nome todos os empregados que trabalham mais de 40 horas.
select e.ssn, e.pnome, h.total_horas
from empregado as e
	inner join (select sum(t.horas) as total_horas, t.essn
				from trabalha_em as t
	            group by t.essn) as h
	on (h.essn = e.ssn and h.total_horas > 40.0)
group by e.ssn;


-- 32. Selecione o nome e a quantidades de dependentes de todos os funcionários.
-- Minha solução
select e.pnome, q.qtd_dependentes
from empregado as e
	inner join (select count(*) as qtd_dependentes, d.essn
				from dependente as d
	            group by d.essn) as q
	on (e.ssn = q.essn)
group by e.pnome;

-- Solução de Diogo
select e.pnome, count(d.nome_dependente)
from empregado as e
left join dependente as d
on e.ssn = d.essn
group by e.pnome;

-- 34. Selecione o ssn, nome e data de nascimento de todos os empregados que tem mais de um
-- dependente, que trabalham mais de 5 horas e cujo departamento do projeto esteja em "Houston".
select e.ssn, e.pnome, e.datanasc
from empregado as e
	inner join (select count(*) as qtd_dependentes, d.essn
				from dependente as d
				group by d.essn) as q
	on (e.ssn = q.essn and q.qtd_dependentes > 1)
    
	inner join (select sum(t.horas) as total_horas, t.essn
				from trabalha_em as t
				group by t.essn) as h
	on (e.ssn = h.essn and h.total_horas > 5.0)
    
    inner join (select t.pno, t.essn
				from trabalha_em as t) as n
	on (e.ssn = n.essn)
    
    inner join (select p.pnumero, p.plocalizacao
				from projeto as p) as l
    on (n.pno = l.pnumero and l.plocalizacao = 'Houston')
group by e.ssn;