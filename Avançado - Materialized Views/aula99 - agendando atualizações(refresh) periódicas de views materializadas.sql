--agendando atualizações (refresh) periódicas de materialized views:
--é possível definir um tempo fixo de refresh para as mv
--removendo e recriando materialized view log:
DROP MATERIALIZED VIEW LOG ON employees;
CREATE MATERIALIZED VIEW LOG ON employees;

--removendo e recriando uma materialized view mv_sales_managers não populada imediatamente:
--e que realiza as atualizações(refreshes) periodicamente, a cada 1 dia:
DROP MATERIALIZED VIEW mv_sales_manager;

CREATE MATERIALIZED VIEW mv_sales_manager
BUILD DEFERRED --não será populada imediatamente após a criação, foi adiada
REFRESH FORCE
NEXT sysdate + 1 --atualização daqui 24h(um dia)
AS SELECT *
   FROM   employees
   WHERE job_id = 'SA_MAN'
   ORDER BY department_id;

--consultando a materialized view:
SELECT *
FROM mv_sales_manager;