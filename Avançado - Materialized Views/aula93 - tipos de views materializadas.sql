--tipos de materialized views:
--mv com funções de agregação - com funções de grupo(sum, avg, max, min...)
--mv contendo somente joins - joins entre tabelas na cláusula from
--nested materialized view
--conectado como user sys/dba, conceder o privilégio para hr:
GRANT CREATE MATERIALIZED VIEW to hr; 

--conectado como user hr:
--apagando e recriando materialized view log (para registrar as alterações na tabela employees)
DROP MATERIALIZED VIEW LOG ON employees;

CREATE MATERIALIZED VIEW LOG ON employees;

--apagando e recriando a materialized view com funções de agregação:
DROP MATERIALIZED VIEW mv_department_salaries;

CREATE MATERIALIZED VIEW mv_department_salaries
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS SELECT e.department_id, SUM(e.salary) sum_salary, ROUND(AVG(NVL(e.salary,0)),2) avg_salary
   FROM employees e
   GROUP BY e.department_id;
--consultando a tabela recém criada por meio de uma materialized view:
SELECT *
FROM mv_department_salaries;

--apagando e recriando a materialized view contendo somente jois:
DROP MATERIALIZED VIEW mv_employes_jobs_departments;

CREATE MATERIALIZED VIEW mv_employes_jobs_departments
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS SELECT e.employee_id, e.first_name, e.last_name, e.salary, e.commission_pct, e.job_id, j.job_title, e.department_id, d.department_name
FROM employees e
     JOIN jobs j ON (e.job_id = j.job_id)
     JOIN departments d ON (e.department_id = d.department_id);
--consultando a tabela recém criada por meio de uma materialized view:
SELECT *
FROM mv_employes_jobs_departments;

--apagando e recriando uma nested materialized view(aninhadas - mv referencia outra mv):
DROP MATERIALIZED VIEW mv_department_cust_hour;

CREATE MATERIALIZED VIEW mv_department_cust_hour
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS SELECT mv.department_name, SUM(mv.salary) sum_salary, ROUND(SUM(mv.salary)/160,2) cust_hour
   FROM mv_employes_jobs_departments mv
   GROUP BY mv.department_name;
--consultando a tabela recém criada por meio de uma materialized view:
SELECT *
FROM mv_department_cust_hour;