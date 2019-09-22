USE empresa;

-- QUESTÃO 1
SELECT CONCAT(e.pnome, ' ', e.minicial, '. ', e.unome)
FROM empregado AS e;

-- QUESTÃO 2
SELECT d.dnome, d.dnumero
FROM departamento AS d;

-- QUESTÃO 3
SELECT p.pnumero, p.pjnome, p.plocalizacao
FROM projeto AS p;

-- QUESTÃO 4
SELECT e.ssn,
	   e.pnome,
       DATE_FORMAT(e.datanasc, '%d-%m-%Y')
FROM empregado AS e
WHERE e.sexo = 'M';

-- QUESTÃO 5
SELECT e.pnome
FROM empregado AS e
WHERE e.superssn IS NULL;

-- QUESTÃO 6
SELECT d.nome_dependente
FROM dependente AS d
WHERE d.parentesco = 'CÔNJUGE';

-- QUESTÃO 7
SELECT e.pnome
FROM empregado AS e
WHERE e.salario > 30000;

-- QUESTÃO 8
SELECT e.pnome
FROM empregado AS e
WHERE e.sexo = 'F' AND e.salario > 25000;

-- QUESTÃO 9
SELECT e.pnome
FROM empregado AS e 
WHERE e.pnome LIKE 'J%';

-- QUESTÃO 10
SELECT e.pnome
FROM empregado AS e
WHERE e.endereco LIKE '%Houston%';

-- QUESTÃO 11
SELECT d.nome_dependente,
       DATE_FORMAT(d.datanasc, '%d-%m-%Y')
FROM dependente AS d
WHERE d.parentesco = 'CÔNJUGE' OR d.parentesco = 'FILHO';

-- QUESTÃO 12
SELECT p.pjnome
FROM projeto AS p
WHERE p.plocalizacao = 'Stafford';

-- QUESTÃO 13
SELECT CONCAT(e.pnome, ' ', e.unome)
FROM empregado AS e
WHERE e.sexo = 'F' AND e.salario > 3000 AND e.endereco LIKE '%Berry%';

-- QUESTÃO 14
SELECT e.pnome
FROM empregado AS e
WHERE e.salario BETWEEN '38000' AND '43000';

-- QUESTÃO 15
SELECT e.dno,
	   e.sexo,
       COUNT(e.sexo)
FROM empregado AS e
GROUP BY e.dno,
		 e.sexo;

-- QUESTÃO 16
SELECT e.dno, 
	   COUNT(e.dno)
FROM empregado AS e
GROUP BY e.dno;

-- QUESTÃO 17
SELECT p.dnum,
	   COUNT(p.dnum)
FROM projeto AS p
GROUP BY p.dnum;

-- QUESTÃO 18
SELECT e.dno,
	   AVG(e.salario)
FROM empregado AS e
GROUP BY e.dno;

-- QUESTÃO 19
SELECT e.sexo,
	   MAX(e.salario)
FROM empregado AS e
GROUP BY e.sexo;

-- QUESTÃO 20
SELECT e.dno,
	   SUM(e.salario)
FROM empregado AS e
WHERE e.dno = '4'
GROUP BY e.dno;

-- QUESTÃO 21
SELECT AVG(e.salario)
FROM empregado AS e
WHERE e.sexo = 'M' AND e.endereco LIKE "%Houston%";

-- QUESTÃO 22
SELECT e.pnome,
	   COUNT(e.pnome)
FROM empregado AS e
GROUP BY e.pnome;

-- QUESTÃO 23
SELECT d.parentesco,
	   COUNT(d.parentesco)
FROM dependente AS d
GROUP BY d.parentesco;

-- QUESTÃO 24
SELECT e.pnome
FROM empregado AS e
ORDER BY e.pnome;

-- QUESTÃO 25
SELECT e.pnome
FROM empregado AS e
ORDER BY e.datanasc ASC;

-- QUESTÃO 26
SELECT e.pnome
FROM empregado AS e
ORDER BY e.salario DESC,
		 e.pnome ASC;

-- QUESTÃO 27
SELECT e.pnome,
	   COUNT(d.essn)
FROM empregado AS e
INNER JOIN dependente AS d
ON (d.essn = e.ssn)
GROUP BY (e.pnome);

-- QUESTÃO 28
SELECT e.pnome, e.datanasc, d.nome_dependente, d.datanasc
FROM empregado AS e
INNER JOIN dependente AS d
ON (d.essn = e.ssn AND d.parentesco = 'CÔNJUGE' AND e.datanasc < d.datanasc);

-- QUESTÃO 29
SELECT e.pnome
FROM empregado AS e
INNER JOIN trabalha_em AS t
ON (e.ssn = t.essn)
INNER JOIN projeto AS p
ON (t.pno = p.pnumero AND e.dno <> p.dnum)
GROUP BY e.pnome;

