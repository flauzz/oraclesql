--views com prefixo V$ - vis�es din�micas de performance
--viwes do dicion�rio de dados x views $:
--na primeira, banco de dados deve estar aberto, na segunda n�o, s�o utilizadas pelo dba
--a segunda acessa conte�do em mem�ria e arquivos de controle
--a segunda cont�m informa��es sobre a performance, a inst�ncia dos banco de dados, estruturas de mem�ria, estruturas f�sicas(control, data e temp files)
--a primeira os nomes s�o no plural, a segunda s�o no singular
--a primeira dados letras mai�sculas, a segunda min�sculas
--consultando views din�micas de performance (msm com o banco fechado - uteis em um recover de bd):
SELECT *
FROM v$tablespace;

SELECT *
FROM v$datafile;
--
SELECT file#, name, bytes/1024/1024 MEGABYTE, blocks, status
FROM v$datafile;

SELECT file#, name, bytes/1024/1024 MEGABYTE, blocks, status
FROM v$tempfile;

SELECT *
FROM v$controlfile; --arquivo de controle do banco, sem ele o banco de dados � perdido

SELECT *
FROM v$parameter; --definidos na cria��o do banco de dados
--consultando um par�metro espec�fico:
SELECT *
FROM v$parameter
WHERE name = 'db_block_size';