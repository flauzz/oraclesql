--flashback table:
--permite fazer a recupera��o de uma ou mais tabelas para uma determinada posi��o no tempo do passado sem a necessidade de restaurar um bk do bd
--todos os objetos associados � tabela s�o restaurados juntos(indexes, constraints, triggers)
--pode ser que seja necess�rio voltar as outras tabelas associadas, para manter a consist�ncia dos indexes e das constraints
--ou seja, pode haver uma perda grande de dados
--por isso, menos utilizado, utilizar em �ltimo caso, apenas qndo n�o tiver outra op��o
--se for utilizado um dos comandos a seguir, n�o ser� poss�vel voltar no passado com o flashback table:
--alter table... drop column, alter table... drop partition, create cluster, truncate table, alter table... move
--para execut�-lo � necess�rio ter o privil�gio flashback table ou flashback any table(para qlqr schema)
--antes de execut�-lo � necess�rio utilizar o seguinte comando (habilitar a movimenta��o de linhas da tabela):
--como dba: grant flashback on schema.nome_tabela to usu�rio ou GRANT FLASHBACK ANY TABLE TO usu�rio
--como dba ou owner: alter table schema.nome_tabela enable row movement
--criando uma tabela para exemplificar o flashback table
CREATE TABLE employees_copia2
AS
SELECT *
FROM employees; --como ddl, commit autom�tico

--conectado como sys(dba), passar o privil�gio flashback para o user (hr):
GRANT FLASHBACK ON hr.employees_copia2 TO hr;

--conectado como owner (hr) ou como sys(dba), habilitar a movimenta��o de linhas da tabela(pode ocorrer a mudan�a de rowid das linhas):
ALTER TABLE hr.employees_copia2 ENABLE ROW MOVEMENT;

--como owner(hr), verificar se a tabela foi criada de maneira correta:
SELECT *
FROM hr.employees_copia2;
--deletando a tabela com delete:
DELETE FROM hr.employees_copia2;
--comitando para n�o ter mais volta:
COMMIT;

--consultando a tabela rec�m apagada para verificar a n�o-exist�ncia:
SELECT *
FROM hr.employees_copia2 ;

--resaurando a tabela para determinada posi��o no tempo (5 minutos atr�s):
FLASHBACK TABLE hr.employees_copia2 TO TIMESTAMP systimestamp - interval '5' minute; --h� 5min a tabela ainda existia

--consultando a tabela ap�s o flashback:
SELECT *
FROM hr.employees_copia2;
--sempre verificar a consist�ncia de constraints e indexes para garantir o bom funcionamento deles
--para garantir a consist�ncia d� flashback em todas as tabelas associadas q eu foi exclu�da
--s� adicionar uma v�rgula ap�s os nomes das tabelas e ir adicionando mais uma