--agendando atualiza��es (refresh) peri�dicas de materialized views:
--� poss�vel definir um tempo fixo de refresh para as mv
--removendo e recriando materialized view log:
DROP MATERIALIZED VIEW LOG ON employees;
CREATE MATERIALIZED VIEW LOG ON employees;

--removendo e recriando uma materialized view mv_sales_managers n�o populada imediatamente:
--e que realiza as atualiza��es(refreshes) periodicamente, a cada 1 dia:
DROP MATERIALIZED VIEW mv_sales_manager;

CREATE MATERIALIZED VIEW mv_sales_manager
BUILD DEFERRED --n�o ser� populada imediatamente ap�s a cria��o, foi adiada
REFRESH FORCE
NEXT sysdate + 1 --atualiza��o daqui 24h(um dia)
AS SELECT *
   FROM   employees
   WHERE job_id = 'SA_MAN'
   ORDER BY department_id;

--consultando a materialized view:
SELECT *
FROM mv_sales_manager;