-- QUESTÃO 30
SELECT e.ssn,
	   e.pnome,
       e.salario,
       (e.salario - a.media) AS diferenca_salarial
FROM empregado AS e
INNER JOIN
	(SELECT AVG(e.salario) AS media, e.sexo
	 FROM empregado AS e
	 GROUP BY e.sexo
	) AS a
ON (e.sexo = a.sexo)
GROUP BY e.pnome;

-- QUESTÃO 31
SELECT e.ssn,
	   e.pnome,
       h.total_horas
FROM empregado AS e
INNER JOIN
	(SELECT SUM(t.horas) AS total_horas, t.essn
	 FROM trabalha_em AS t
	 GROUP BY t.essn
	) AS h
ON (h.essn = e.ssn AND h.total_horas > 40.0)
GROUP BY e.ssn;

-- QUESTÃO 32
SELECT e.pnome,
	   COUNT(d.nome_dependente)
FROM empregado AS e
LEFT JOIN dependente AS d
ON (e.ssn = d.essn)
GROUP BY e.pnome;

-- QUESTÃO 33
SELECT e.ssn,
	   e.pnome
FROM empregado AS e
INNER JOIN trabalha_em AS t
ON (e.ssn = t.essn)
INNER JOIN projeto AS p
ON (t.pno = p.pnumero AND e.dno = p.dnum)
WHERE e.ssn NOT IN
	(SELECT e.ssn
	 FROM empregado AS e
     INNER JOIN trabalha_em AS t
     ON (e.ssn = t.essn)
     INNER JOIN projeto AS p
     ON (t.pno = p.pnumero AND e.dno <> p.dnum)
     GROUP BY e.ssn)
GROUP BY e.ssn;

-- QUESTÃO 34
SELECT e.ssn,
	   e.pnome,
       e.datanasc
FROM empregado AS e
INNER JOIN
	(SELECT COUNT(*) AS qtd_dependentes, d.essn
	 FROM dependente AS d
     GROUP BY d.essn
	) AS q
ON (e.ssn = q.essn AND q.qtd_dependentes > 1)
    
INNER JOIN
	(SELECT SUM(t.horas) AS total_horas, t.essn
	 FROM trabalha_em AS t
     GROUP BY t.essn) AS h
ON (e.ssn = h.essn AND h.total_horas > 5.0)
    
INNER JOIN trabalha_em AS t
ON (e.ssn = t.essn)
    
INNER JOIN projeto AS p
ON (t.pno = p.pnumero AND p.plocalizacao = 'Houston')
GROUP BY e.ssn;

-- QUESTÃO 35
SELECT e.ssn,
	   e.pnome,
       p.pjnome,
       t.horas
FROM empregado AS e
INNER JOIN trabalha_em AS t
ON (e.ssn = t.essn)
INNER JOIN projeto AS p
ON (t.pno = p.pnumero)
ORDER BY e.ssn ASC;

-- QUESTÃO 36
SELECT e.ssn,
	e.superssn,
    e.salario
FROM empregado AS e
INNER JOIN empregado AS s
ON (e.superssn = s.ssn)
WHERE (e.salario > s.salario);

-- QUESTÃO 37
SELECT e.pnome,
	   e.salario,
       s.pnome,
       s.salario,
       (e.salario - s.salario) AS diferenca_salarial
FROM empregado AS e
INNER JOIN empregado AS s
ON (e.superssn = s.ssn);

-- QUESTÃO 38
SELECT p.pjnome,
       d.dnome,
       p.plocalizacao,
       x.qtd_empregados
FROM projeto AS p
INNER JOIN
	(SELECT COUNT(*) AS qtd_empregados, t.pno
	 FROM trabalha_em AS t
	 GROUP BY t.pno) AS x
ON (x.pno = p.pnumero)
INNER JOIN departamento AS d
ON (p.dnum = d.dnumero);
    
-- QUESTÃO 39
SELECT e.pnome,
	   e.ssn
FROM empregado AS e
INNER JOIN
	(SELECT d.gerssn, COUNT(*) AS qtd_departamentos
	 FROM departamento AS d
	 GROUP BY d.gerssn) AS x
ON (e.ssn = x.gerssn)
WHERE (x.qtd_departamentos > 1);

-- QUESTÃO 40
SELECT e.ssn,
	   e.pnome,
       e.dno
FROM empregado AS e
INNER JOIN departamento AS d
ON (e.ssn = d.gerssn)
WHERE (e.dno <> d.dnumero);

-- QUESTÃO 41
SELECT e.ssn,
	   e.pnome
FROM empregado AS e
INNER JOIN dependente AS d
ON (e.ssn = d.essn)
WHERE d.parentesco <> 'CONJUGE'
GROUP BY e.ssn;