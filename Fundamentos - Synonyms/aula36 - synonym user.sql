--criando sinônimos
--serve para dar outro nome para um objeto
--nome mais fácil/reduzido para referenciar um objeto
--em diferentes áreas tratar a mesma tabela com nomes difereentes (sinônimos)
--sinônimo privado vale apenas para o usuário vigente
--criando sinônimos privados:
CREATE SYNONYM departamentos
FOR departments;

CREATE SYNONYM dept
FOR departments;

--utilizando sinônimos:
SELECT *
FROM departamentos;

SELECT *
FROM dept;

--removendo sinônimos (nada acontece com o objeto):
DROP SYNONYM departamentos;
DROP SYNONYM dept;

--dba pode fazer synonyms públicos que valerão para todos os usuários
--entrar no sys para praticar synonyms públicos como dba
--voltando para conexão hr:
SELECT *
FROM departamentos;

SELECT *
FROM dept;

--para remover synonym público apenas sendo dba, sys
--após a remoção tabela fica inacessível por meio do synonym