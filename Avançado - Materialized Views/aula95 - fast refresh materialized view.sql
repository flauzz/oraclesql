--fast refresh:
--tipos de refresh(atualizações) nas materialized views:
--uma mv pode ficar desatualizada em relacão à tabela referenciada, para mantê-la atualizada é preciso refresh
--tipos: 1.fast refresh, 2.complete refresh e 3.force refresh
--1 - necessário definir um log para registrar as mudanças. atualização somente com as mudanças, sem truncamento. mais rápido
--2 - não utiliza log. vai reexecutar o select, truncar e atualizar
--3 - oracle tenta primeiro o fast refresh, caso não consiga, fará complete refresh
		  
--removendo uma fast refresh materialized view e uma materialized view log:
DROP MATERIALIZED VIEW mv_sales_manager;
DROP MATERIALIZED VIEW LOG ON employees;

--criando materialized view log:
CREATE MATERIALIZED VIEW LOG ON employees; --para conter as mudanças realizadas na table employees

--criando uma fast refreshed materialized view:
CREATE MATERIALIZED VIEW mv_sales_manager
BUILD IMMEDIATE 
REFRESH FAST ON COMMIT 
AS SELECT *
   FROM employees
   WHERE job_id = 'SA_MAN'; 

--consultando a fast refreshed materialized view recém criada:
SELECT *
FROM mv_sales_manager;

--executando dml sobre a tabela base da fast refreshed materialized view anterior:
INSERT INTO employees 
VALUES (500, 'Alex', 'Brown', 'ABROWN', '11111111', sysdate, 'SA_MAN',10000,null,102,60); --adicionando uma linha

COMMIT; --efetivando a transação. automaticamente foi feito o fast refresh da mv recém criada

--consultando novamente a fast refreshed materialized view após dml:
SELECT *
FROM mv_sales_manager;

--executando outro dml sobre a tabela base da fast refreshed materialized view anterior:
DELETE FROM employees
WHERE employee_id=500;

COMMIT;

--consultando novamente a fast refreshed materialized view após dml:
SELECT *
FROM mv_sales_manager;
		  
--provocando um erro na criação de uma fast refreshed complex materialized view:
--removendo e recriando materialized view log:
DROP MATERIALIZED VIEW LOG ON departments;
CREATE MATERIALIZED VIEW LOG ON departments;

--removendo e recriando uma complex materialized view (complexa pois há uma subconsulta):
DROP MATERIALIZED VIEW mv_department_max_salaries;

CREATE MATERIALIZED VIEW mv_department_max_salaries
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS SELECT d.department_name, e.* --todas as colunas da tabela de alias e
   FROM employees e JOIN departments d ON (e.department_id = d.department_id)
   WHERE (e.department_id, salary) IN 
                                   (SELECT department_id, MAX(salary) salary
                                    FROM employees
                                    GROUP BY department_id)
   ORDER BY e.department_id, salary;
--erro acontece por ser uma materialized view complexa
--realizando o mesmo comando sem a cláusula on commit(removendo-a primeiro e recriando):
CREATE MATERIALIZED VIEW mv_department_max_salaries
BUILD IMMEDIATE
REFRESH FAST 
ENABLE QUERY REWRITE
AS SELECT d.department_name, e.* 
   FROM employees e JOIN departments d ON (e.department_id = d.department_id)
   WHERE (e.department_id, salary) IN 
                                   (SELECT department_id, MAX(salary) salary
                                    FROM employees
                                    GROUP BY department_id)
   ORDER BY e.department_id, salary;
--erro acontece por ser uma materialized view complexa. da maneira fast não pode ser complexa
--realizando o mesmo comando sem a cláusula on commit(removendo-a primeiro e recriando) e alterando o tipo de refresh:
CREATE MATERIALIZED VIEW mv_department_max_salaries
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS SELECT d.department_name, e.* 
   FROM employees e JOIN departments d ON (e.department_id = d.department_id)
   WHERE (e.department_id, salary) IN 
                                   (SELECT department_id, MAX(salary) salary
                                    FROM employees
                                    GROUP BY department_id)
   ORDER BY e.department_id, salary;
   
--consultando a complex materialized view recém criada:
SELECT *
FROM mv_department_max_salaries;