--flashback versions query:
--retornar� o hist�rico completo de linhas consultadas entre dois scn ou entre dois timestamps
--scn - system change number: n�mero incremental �nico que est� associado a cada mudan�a feita no banco de dados
--pseudocolunas dispon�veis: x=versions, 1. x_startscn, 2. x_starttime, 3. x_endscn, 4. x_endtime, 5. x_xid, 6. x_operation
--1. retorna o scn do in�cio. 2. retorna uma data em formato timestamp do in�cio
--3. retorna o scn do final. 4. retorna uma data em formato timestamp do final
--5. retorna o id da transa��o. 6. retorna o comando que foi executado (insert, update, delete)
--para execut�-lo � necess�rio o seguinte privil�gio cedido pelo dba(user sys):
GRANT EXECUTE ON DBMS_FLASHBACK to HR;
--alterando o undo que por padr�o � baixo (meta de reten��o):
ALTER SYSTEM SET UNDO_RETENTION = 172800; -- 172800 segundos = 2880 minutos = 48 horas
--apenas calculando quantos minutos e horas equivalem 172800 segundos:
SELECT 172800 segundos, 172800/60 minutos, 172800/60/60 horas
FROM dual;

--como user, apagando e criando uma c�pia da tabela employees para pr�tica:
DROP TABLE employees_copy;

CREATE TABLE employees_copy
AS 
SELECT *
FROM employees;
--consultando a tabela rec�m criada:
SELECT *
FROM employees_copy;

--consultando o system change number (scn) atual:
SELECT DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER
FROM dual;
--scn encontrado = 5086585

--consultando um empregado para atualizar um dado espec�fico:
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy
WHERE employee_id = 180;
--alterando o sal�rio dele:
UPDATE employees_copy
SET salary = 10000
WHERE employee_id = 180;

COMMIT; --efetivando a transa��o

--consultando o novo system change number (scn) atual:
SELECT DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER
FROM dual;
--novo scn encontrado = 5086689

--consultando o empregado de employees_copy ap�s a altera��o (posi��o atual):
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy
WHERE employee_id = 180;

--consultando a tabela employees_copy na posi��o anterior ao update (scn 5086585) utilizando flashback query:
SELECT employee_id, first_name, last_name, job_id, salary
FROM employees_copy AS OF SCN 5086585
WHERE employee_id = 180;

--flashback version query - consultando o hist�rico de atualiza��es do employee_id = 180:
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