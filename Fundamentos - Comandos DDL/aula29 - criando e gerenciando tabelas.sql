-- todos os objetos do schema hr:
SELECT *
FROM user_objects
ORDER BY object_type;

-- para criar tabelas precisa de privilégio para isso
-- para cada coluna a ser criada é preciso informar o nome da coluna, o tipo de dado e tamanho máximo da coluna
-- para criar tabela para seu próprio usuário não é necessário especificar
-- o valor default é smp opcional
-- default: quando usado, ao não inserir a coluna no insert é atribuído o dado definido como padrão
-- not null é umas das constraint
-- varchar2 - alfanumérico. tamanho variável, utiliza memória de acordo com o que for inserido. smp especificar o num máximo de bytes
-- char - tamanho não variável, utiliza toda a memória especificada independente do que for inserido. smp especificar o num total de bytes
-- number - só se permite números. primeiro argumento precisão(número total de dígitos) e segundo argumento escala(quantas casas decimais)
-- criando tabela
DROP TABLE projects;

CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL, --11 dígitos ao todo dos quais 2 serão após o ponto (casas decimais)
description     VARCHAR2(400));

DESC projects;

SELECT *
FROM projects;

DROP TABLE  teams;

CREATE TABLE teams
(project_id NUMBER(6) NOT NULL,
employee_id NUMBER(6) NOT NULL);

DESC teams;

SELECT *
FROM teams;

-- tipo rowid
-- rowid é uma pseudo coluna que não aparece num describe
-- é o endereço lógico de uma linha de uma tabela - endereço em base 64
DESC employees;

SELECT employee_id, first_name, rowid, LENGTH(rowid)
FROM employees;
-- método de acesso mais rápido do oracle é já informando o endereço lógico da linha:
SELECT employee_id, first_name, rowid, LENGTH(rowid)
FROM employees
WHERE rowid = 'AAARyrAAEAAAIv+AAE';

--quais são as tabelas que o schema do meu usuário possui?
--consulta-se o dicionário de dados do oracle
--importante saber colher informações do dicionário do banco de dados
-- uma view da estrutura do dicionário do oracle:
DESC user_tables;
--para o desenvolvedor o mais importante é saber acessar as tabelas:
SELECT table_name
FROM user_tables;
--segunda maneira de acessar as tabelas:
DESC user_objects; --visualizar a estrutura

SELECT object_name, object_type
FROM user_objects
WHERE object_type = 'TABLE';

-- ctas, create table as - criação de uma tabela a partir de uma sub-consulta
-- cria-se uma tabela e já realiza o preenchimento por meio de um select
CREATE TABLE employees_department60
AS
SELECT employee_id, last_name, salary*12 ANNSAL, hire_date
FROM employees
WHERE department_id = 60;

DESC employees_department60;

SELECT *
FROM employees_department60;

-- truncate table deleta todas as linhas da tabela, a deixa vazia
-- diferença entre truncate e delete: delete permite o rollback(dml), já o truncate é ddl, não gera rollback

-- drop table remove uma tabela inteira e a coloca numa lixeira (recycle bin)
-- não permite inicialmente a exclusão de tabelas com referências, foreing key
-- para excluir mesmo com referências, utilizar a cláusula cascade constraints após o nome da tabela
-- o comando flashback pode restaurar uma tabela excluída
-- com a cláusula purge a remoção é definitiva, não irá para a lixeira (evitar)
-- exemplo drop table

DROP TABLE employees_department60;

SELECT *
FROM employees_department60;
-- para visualizar o que tem na lixeira:
SELECT *
FROM user_recyclebin;
-- para restaurar é com o flashback, parte avançada, seção 26