--flashback versions query:
--retornará o histórico completo de linhas consultadas entre dois scn ou entre dois timestamps
--scn - system change number: número incremental único que está associado a cada mudança feita no banco de dados
--pseudocolunas disponíveis: x=versions, 1. x_startscn, 2. x_starttime, 3. x_endscn, 4. x_endtime, 5. x_xid, 6. x_operation
--1. retorna o scn do início. 2. retorna uma data em formato timestamp do início
--3. retorna o scn do final. 4. retorna uma data em formato timestamp do final
--5. retorna o id da transação. 6. retorna o comando que foi executado (insert, update, delete)
--para executá-lo é necessário o seguinte privilégio cedido pelo dba(user sys):
GRANT EXECUTE ON DBMS_FLASHBACK to HR;
--alterando o undo que por padrão é baixo (meta de retenção):
ALTER SYSTEM SET UNDO_RETENTION = 172800; -- 172800 segundos = 2880 minutos = 48 horas
--apenas calculando quantos minutos e horas equivalem 172800 segundos:
SELECT 172800 segundos, 172800/60 minutos, 172800/60/60 horas
FROM dual;

--como user, apagando e criando uma cópia da tabela employees para prática:
DROP TABLE employees_copy;

CREATE TABLE employees_copy
AS 
SELECT *
FROM employees;
--consultando a tabela recém criada:
SELECT *
FROM employees_copy;

--consultando o system change number (scn) atual:
SELECT DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER
FROM dual;
--scn encontrado = 5086585

--consultando um empregado para atualizar um dado específico:
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy
WHERE employee_id = 180;
--alterando o salário dele:
UPDATE employees_copy
SET salary = 10000
WHERE employee_id = 180;

COMMIT; --efetivando a transação

--consultando o novo system change number (scn) atual:
SELECT DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER
FROM dual;
--novo scn encontrado = 5086689

--consultando o empregado de employees_copy após a alteração (posição atual):
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy
WHERE employee_id = 180;

--consultando a tabela employees_copy na posição anterior ao update (scn 5086585) utilizando flashback query:
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy AS OF SCN 5086585
WHERE employee_id = 180;

--flashback version query - consultando o histórico de atualizações do employee_id = 180:
SELECT versions_startscn, versions_starttime, versions_endscn, versions_endtime, versions_xid, 
       versions_operation, employee_id, first_name, last_name, salary
FROM employees_copy VERSIONS BETWEEN SCN 5086585 AND 5086689 --especificando o intervalo que desejo executar a query(antes e depois do update)
WHERE employee_id = 180;
--mesma consulta no formato timestamp:
SELECT versions_startscn, versions_starttime, versions_endscn, versions_endtime,
       versions_xid, versions_operation, employee_id, first_name, last_name, salary
FROM   employees_copy VERSIONS BETWEEN timestamp  TO_TIMESTAMP('10/12/2020 17:09:25', 'DD/MM/YYYY HH24:MI:SS') AND 
                                                  TO_TIMESTAMP('10/12/2020 17:10:00', 'DD/MM/YYYY HH24:MI:SS')
WHERE  employee_id = 180;