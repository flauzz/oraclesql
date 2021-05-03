--referenciando objetos de outro schema(usuário)
--criando novo usuário aluno:
CREATE USER aluno --nome do usuário
IDENTIFIED BY aluno --senha do usuário
DEFAULT TABLESPACE users --onde tabelas e index criados ficarão quando aluno criar
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users; --pode usar quanto espaço quiser na tablespace users

GRANT CREATE SESSION TO aluno; --passando o privilégio do aluno poder criar/iniciar uma sessão no oracle
--criar uma conexão para o usuário na aba conexões

CREATE PUBLIC SYNONYM employees FOR hr.employees;