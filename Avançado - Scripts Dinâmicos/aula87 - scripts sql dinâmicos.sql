--gerando scripts sql dinâmicos:
--é possível gerar comandos/scripts concatenando strings com informações do dicionário de dados oracle
--conectado como user sys/dba:
--para a prática, apagando e criando novo user 'curso':
DROP USER curso; 

CREATE USER curso
IDENTIFIED BY curso --senha para conectar
DEFAULT TABLESPACE users --área lógica de trabalho onde o usuário cria tables, indexes, sequences
QUOTA UNLIMITED ON users --o user pode usar qnto espaço quiser na tablespace definida
TEMPORARY TABLESPACE temp; --utilizada qndo é executado merge
--grant para conceder privilégio, connect para permitir conexão com bd
--e resource que permite criação de tables, procedures, functions, sequences, ou seja, criação de objetos dentro do bd:
GRANT CONNECT, RESOURCE TO curso;

--criar uma pasta no windows c:\cursos\oracle\sql_especialista
--na linha de comando do windows execute: mkdir C:\cursos\oracle\sql_especialista
--entrar na pasta: cd C:\cursos\oracle\sql_especialista
--no sql developer criar uma conexão para o user curso 
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
SET HEADING OFF --remover o cabeçalho das colunas
SPOOL C:\cursos\oracle\sql_especialista\drop_tables.sql --gera um arquivo texto para a saída do comando sql
SELECT 'DROP TABLE ' || table_name || ' cascade constraints;'
FROM user_tables; --para cada linha da table user_tables o oracle vai executar o string de comandos do select
SPOOL OFF --para executar, selecionar os comandos e executar com f5

--no windows explorer: localizar arquivo recém criado, editar e vizualizar. mostra os comandos a serem executados
--duas opções para executá-los: copiar e colar na query builder e executar ou executar o spool
--para executar o spool:
@C:\cursos\oracle\sql_especialista\drop_tables.sql --colocar todo o caminho de onde se encontra o script, selecionar e executar com f5

--consultando as tabelas do user conectado(curso): 
SELECT *
FROM user_tables;