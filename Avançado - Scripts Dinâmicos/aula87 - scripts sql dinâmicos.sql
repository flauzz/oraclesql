--gerando scripts sql din�micos:
--� poss�vel gerar comandos/scripts concatenando strings com informa��es do dicion�rio de dados oracle
--conectado como user sys/dba:
--para a pr�tica, apagando e criando novo user 'curso':
DROP USER curso; 

CREATE USER curso
IDENTIFIED BY curso --senha para conectar
DEFAULT TABLESPACE users --�rea l�gica de trabalho onde o usu�rio cria tables, indexes, sequences
QUOTA UNLIMITED ON users --o user pode usar qnto espa�o quiser na tablespace definida
TEMPORARY TABLESPACE temp; --utilizada qndo � executado merge
--grant para conceder privil�gio, connect para permitir conex�o com bd
--e resource que permite cria��o de tables, procedures, functions, sequences, ou seja, cria��o de objetos dentro do bd:
GRANT CONNECT, RESOURCE TO curso;

--criar uma pasta no windows c:\cursos\oracle\sql_especialista
--na linha de comando do windows execute: mkdir C:\cursos\oracle\sql_especialista
--entrar na pasta: cd C:\cursos\oracle\sql_especialista
--no sql developer criar uma conex�o para o user curso 
--conectado como user curso:
--deletar e recriar a tabela alunos:
DROP TABLE alunos;

CREATE TABLE alunos
(aluno_id NUMBER(11),
nome VARCHAR2(200));

--deletar e recriar a tabela cursos:
DROP TABLE cursos;

CREATE TABLE cursos
(curso_id NUMBER(11),
nome VARCHAR2(200),
preco NUMBER(11,2));
 
--consultando as tabelas existentes no user conectado(curso): 
SELECT *
FROM user_tables;

--criando um script que remove(drop) todas as tabelas do user conectado(curso):
SET HEADING OFF --remover o cabe�alho das colunas
SPOOL C:\cursos\oracle\sql_especialista\drop_tables.sql --gera um arquivo texto para a sa�da do comando sql
SELECT 'DROP TABLE ' || table_name || ' cascade constraints;'
FROM user_tables; --para cada linha da table user_tables o oracle vai executar o string de comandos do select
SPOOL OFF --para executar, selecionar os comandos e executar com f5

--no windows explorer: localizar arquivo rec�m criado, editar e vizualizar. mostra os comandos a serem executados
--duas op��es para execut�-los: copiar e colar na query builder e executar ou executar o spool
--para executar o spool:
@C:\cursos\oracle\sql_especialista\drop_tables.sql --colocar todo o caminho de onde se encontra o script, selecionar e executar com f5

--consultando as tabelas do user conectado(curso): 
SELECT *
FROM user_tables;