--complete refresh:
--limpa todo o conteúdo da tabela e refaz o select para preenchê-la novamente
--apagando e recriando a materialized view(com complete refresh):
DROP MATERIALIZED VIEW mv_sales_manager;

CREATE MATERIALIZED VIEW mv_sales_manager
BUILD IMMEDIATE 
REFRESH COMPLETE 
ON COMMIT 
AS SELECT *
   FROM employees
   WHERE job_id = 'SA_MAN'; 
--consultando a materialized view recém criada:
SELECT *
FROM mv_sales_manager;

--executando um comando dml sobre a tabela base da complete refreshed materialized view anterior:
INSERT INTO employees
VALUES (501, 'Robert', 'Jonhson', 'RJONHSON', '22222222', sysdate, 'SA_MAN',15000,null,102,60);

COMMIT; --efetivando a transação e automaticamente atualizando a mv

--consultando a materialized view recém criada após o comando dml:
SELECT *
FROM mv_sales_manager;
--mais um novo comando dml:
DELETE FROM employees
WHERE employee_id=501;

COMMIT;
--nova consulta para confirmação da atualização on commit:
SELECT *
FROM mv_sales_manager;

--apagando e recriando a materialized view(com complete refresh) complexa(com subconsulta - não pode ser fast, nem on commit):
DROP MATERIALIZED VIEW mv_department_max_salaries;

CREATE MATERIALIZED VIEW mv_department_max_salaries
BUILD IMMEDIATE
REFRESH COMPLETE 
ENABLE QUERY REWRITE
AS SELECT d.department_name, e.* 
   FROM employees e JOIN departments d ON (e.department_id = d.department_id)
   WHERE (e.department_id, salary) IN (SELECT department_id, MAX(salary) salary
                                       FROM employees
                                       GROUP BY department_id)
   ORDER BY e.department_id, salary;

--consultando a materialized view recém criada:
SELECT *
FROM mv_department_max_salaries;