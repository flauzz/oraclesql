--criando sin�nimos
--serve para dar outro nome para um objeto
--nome mais f�cil/reduzido para referenciar um objeto
--em diferentes �reas tratar a mesma tabela com nomes difereentes (sin�nimos)
--sin�nimo privado vale apenas para o usu�rio vigente
--criando sin�nimos privados:
CREATE SYNONYM departamentos
FOR departments;

CREATE SYNONYM dept
FOR departments;

--utilizando sin�nimos:
SELECT *
FROM departamentos;

SELECT *
FROM dept;

--removendo sin�nimos (nada acontece com o objeto):
DROP SYNONYM departamentos;
DROP SYNONYM dept;

--dba pode fazer synonyms p�blicos que valer�o para todos os usu�rios
--entrar no sys para praticar synonyms p�blicos como dba
--voltando para conex�o hr:
SELECT *
FROM departamentos;

SELECT *
FROM dept;

--para remover synonym p�blico apenas sendo dba, sys
--ap�s a remo��o tabela fica inacess�vel por meio do synonym