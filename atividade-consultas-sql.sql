use empresa;

-- QUESTÃO 1
select concat(e.pnome, ' ', e.minicial, '. ', e.unome)
from empregado as e;

-- QUESTÃO 2
select d.dnome, d.dnumero
from departamento as d;

-- QUESTÃO 3
select p.pnumero, p.pjnome, p.plocalizacao
from projeto as p;

-- QUESTÃO 4
select e.ssn,
	   e.pnome,
       date_format(e.datanasc, '%d-%m-%Y')
from empregado as e
where e.sexo = 'M';

-- QUESTÃO 5
select e.pnome
from empregado as e
where e.superssn is null;

-- QUESTÃO 6
select d.nome_dependente
from dependente as d
where d.parentesco = 'CÔNJUGE';

-- QUESTÃO 7
select e.pnome
from empregado as e
where e.salario > 30000;

-- QUESTÃO 8
select e.pnome
from empregado as e
where e.sexo = 'F' and e.salario > 25000;

-- QUESTÃO 9
select e.pnome
from empregado as e 
where e.pnome like 'J%';

-- QUESTÃO 10
select e.pnome
from empregado as e
where e.endereco like '%Houston%';

-- QUESTÃO 11
select d.nome_dependente,
       date_format(d.datanasc, '%d-%m-%Y')
from dependente as d
where d.parentesco = 'CÔNJUGE' or d.parentesco = 'FILHO';

-- QUESTÃO 12
select p.pjnome
from projeto as p
where p.plocalizacao = 'Stafford';

-- QUESTÃO 13
select concat(e.pnome, ' ', e.unome)
from empregado as e
where e.sexo = 'F' and e.salario > 3000 and e.endereco like '%Berry%';

-- QUESTÃO 14
select e.pnome
from empregado as e
where e.salario between '38000' and '43000';

-- QUESTÃO 15
select e.dno, e.sexo,
count(e.sexo)
from empregado as e
group by e.dno, e.sexo;

-- QUESTÃO 16
select e.dno, 
count(e.dno)
from empregado as e
group by e.dno;

-- QUESTÃO 17
select p.dnum,
count(p.dnum)
from projeto as p
group by p.dnum;

-- QUESTÃO 18
select e.dno,
avg(e.salario)
from empregado as e
group by e.dno;

-- QUESTÃO 19
select e.sexo,
max(e.salario)
from empregado as e
group by e.sexo;

-- QUESTÃO 20
select e.dno,
sum(e.salario)
from empregado as e
where e.dno = '4'
group by e.dno;

-- QUESTÃO 21
select avg(e.salario)
from empregado as e
where e.sexo = 'M' and e.endereco like "%Houston%";

-- QUESTÃO 22
select e.pnome,
count(e.pnome)
from empregado as e
group by e.pnome;

-- QUESTÃO 23
select d.parentesco,
count(d.parentesco)
from dependente as d
group by d.parentesco;

-- QUESTÃO 24
select e.pnome
from empregado as e
order by e.pnome;

-- QUESTÃO 25
select e.pnome
from empregado as e
order by e.datanasc asc ;

-- QUESTÃO 26
select e.pnome
from empregado as e
order by e.salario desc, e.pnome asc;

-- QUESTÃO 27
select e.pnome, count(d.essn)
from empregado as e
inner join dependente as d
on (d.essn = e.ssn)
group by (e.pnome);

-- QUESTÃO 28
select e.pnome, e.datanasc, d.nome_dependente, d.datanasc
from empregado as e
inner join dependente as d
on (d.essn = e.ssn and d.parentesco = 'CÔNJUGE' and e.datanasc < d.datanasc);

-- QUESTÃO 29
select e.pnome
from empregado as e
	inner join trabalha_em as t
	on (e.ssn = t.essn)
	inner join projeto as p
	on (t.pno = p.pnumero and e.dno <> p.dnum)
group by e.pnome;