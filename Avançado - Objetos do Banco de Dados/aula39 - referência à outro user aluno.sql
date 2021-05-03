--consultar uma tabela de ontro usu�rio, no caso o hr
SELECT *
FROM hr.employees;
--dar� erro pois usu�rio aluno n�o tem privil�gio para acessar tabelas alheias
--� preciso pedir acesso a tabela ao dono da tabela (hr) ou ao dba
--ap�s o dono liberar acesso ao select de employees, d� certo:
SELECT *
FROM hr.employees;
--se tiver um synonym p�blico para tal tabela, pode ser feito um select sem referenciar
--quem cria o synonym p�blico � o dba
--sem um synonym p�blico d� erro:
SELECT *
FROM employees;
--ap�s um synonym p�blico criado pelo dba, d� certo:
SELECT *
FROM employees;