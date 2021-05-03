--comando merge (fus�o):
--compara uma tabela, uma view ou sub-consulta (origem) com uma tabela destino e atualiza ou deleta linhas
--apagando e criando a tabela employees_copy:
DROP TABLE employees_copy;

CREATE TABLE employees_copy
AS
SELECT *
FROM employees
WHERE 1 = 2;
--consultando a tabela rec�m criada:
SELECT *
FROM employees_copy;

-- Comando MERGE

MERGE INTO employees_copy c --nome da table destino com alias (ou n�o)
USING employees e --como origem uma tabela, view ou (sub-consulta) com alias (ou n�o)
ON (c.employee_id = e.employee_id) --condi��o. para cada linha da origem o oracle compara com as linhas destino
WHEN MATCHED THEN --caso haja uma linha correspondente na tabela destino (linha j� existente):
    UPDATE SET --atualize da seguinte forma (update ou delete):
    c.first_name = e.first_name,
    c.last_name = e.last_name,
    c.email = e.email,
    c.phone_number = e.phone_number,
    c.hire_date = e.hire_date,
    c.job_id = e.job_id,
    c.salary = e.salary,
    c.commission_pct = e.commission_pct,
    c.manager_id = e.manager_id,
    c.department_id = e.department_id
    DELETE WHERE department_id IS NULL --caso o departamento seja null ele deleta a linha toda
WHEN NOT MATCHED THEN --caso n�o encontre um valor correspondente, insira os seguintes valores da tabela origem (linha n�o existente):
    INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id,
                 e.salary, e.commission_pct, e.manager_id, e.department_id);
  
COMMIT; --comando dml smp efetivar a transa��o
  
--consultando a tabela de origem employees e:
SELECT count(*)
FROM employees;

--consultando a tabela de destino employees_copy c:
SELECT count(*)
FROM employees_copy;

--atualizando dados da tabela de origem employees e para depois realizar um novo merge:
UPDATE employees
SET salary = 90000
WHERE employee_id = 109;

COMMIT;

--realizando novamente o comando merge para que automaticamente o oracle identifique a diferen�a e fa�a a devida atualiza��o:
MERGE INTO employees_copy c
USING employees e
ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN
    UPDATE SET 
    c.first_name = e.first_name,
    c.last_name = e.last_name,
    c.email = e.email,
    c.phone_number = e.phone_number,
    c.hire_date = e.hire_date,
    c.job_id = e.job_id,
    c.salary = e.salary,
    c.commission_pct = e.commission_pct,
    c.manager_id = e.manager_id,
    c.department_id = e.department_id
    DELETE WHERE department_id IS NULL
WHEN NOT MATCHED THEN
    INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id,
                 e.salary, e.commission_pct, e.manager_id, e.department_id);
  
COMMIT;
  
--consultando a tabelat de origem employees e:
SELECT count(*)
FROM employees;

--consultando a tabela de destino employees_copy c:
SELECT count(*)
FROM employees_copy;
--consultando se o sal�rio realmente foi atualizado na tabela de destino:
SELECT *
FROM employees_copy
WHERE employee_id = 109;