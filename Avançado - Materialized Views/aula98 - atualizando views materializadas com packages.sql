--atualizando materialzed views utilizando packages
--possuindo o privilégio específico é possível atualizar todas as mv so sistema utilizando a procedure: dbms_mview.refresh_all_mviews
--conectado como user sys/dba:

--concedendo privilégios necessários para executar componentes das packages dbms_mview(synonym da sequinte) e dbms_snapshot:
GRANT EXECUTE ON DBMS_MVIEW TO hr;
GRANT EXECUTE ON DBMS_SNAPSHOT TO hr;

--conectado como user hr:
--removendo e recriando a materialized view log de employees:
DROP MATERIALIZED VIEW LOG ON employees;
CREATE MATERIALIZED VIEW LOG ON employees;

--removendo e recriando a materialized view:
DROP MATERIALIZED VIEW mv_it_programmers;

CREATE MATERIALIZED VIEW mv_it_programmers
BUILD IMMEDIATE
REFRESH FORCE
ENABLE QUERY REWRITE
AS SELECT *
   FROM employees
   WHERE job_id = 'IT_PROG'
   ORDER BY department_id;
--consultando a materialized view recém criada:
SELECT *
FROM mv_it_programmers;

--executando comandos dml sobre a tabela base da mv anterior:
DELETE FROM employees
WHERE employee_id IN (504, 505, 506);

COMMIT;

INSERT INTO employees
VALUES (504, 'Richard', 'Wright', 'RWRIGHT', '44444444', sysdate, 'IT_PROG',25000,null,103,60);

COMMIT;  
--consultando a materialized view e confirmando q está desatualizada:
SELECT *
FROM mv_it_programmers;
--atualizando materialized view recém criada manualmente utilizando a package dbms_mview e procedure refresh:
EXECUTE DBMS_MVIEW.REFRESH('mv_it_programmers', 'F') --comando do sql*plus. parâmetros: nome da mv e o tipo de refresh(f,c ou nada)
--consultando a materialized view recém atualizada:
SELECT *
FROM mv_it_programmers;

--executando mais um comando dml sobre a tabela base da materialized view:
INSERT INTO employees
VALUES (505, 'Billie', 'Holiday', 'BHOLIDAY', '55555555', sysdate, 'IT_PROG', 30000, null, 103, 60);

COMMIT;  

--consultando a tabela employees:
SELECT *
FROM employees
WHERE employee_id IN (504,505);
--consultando a materialized view qconfirmando que está desatualizada:
SELECT *
FROM mv_it_programmers;

--atualizando materialized view recém criada manualmente utilizando a package dbms_snapshot.refresh:
EXECUTE DBMS_SNAPSHOT.REFRESH('mv_it_programmers', 'C')
--consultando a materialized view:
SELECT *
FROM mv_it_programmers;

--executando mais comando dml sobre a tabela base da materialized view:
INSERT INTO employees
VALUES (506, 'Eddie', 'Vedder', 'EVEDDER', '77777777', sysdate, 'IT_PROG',35000,null,103,60);

COMMIT; 
--consultando a tabela employees:
SELECT *
FROM employees
WHERE employee_id IN (504,505,506);
--consultando a materialized view desatualizada:
SELECT *
FROM mv_it_programmers;

--conectado como user sys/dba:
--concedendo privilégio específico ao user:
GRANT ALTER ANY MATERIALIZED VIEW TO hr;

---atualizando todas as mvs executando a package dbms_mview e a procedure refresh_all_mviews:
DECLARE
  vfailures  NUMBER;
BEGIN        
  DBMS_MVIEW.REFRESH_ALL_MVIEWS(vfailures, 'C','', TRUE, FALSE, FALSE); --parâmetros: 1-id da falha caso ocorra, 2-tipo de refresh
END; --comando plsql
--consultando a materialized view:
SELECT *
FROM mv_it_programmers;