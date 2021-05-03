-- usando o describe
DESCRIBE employees;

DESC departments;

DESCRIBE jobs;

DESC countries;

-- usando o select mais simples
SELECT * 
FROM employees;

SELECT * 
FROM jobs;

SELECT *
FROM departments;
-- o * significa exibir todas as colunas

-- select mais sofisticado, indicando quais colunas devem ser exibidas
SELECT department_id, location_id 
FROM departments;

SELECT employee_id, first_name, last_name, salary 
FROM employees;

SELECT department_id, department_name, manager_id 
FROM departments;

-- para select pode arrastar uma tabela da aba conex�es
SELECT job_id, job_title
FROM jobs;

-- opera��es e preced�ncias com o select
SELECT first_name, last_name, salary, salary*1.15
FROM employees;

SELECT first_name, last_name, salary, salary+100*1.15
FROM employees;

SELECT first_name, last_name, salary, (salary+100)*1.15
FROM employees;

-- entendendo o null
SELECT first_name, last_name, job_id, salary, commission_pct
FROM employees;

-- express�es matem�ticas com null retornam null
-- utilizando o where
SELECT first_name, last_name, job_id, salary, commission_pct, 200000*commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- definindo alias de coluna. o as � opcional. n�o altera a tabela, apenas a visualiza��o
SELECT first_name AS nome, last_name sobrenome, salary sal�rio
FROM employees;

-- definindo alias com letras mai�sculas e min�sculas, al�m de mais de uma palavra e caracteres especiais
SELECT first_name "Nome", last_name "Sobrenome", salary "Sal�rio (R$)", commission_pct "Percentual de Comiss�o"
FROM employees;

-- oparador de concatena��o: entre colunas e strings (aspas simples). com o alias
-- funcion�rio � o cabe�alho para toda a express�o anterior
SELECT first_name || ' ' || last_name || ', data de admiss�o: ' || hire_date "Funcion�rio"
FROM employees;

SELECT first_name || ' ' || last_name || ', sal�rio: ' || salary "Funcion�rio"
FROM employees;

-- operador alternativo para aspas simples
SELECT department_name || q'[ Department's Manager ID: ]' || manager_id "Departamento e Gerente"
FROM departments;

-- eliminando linhas duplicadas
SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;