--insert all incondicional/insert incondicional:
--cada linha de subconsulta é inserida na tabela de destino
--deletando as linhas já add para add nesta aula:
DELETE FROM employees
WHERE employee_id >= 207;

COMMIT;

--criando a tabela salary_history a partir de um resultado de um select:
CREATE TABLE salary_history
AS
SELECT employee_id, EXTRACT(year FROM hire_date) year, EXTRACT(month FROM hire_date) month, salary, commission_pct
FROM employees
WHERE hire_date <= sysdate - 365; --extract vai apenas mostrar o ano da data e o mês no segundo caso
--where para mostrar os empregados que foram admitidos nos últimos 365 dias <que 365 mais próximo da referência
--consultando a tabela recém criada:
SELECT *
FROM salary_history;

--criando a tabela employees_history a partir de um resultado de um select:
CREATE TABLE employees_history
AS
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  hire_date <= sysdate - 365;
--consultando a tabela recém criada:
SELECT *
FROM   employees_history;

--utilizando o comando insert all incondicional:
--como há um select/where comum entre as duas tabelas, pode ser dado o insert de uma vez só
INSERT ALL
INTO employees_history VALUES (employee_id, first_name, last_name, hire_date) --inserir essas colunas/dados que virão do select a seguir
INTO salary_history    VALUES (employee_id, EXTRACT(year FROM hire_date), EXTRACT(month FROM hire_date), salary, commission_pct)
--inserir essas colunas/dados que virão do mesmo select a seguir
SELECT *
FROM   employees
WHERE  hire_date > sysdate-365;

--consultando as tabelas de destino(nada foi inserido, pois nenhum empregado foi contratado no último ano):
SELECT *
FROM employees_history
WHERE hire_date > sysdate-365;

SELECT *
FROM salary_history
WHERE year = 2020;

--inserindo um novo empregado:
INSERT INTO EMPLOYEES
VALUES (207, 'Carl', 'Palmer', 'CPALMER', '515.123.8182', sysdate, 'IT_PROG', 15000, null, 103, 60);

COMMIT;

--fazendo novamente o insert all inconditional com o novo empregado inserido(contratado no último ano):
INSERT ALL
INTO employees_history VALUES (employee_id, first_name, last_name, hire_date)
INTO salary_history VALUES (employee_id, EXTRACT(year FROM hire_date), EXTRACT(month FROM hire_date), salary, commission_pct)
SELECT *
FROM employees
WHERE hire_date > sysdate-365;

COMMIT;

--consultando novamente as tabelas de destino:
SELECT *
FROM employees_history
WHERE hire_date > sysdate-365;

SELECT *
FROM salary_history
WHERE year = 2020;