--views do dicionário de dados oracle
--são coleções de views que contém informações sobre o banco de dados
--são criadas e mantidas pelo próprio oracle server
--quando o dba cria um banco de dados uma das fases é a criação do dicionário de dados
--não dá para usar o banco de dados sem o dicionário
--são read-only - somente para consulta
--possui informações sobre: -objetos do banco de dados - tabelas, views, sequences, indexes, procedures, funções, pakages...
-- -usuários do banco de dados, -constraints, -privilégios, -tablespaces, -datafiles, -tempfiles
--quais são as views existentes no dicionário de dados:
SELECT *
FROM dictionary --pode-se usar o synonym público dict
ORDER BY table_name; --table_name na vdd é o nome das views

SELECT *
FROM dict
WHERE table_name LIKE '%TABLES%' --verificar se há uma view para mostrar as tabelas do usuário
ORDER BY table_name;

--consultando algumas views existentes no dicionário de dados:
--as visões com prefixo user terão informações do usuário conectado
--visualizar informações sobre os objetos do usuário vigente(conectado):
SELECT *
FROM user_objects;

--visualizar informações sobre as tabelas do usuário vigente(conectado):
SELECT *
FROM user_tables;

--visualizar informações sobre as sequences do usuário vigente(conectado):
SELECT *
FROM user_sequences;

--visualizar informações sobre as views do usuário vigente(conectado):
SELECT *
FROM user_views;