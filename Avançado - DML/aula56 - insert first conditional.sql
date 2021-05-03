--insert first conditional
--segue o mesmo princ�pio da insert all, mas realiza apenas a primeira cl�usula when que for satisfeita/verdadeira
--pode inserir um else ao final para o caso de nenhum when ser verdadeiro
--apagando e criando a tabela low_salaries inicialmente vazia:
DROP TABLE low_salaries;

CREATE TABLE low_salaries
AS
SELECT employee_id, department_id, salary
FROM employees
WHERE 1 = 2; --como o where nunca ser� verdadeiro a tabela ser� criada vazia, nunhuma linha satisfar� essa cl�usula
--consultando a tabela rec�m criada:
SELECT *
FROM low_salaries;

--apagando e criando a tabela high_salaries inicialmente vazia:
DROP TABLE high_salaries;

CREATE TABLE high_salaries
AS
SELECT employee_id, department_id, salary
FROM employees
WHERE 1 = 2;
--consultando a tabela rec�m criada:
SELECT *
FROM high_salaries;

--apagando e criando a tabela average_salaries inicialmente vazia:
DROP TABLE average_salaries;

CREATE TABLE average_salaries
AS
SELECT employee_id, department_id, salary
FROM employees
WHERE 1 = 2;
--consultando a tabela rec�m criada:
SELECT *
FROM average_salaries;

--utilizando o comando insert first conditional:
INSERT FIRST
WHEN salary < 5000 
THEN INTO low_salaries
     VALUES (employee_id, department_id, salary)
WHEN salary BETWEEN 5000 AND 10000
THEN INTO average_salaries
     VALUES (employee_id, department_id, salary)
ELSE INTO high_salaries
     VALUES (employee_id, department_id, salary) 
SELECT *
FROM employees;

COMMIT; --comando dml smp efetivar a transa��o

--consultando as tabelas de destino:
SELECT *
FROM low_salaries;

SELECT *
FROM average_salaries;

SELECT *
FROM high_salaries;