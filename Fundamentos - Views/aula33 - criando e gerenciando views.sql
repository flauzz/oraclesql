-- criando e gerenciando views
-- view: representa��o l�gica de um select baseado em uma ou mais tabela e vis�es
-- � um select armazenado em um dicion�rio de dados com um nome
-- vantagens: restringe o acesso ao dados,
-- podem ser selecionadas apenas as colunas que s�o permitidas, dando o privil�gio para view e n�o para tabela
-- torna simples consultas complexas. salva-se selects complexos para q n�o seja mais necess�rio mont�-los
-- proporciona independ�ncia dos dados originais
-- por padr�o noforce, para n�o criar uma view com um select errado
-- criando uma view:
CREATE OR REPLACE VIEW vemployeesdept60
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 60;
--ao criar uma view o oracle armazena o select no dicion�rio de dados
DESC vemployeesdept60; --visualiza e estrutura da view, parecido com a tabela

SELECT *
FROM vemployeesdept60;
--oracle vai no dicion�rio de dados, procura a view e executa o select e retorna o resultado

CREATE OR REPLACE VIEW vemployeesdept60
AS SELECT employee_id, first_name, last_name, department_id, salary, commission_pct
FROM employees
WHERE department_id = 60;

DESC vemployeesdept60;

-- criando uma vis�o complexa:
CREATE OR REPLACE VIEW vdepartments_total
(department_id, department_name, minsal, maxsal, avgsal) --renomeando o nome das colunas na view
AS SELECT e.department_id, d.department_name, MIN(e.salary), MAX(e.salary), AVG(e.salary)
FROM employees e JOIN departments d
                 ON (e.department_id = d.department_id)
GROUP BY e.department_id, department_name;

SELECT *
FROM vdepartments_total;

--regras para usar delete em uma view:
--n�o pode haver fun��es de grupo, cl�usla group by, distinct e pseudo-coluna rownum
--regras para usar update em uma view:
--n�o pode haver fun��es de grupo, cl�usla group by, distinct, pseudo-coluna rownum e colunas definidas por express�es
--regras para usar insert em uma view:
--n�o pode haver fun��es de grupo, cl�usla group by, distinct, pseudo-coluna rownum, colunas definidas por express�es
--e colunas not null na tabela base que n�o estejam no select da vis�o

--check option: cria uma valida��o a ser checada antes de adicionar algo
--por padr�o a cl�usla where apenas indica que dados pegarei
--mas usando check option ela se torna uma valida��o
--ou seja, no caso posterior, n�o d� mais para adicionar um funcion�rio com department_id diferente de 100
CREATE OR REPLACE VIEW vemployeesdept100
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 100
WITH CHECK OPTION CONSTRAINT vemployeesdept100_ck;

--with read only: poss�vel criar uma view que n�o permite opera��es dml de maneira alguma
CREATE OR REPLACE VIEW vemployeesdept20
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 20
WITH READ ONLY;

--removendo uma view: ao remover uma view os dados da tabela de origem permancem
DROP VIEW vemployeesdept20;