--insert all condition
--para linha ser inserida é preciso satisfazer a cláusula when (condição e then)
--deletando as linhas já add para add nesta aula:
DELETE FROM employees
WHERE employee_id >= 207;

COMMIT; --efetivar a transação

--apagando a tabela salary_history para ser criada novamente:
DROP TABLE salary_history;

CREATE TABLE salary_history
AS
SELECT employee_id, EXTRACT(year FROM hire_date) year, EXTRACT(month FROM hire_date) month, salary, commission_pct
FROM employees
WHERE hire_date <= sysdate - 365; --empregados contratados nos últimos anos
--consultando a tabela recém criada:
SELECT *
FROM salary_history;

--apagando a tabela employees_history para ser criada novamente:
DROP TABLE employees_history;

CREATE TABLE employees_history
AS
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE hire_date <= sysdate - 365; --empregados contratados nos últimos anos
--consultando tabela recém criada:
SELECT *
FROM employees_history;

--apagando a tabela it_programmers para ser criada novamente:
DROP TABLE it_programmers;

CREATE TABLE it_programmers
AS
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE job_id = 'IT_PROG' AND hire_date <= sysdate - 365;
--consultando a tabela recém criada:
SELECT *
FROM it_programmers;

--apagando a tabela living_in_us para ser criada novamente:
DROP TABLE living_in_us;

CREATE TABLE living_in_us
AS
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE (hire_date <= sysdate - 365) AND department_id IN (SELECT department_id  
                                                         FROM   departments 
                                                         WHERE  location_id IN (SELECT location_id 
                                                                                FROM locations
                                                                                WHERE country_id = 'US'));
--empregados contratados no último ano que o departamento está localizado em algum lugar dos eua
--consultando a tabela recém criada:
SELECT *
FROM living_in_us;

--inserindo novos empregados para satisfazer as condições das tabelas recém criadas:
INSERT INTO EMPLOYEES
VALUES (207, 'Carl', 'Palmer', 'CPALMER', '515.123.8182', sysdate, 'IT_PROG', 15000,null,103,60);
INSERT INTO EMPLOYEES
VALUES (208, 'Keith', 'Richards', 'KRICHARDS', '515.123.8183', sysdate, 'IT_PROG', 20000,null,103,60);

COMMIT; --comando dml, necessário comitar transação

--comando insert all conditional:
INSERT ALL
WHEN (hire_date > sysdate - 365)
THEN INTO employees_history
     VALUES (employee_id, first_name, last_name, hire_date)
     INTO salary_history
     VALUES (employee_id, EXTRACT(year FROM hire_date), EXTRACT(month FROM hire_date), salary, commission_pct)
WHEN (hire_date > sysdate - 365) AND (job_id = 'IT_PROG')
THEN INTO it_programmers
     VALUES (employee_id, first_name, last_name, hire_date)
WHEN (hire_date > sysdate - 365) AND department_id IN (SELECT department_id
                                                       FROM departments 
                                                       WHERE location_id IN (SELECT location_id 
                                                                             FROM locations
                                                                             WHERE country_id = 'US'))
THEN INTO living_in_us
     VALUES (employee_id, first_name, last_name, hire_date)
SELECT *
FROM employees
WHERE hire_date > sysdate-365;
--para cada linha retornada pelo select o oracle vai avaliar todas as condições das cláusulas when e quando verdadeira ele insere a linha pelo then into

--consultando as tabelas-destino do insert all conditional anterior:
SELECT *
FROM employees_history
WHERE hire_date > sysdate-365;

SELECT *
FROM salary_history
WHERE year = 2020;

SELECT *
FROM it_programmers
WHERE hire_date > sysdate-365;

SELECT *
FROM living_in_us
WHERE hire_date > sysdate-365;