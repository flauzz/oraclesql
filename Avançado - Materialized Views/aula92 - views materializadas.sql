--views materializadas:
--similar às views, mas com a diferença que o resultado do select fica armazenado em uma tabela(com o mesmo nome da view)
--esse tipo de view faz uma atualização dos dados da tabela com uma freqência especificada ou mediante requisição
--a view materializada diminue o custo da consulta em relação às views normais e aumenta a performance
--escolha entre melhor performance e dados em suas versões mais atualizadas
--o que é cada cláusula, opções na criação de uma materalized view:
--build immediate: popula a view imediatamente pelo select
--build deferred: popula a view na primeira atualização(refresh), não na criação (através de procedures ou agendamento)
--refresh fast: atualiza somente com a mudança dos dados existentes, sem truncar
--refresh complete: trunca(apaga os dados e repopula) e atualiza, processo mais demorado, custoso 
--refresh force: 
--on commit: atualização(refresh) será executada no commit de qlqr tabela associada/dependente
--on demand: atualização(refresh) será executada manualmente(procedure) ou por agendamento(scheduled)
--enable query rewrite: permite o oracle a otimizar o processo e melhorar a performance com o query rewrite
--disable query rewrite: não permite o oracle a otimizar o processo e melhorar a performance com o query rewrite
--on prebuilt table: permite a criação de uma view em uma tabela existente
--privilégios necessários: create materialized view to
--conectado como user sys/dba:
--concedendo privelégio necessário para criação de uma materialized view ao user:
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
--na aba lateral ou em users_tables dará pra ver a tabela criada com o mesmo nome da materialized view       
--consultando a materialized view recém criada:
SELECT *
FROM mv_department_max_salaries;