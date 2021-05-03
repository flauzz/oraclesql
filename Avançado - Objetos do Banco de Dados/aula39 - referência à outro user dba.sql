--referenciando objetos de outro schema(usu�rio)
--criando novo usu�rio aluno:
CREATE USER aluno --nome do usu�rio
IDENTIFIED BY aluno --senha do usu�rio
DEFAULT TABLESPACE users --onde tabelas e index criados ficar�o quando aluno criar
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users; --pode usar quanto espa�o quiser na tablespace users

GRANT CREATE SESSION TO aluno; --passando o privil�gio do aluno poder criar/iniciar uma sess�o no oracle
--criar uma conex�o para o usu�rio na aba conex�es

CREATE PUBLIC SYNONYM employees FOR hr.employees;