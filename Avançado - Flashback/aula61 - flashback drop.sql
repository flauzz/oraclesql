--flashback drop:
--a lixeira armazena todos os objetos q sofreram drop até que:
--elimine o objeto com o comando purge (pouquíssimo usado), restaure o objeto com o comando BEFORE DROP e a tablespace necessite ser extendida
--para consultar os objetos existentes na lixeira: x_recyclebin (user(ou apenas recyclebin), all, dba)
--antigamente era necessário um recover incompleto, sendo assim, todo o banco parava até a conslusão
--e tudo que foi feito no banco de dados inteiro a partir do recover incompleto será perdido
--purge table: elimina da lixeira definitivamente
--purge user_recyclebin: elimina definitivamente todos os objetos da lixeira
--criando uma tabela para exemplificar o uso do flashback drop:
CREATE TABLE employees_copia 
AS
SELECT *
FROM employees;
--consultando na lista de user a existência da tabela recém criada(no dicionário de dados):
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--query da tabela completa recém criada:
SELECT *
FROM employees_copia;

--simulando um erro do user, drop na tabela:
DROP TABLE employees_copia; --comando ddl, possui commit automático
--confirmando se o objeto ainda existe:
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--confirmando a não-existência dos dados da tabela:
SELECT *
FROM employees_copia;

--consultando a lixeira e verificando a existência da tabela que acabou de ser excluída:
SELECT *
FROM user_recyclebin
WHERE original_name = 'EMPLOYEES_COPIA';
--nome do objeto é renomeado para pertencer à lixeira

--restaurando/recuperando o objeto excluído (drop) a partir da lixeira:
FLASHBACK TABLE EMPLOYEES_COPIA TO BEFORE DROP;

--confimando que o objeto foi restaurado:
SELECT *
FROM user_objects
WHERE object_name = 'EMPLOYEES_COPIA';
--confirmando a restauração da tabela e de todos os seus dados:
SELECT *
FROM employees_copia;
--consultando a lixeira para verificar a não-existência do objeto recém restaurado:
SELECT *
FROM   user_recyclebin
WHERE  original_name = 'EMPLOYEES_COPIA';
--o oracle não traz de volta apenas as constraints de foreign key