--flashback drop:
--a lixeira armazena todos os objetos q sofreram drop at� que:
--elimine o objeto com o comando purge (pouqu�ssimo usado), restaure o objeto com o comando BEFORE DROP e a tablespace necessite ser extendida
--para consultar os objetos existentes na lixeira: x_recyclebin (user(ou apenas recyclebin), all, dba)
--antigamente era necess�rio um recover incompleto, sendo assim, todo o banco parava at� a conslus�o
--e tudo que foi feito no banco de dados inteiro a partir do recover incompleto ser� perdido
--purge table: elimina da lixeira definitivamente
--purge user_recyclebin: elimina definitivamente todos os objetos da lixeira
--criando uma tabela para exemplificar o uso do flashback drop:
CREATE TABLE employees_copia 
AS
SELECT *
FROM employees;
--consultando na lista de user a exist�ncia da tabela rec�m criada(no dicion�rio de dados):
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--query da tabela completa rec�m criada:
SELECT *
FROM employees_copia;

--simulando um erro do user, drop na tabela:
DROP TABLE employees_copia; --comando ddl, possui commit autom�tico
--confirmando se o objeto ainda existe:
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--confirmando a n�o-exist�ncia dos dados da tabela:
SELECT *
FROM employees_copia;

--consultando a lixeira e verificando a exist�ncia da tabela que acabou de ser exclu�da:
SELECT *
FROM user_recyclebin
WHERE original_name = 'EMPLOYEES_COPIA';
--nome do objeto � renomeado para pertencer � lixeira

--restaurando/recuperando o objeto exclu�do (drop) a partir da lixeira:
FLASHBACK TABLE EMPLOYEES_COPIA TO BEFORE DROP;

--confimando que o objeto foi restaurado:
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--confirmando a restaura��o da tabela e de todos os seus dados:
SELECT *
FROM employees_copia;
--consultando a lixeira para verificar a n�o-exist�ncia do objeto rec�m restaurado:
SELECT *
FROM   user_recyclebin
WHERE  original_name = 'EMPLOYEES_COPIA';
--o oracle n�o traz de volta apenas as constraints de foreign key