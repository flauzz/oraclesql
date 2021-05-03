--force refresh:
--force é a opção default(assim como on demand). oracle tenta fast refresh, caso não dê, complete refresh
--removendo e recriando a materialized view log para employees:
DROP MATERIALIZED VIEW LOG ON employees;
CREATE MATERIALIZED VIEW LOG ON employees;

--removendo e criando uma force refresh materialized view:
DROP MATERIALIZED VIEW mv_it_programmers;

CREATE MATERIALIZED VIEW mv_it_programmers
BUILD IMMEDIATE 
REFRESH FORCE 
ON COMMIT
ENABLE QUERY REWRITE 
AS SELECT *
   FROM employees
   WHERE job_id = 'IT_PROG'
   ORDER BY department_id;
--consultando a mv recém criada:
SELECT *
FROM mv_it_programmers;

--executando comando dml sobre a tabela base da mv recém criada:
INSERT INTO employees
VALUES (503, 'Greg', 'Lake', 'glake', '33333333', sysdate, 'IT_PROG',20000,null,103,60);

COMMIT; --efetivando a transação e atualizando a mv automaticamente
--consultando novamente a mv recém criada, após o comando dml:
SELECT *
FROM mv_it_programmers;
--mais um comando dml:
DELETE FROM employees
WHERE  employee_id=503;

COMMIT;
--consultando novamente a mv recém criada, após outro comando dml:
SELECT *
FROM mv_it_programmers;