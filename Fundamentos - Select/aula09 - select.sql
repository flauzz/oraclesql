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

-- para select pode arrastar uma tabela da aba conexões
SELECT job_id, job_title
FROM jobs;

-- operações e precedências com o select
SELECT first_name, last_name, salary, salary*1.15
FROM employees;

SELECT first_name, last_name, salary, salary+100*1.15
FROM employees;

SELECT first_name, last_name, salary, (salary+100)*1.15
FROM employees;

-- entendendo o null
SELECT first_name, last_name, job_id, salary, commission_pct
FROM employees;

-- expressões matemáticas com null retornam null
-- utilizando o where
SELECT first_name, last_name, job_id, salary, commission_pct, 200000*commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- definindo alias de coluna. o as é opcional. não altera a tabela, apenas a visualização
SELECT first_name AS nome, last_name sobrenome, salary salário
FROM employees;

-- definindo alias com letras maiúsculas e minúsculas, além de mais de uma palavra e caracteres especiais
SELECT first_name "Nome", last_name "Sobrenome", salary "Salário (R$)", commission_pct "Percentual de Comissão"
FROM employees;

-- oparador de concatenação: entre colunas e strings (aspas simples). com o alias
-- funcionário é o cabeçalho para toda a expressão anterior
SELECT first_name || ' ' || last_name || ', data de admissão: ' || hire_date "Funcionário"
FROM employees;

SELECT first_name || ' ' || last_name || ', salário: ' || salary "Funcionário"
FROM employees;

-- operador alternativo para aspas simples
SELECT department_name || q'[ Department's Manager ID: ]' || manager_id "Departamento e Gerente"
FROM departments;

-- eliminando linhas duplicadas
SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;