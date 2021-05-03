--flashback table:
--permite fazer a recuperação de uma ou mais tabelas para uma determinada posição no tempo do passado sem a necessidade de restaurar um bk do bd
--todos os objetos associados à tabela são restaurados juntos(indexes, constraints, triggers)
--pode ser que seja necessário voltar as outras tabelas associadas, para manter a consistência dos indexes e das constraints
--ou seja, pode haver uma perda grande de dados
--por isso, menos utilizado, utilizar em último caso, apenas qndo não tiver outra opção
--se for utilizado um dos comandos a seguir, não será possível voltar no passado com o flashback table:
--alter table... drop column, alter table... drop partition, create cluster, truncate table, alter table... move
--para executá-lo é necessário ter o privilégio flashback table ou flashback any table(para qlqr schema)
--antes de executá-lo é necessário utilizar o seguinte comando (habilitar a movimentação de linhas da tabela):
--como dba: grant flashback on schema.nome_tabela to usuário ou GRANT FLASHBACK ANY TABLE TO usuário
--como dba ou owner: alter table schema.nome_tabela enable row movement
--criando uma tabela para exemplificar o flashback table
CREATE TABLE employees_copia2
AS
SELECT *
FROM employees; --como ddl, commit automático

--conectado como sys(dba), passar o privilégio flashback para o user (hr):
GRANT FLASHBACK ON hr.employees_copia2 TO hr;

--conectado como owner (hr) ou como sys(dba), habilitar a movimentação de linhas da tabela(pode ocorrer a mudança de rowid das linhas):
ALTER TABLE hr.employees_copia2 ENABLE ROW MOVEMENT;

--como owner(hr), verificar se a tabela foi criada de maneira correta:
SELECT *
FROM hr.employees_copia2;
--deletando a tabela com delete:
DELETE FROM hr.employees_copia2;
--comitando para não ter mais volta:
COMMIT;

--consultando a tabela recém apagada para verificar a não-existência:
SELECT *
FROM hr.employees_copia2 ;

--resaurando a tabela para determinada posição no tempo (5 minutos atrás):
FLASHBACK TABLE hr.employees_copia2 TO TIMESTAMP systimestamp - interval '5' minute; --há 5min a tabela ainda existia

--consultando a tabela após o flashback:
SELECT *
FROM hr.employees_copia2;
--sempre verificar a consistência de constraints e indexes para garantir o bom funcionamento deles
--para garantir a consistência dê flashback em todas as tabelas associadas q eu foi excluída
--só adicionar uma vírgula após os nomes das tabelas e ir adicionando mais uma