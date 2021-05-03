--views com prefixo V$ - visões dinâmicas de performance
--viwes do dicionário de dados x views $:
--na primeira, banco de dados deve estar aberto, na segunda não, são utilizadas pelo dba
--a segunda acessa conteúdo em memória e arquivos de controle
--a segunda contêm informações sobre a performance, a instância dos banco de dados, estruturas de memória, estruturas físicas(control, data e temp files)
--a primeira os nomes são no plural, a segunda são no singular
--a primeira dados letras maiúsculas, a segunda minúsculas
--consultando views dinâmicas de performance (msm com o banco fechado - uteis em um recover de bd):
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
FROM v$controlfile; --arquivo de controle do banco, sem ele o banco de dados é perdido

SELECT *
FROM v$parameter; --definidos na criação do banco de dados
--consultando um parâmetro específico:
SELECT *
FROM v$parameter
WHERE name = 'db_block_size';