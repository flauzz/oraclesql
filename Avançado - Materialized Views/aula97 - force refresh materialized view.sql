--force refresh:
--force � a op��o default(assim como on demand). oracle tenta fast refresh, caso n�o d�, complete refresh
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
--consultando a mv rec�m criada:
SELECT *
FROM mv_it_programmers;

--executando comando dml sobre a tabela base da mv rec�m criada:
INSERT INTO employees
VALUES (503, 'Greg', 'Lake', 'glake', '33333333', sysdate, 'IT_PROG',20000,null,103,60);

COMMIT; --efetivando a transa��o e atualizando a mv automaticamente
--consultando novamente a mv rec�m criada, ap�s o comando dml:
SELECT *
FROM mv_it_programmers;
--mais um comando dml:
DELETE FROM employees
WHERE  employee_id=503;

COMMIT;
--consultando novamente a mv rec�m criada, ap�s outro comando dml:
SELECT *
FROM mv_it_programmers;