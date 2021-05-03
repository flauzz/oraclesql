-- todos os objetos do schema hr:
SELECT *
FROM user_objects
ORDER BY object_type;

-- para criar tabelas precisa de privil�gio para isso
-- para cada coluna a ser criada � preciso informar o nome da coluna, o tipo de dado e tamanho m�ximo da coluna
-- para criar tabela para seu pr�prio usu�rio n�o � necess�rio especificar
-- o valor default � smp opcional
-- default: quando usado, ao n�o inserir a coluna no insert � atribu�do o dado definido como padr�o
-- not null � umas das constraint
-- varchar2 - alfanum�rico. tamanho vari�vel, utiliza mem�ria de acordo com o que for inserido. smp especificar o num m�ximo de bytes
-- char - tamanho n�o vari�vel, utiliza toda a mem�ria especificada independente do que for inserido. smp especificar o num total de bytes
-- number - s� se permite n�meros. primeiro argumento precis�o(n�mero total de d�gitos) e segundo argumento escala(quantas casas decimais)
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
budget          NUMBER(11,2)         NOT NULL, --11 d�gitos ao todo dos quais 2 ser�o ap�s o ponto (casas decimais)
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
-- rowid � uma pseudo coluna que n�o aparece num describe
-- � o endere�o l�gico de uma linha de uma tabela - endere�o em base 64
DESC employees;

SELECT employee_id, first_name, rowid, LENGTH(rowid)
FROM employees;
-- m�todo de acesso mais r�pido do oracle � j� informando o endere�o l�gico da linha:
SELECT employee_id, first_name, rowid, LENGTH(rowid)
FROM employees
WHERE rowid = 'AAARyrAAEAAAIv+AAE';

--quais s�o as tabelas que o schema do meu usu�rio possui?
--consulta-se o dicion�rio de dados do oracle
--importante saber colher informa��es do dicion�rio do banco de dados
-- uma view da estrutura do dicion�rio do oracle:
DESC user_tables;
--para o desenvolvedor o mais importante � saber acessar as tabelas:
SELECT table_name
FROM user_tables;
--segunda maneira de acessar as tabelas:
DESC user_objects; --visualizar a estrutura

SELECT object_name, object_type
FROM user_objects
WHERE object_type = 'TABLE';

-- ctas, create table as - cria��o de uma tabela a partir de uma sub-consulta
-- cria-se uma tabela e j� realiza o preenchimento por meio de um select
CREATE TABLE employees_department60
AS
SELECT employee_id, last_name, salary*12 ANNSAL, hire_date
FROM employees
WHERE department_id = 60;

DESC employees_department60;

SELECT *
FROM employees_department60;

-- truncate table deleta todas as linhas da tabela, a deixa vazia
-- diferen�a entre truncate e delete: delete permite o rollback(dml), j� o truncate � ddl, n�o gera rollback

-- drop table remove uma tabela inteira e a coloca numa lixeira (recycle bin)
-- n�o permite inicialmente a exclus�o de tabelas com refer�ncias, foreing key
-- para excluir mesmo com refer�ncias, utilizar a cl�usula cascade constraints ap�s o nome da tabela
-- o comando flashback pode restaurar uma tabela exclu�da
-- com a cl�usula purge a remo��o � definitiva, n�o ir� para a lixeira (evitar)
-- exemplo drop table

DROP TABLE employees_department60;

SELECT *
FROM employees_department60;
-- para visualizar o que tem na lixeira:
SELECT *
FROM user_recyclebin;
-- para restaurar � com o flashback, parte avan�ada, se��o 26