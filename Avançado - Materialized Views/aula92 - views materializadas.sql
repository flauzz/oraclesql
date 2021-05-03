--views materializadas:
--similar �s views, mas com a diferen�a que o resultado do select fica armazenado em uma tabela(com o mesmo nome da view)
--esse tipo de view faz uma atualiza��o dos dados da tabela com uma freq�ncia especificada ou mediante requisi��o
--a view materializada diminue o custo da consulta em rela��o �s views normais e aumenta a performance
--escolha entre melhor performance e dados em suas vers�es mais atualizadas
--o que � cada cl�usula, op��es na cria��o de uma materalized view:
--build immediate: popula a view imediatamente pelo select
--build deferred: popula a view na primeira atualiza��o(refresh), n�o na cria��o (atrav�s de procedures ou agendamento)
--refresh fast: atualiza somente com a mudan�a dos dados existentes, sem truncar
--refresh complete: trunca(apaga os dados e repopula) e atualiza, processo mais demorado, custoso 
--refresh force: 
--on commit: atualiza��o(refresh) ser� executada no commit de qlqr tabela associada/dependente
--on demand: atualiza��o(refresh) ser� executada manualmente(procedure) ou por agendamento(scheduled)
--enable query rewrite: permite o oracle a otimizar o processo e melhorar a performance com o query rewrite
--disable query rewrite: n�o permite o oracle a otimizar o processo e melhorar a performance com o query rewrite
--on prebuilt table: permite a cria��o de uma view em uma tabela existente
--privil�gios necess�rios: create materialized view to
--conectado como user sys/dba:
--concedendo privel�gio necess�rio para cria��o de uma materialized view ao user:
GRANT CREATE MATERIALIZED VIEW TO hr;

--reconectado como user hr:
--removendo e recriando uma materialized view: 
DROP MATERIALIZED VIEW mv_department_max_salaries;

CREATE MATERIALIZED VIEW mv_department_max_salaries
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
ENABLE QUERY REWRITE
AS SELECT department_id, MAX(salary)
   FROM employees
   GROUP BY department_id
   ORDER BY department_id;
--na aba lateral ou em users_tables dar� pra ver a tabela criada com o mesmo nome da materialized view       
--consultando a materialized view rec�m criada:
SELECT *
FROM mv_department_max_salaries;