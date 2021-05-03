--tipos de indexes: unique index e non unique index
--unique index: não permitem valores duplicados, automaticamente criados pelo oracle ao criar constraint pk e uk
--podem ser criados manualmente, mas recomenda-se a criação de uma constraint uk ou pk para ser criada automaticamente

--removendo indexes existentes:
DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;
DROP INDEX employees_name_idx;
DROP INDEX employees_last_name_first_name_idx;
DROP INDEX employees_job_id_idx;
DROP INDEX employees_phone_number_idx;
DROP INDEX emp_job_ix;

SELECT *
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

ALTER TABLE employees
DROP CONSTRAINT employees_phone_number_uk;

--criando unique index manualmente:
CREATE UNIQUE INDEX employees_phone_number_idx
ON employees(phone_number);

--non unique index: permitem valores duplicados, são criados manualmente para aumentar a performance da recuperação de linhas
--é o tipo padrão do index, se nada especificado, o index será non unique
--criando um index default (non unique) simples:
CREATE INDEX employees_last_name_idx
ON employees(last_name);

--criando um index default (non unique) composto (múltiplas colunas):
CREATE INDEX employees_name_idx
ON employees(last_name, first_name); --ordem de sitação das colunas é importantíssimo

--tipos de indexes: b-tree e bitmap - diferença na implementação física
--b-tree: árvore binária. tipo default, para colunas com valores muito distintos
--bitmap: mapa de indexes. especificar durante a criação, utiliza o mapa de bits, para colunas com valores menos distintos, para tabelas com pouco dml
--recomendados para sistemas business intelligent (bi) (só fazem select)

--criando dois indexes default (non unique) b-tree simples:
CREATE INDEX employees_job_id_idx
ON employees(job_id);
--testando:
SELECT *
FROM employees
WHERE job_id = 'IT_PROG';
--executou com um range scan(faixa), pois cada job pode ter mais de um empregado
--com o range o oracle pega toda a faixa que satisfazem a cláusula where e só então consulta a tabela

--criação2:
--antes um teste:
SELECT *
FROM employees
WHERE last_name = 'Himuro';

CREATE INDEX employees_last_name_idx
ON employees(last_name);

--criando um index default (non unique) b-tree composto (múltiplas colunas):
CREATE INDEX employees_name_idx
ON employees(last_name, first_name);
--testanto:
SELECT *
FROM employees
WHERE last_name = 'Himuro' AND first_name = 'Guy';

--criando dois indexes non unique bitmap simples:
--há uma conversão interna de single value para rowid (bitmap conversion)
CREATE BITMAP INDEX employees_job_id_idx
ON employees(job_id);
--testando:
SELECT *
FROM employees
WHERE job_id = 'IT_PROG';