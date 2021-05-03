--views do dicion�rio de dados oracle
--s�o cole��es de views que cont�m informa��es sobre o banco de dados
--s�o criadas e mantidas pelo pr�prio oracle server
--quando o dba cria um banco de dados uma das fases � a cria��o do dicion�rio de dados
--n�o d� para usar o banco de dados sem o dicion�rio
--s�o read-only - somente para consulta
--possui informa��es sobre: -objetos do banco de dados - tabelas, views, sequences, indexes, procedures, fun��es, pakages...
-- -usu�rios do banco de dados, -constraints, -privil�gios, -tablespaces, -datafiles, -tempfiles
--quais s�o as views existentes no dicion�rio de dados:
SELECT *
FROM dictionary --pode-se usar o synonym p�blico dict
ORDER BY table_name; --table_name na vdd � o nome das views

SELECT *
FROM dict
WHERE table_name LIKE '%TABLES%' --verificar se h� uma view para mostrar as tabelas do usu�rio
ORDER BY table_name;

--consultando algumas views existentes no dicion�rio de dados:
--as vis�es com prefixo user ter�o informa��es do usu�rio conectado
--visualizar informa��es sobre os objetos do usu�rio vigente(conectado):
SELECT *
FROM user_objects;

--visualizar informa��es sobre as tabelas do usu�rio vigente(conectado):
SELECT *
FROM user_tables;

--visualizar informa��es sobre as sequences do usu�rio vigente(conectado):
SELECT *
FROM user_sequences;

--visualizar informa��es sobre as views do usu�rio vigente(conectado):
SELECT *
FROM user_views;