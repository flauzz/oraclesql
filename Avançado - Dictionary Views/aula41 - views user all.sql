--diferença entre as visões com prefixo: user, all, dba
--user: inclui objetos do schema do usuário que está conectado
--all: inclui objetos do schema do usuário que está conectado e objetos que o usuário possui privilégios de acesso
--dba: inclui todos os objetos do banco de dados. somente dba e usuários com muitos privilégios podem acessar
--todos os objetos do usuário conectado(hr):
SELECT *
FROM user_objects;

--todos os objetos do usuário conectado e os que ele tem privilégio(acesso):
SELECT *
FROM all_objects;

--todas as tabelas do usuário hr:
SELECT *
FROM user_tables;

--todas as tabelas do usuário + tableas que ele tem acesso:
SELECT *
FROM all_tables;

--informações sobre as colunas de todas as tabelas do user conectado:
SELECT *
FROM user_tab_columns;

--todas as colunas de determinada tabela do user conectado:
SELECT *
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES'
ORDER BY column_id;
--todas as colunas de determinada tabela e de determinado user com all:
SELECT *
FROM all_tab_columns
WHERE owner = 'HR' AND table_name = 'EMPLOYEES'
ORDER BY column_id;

--informações sobre todas as constraints do user conectado:
SELECT *
FROM user_constraints;
--informações sobre as constraints de determinada tabela:
SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
--informações sobre as constraints de determinada tabela com all:
SELECT *
FROM all_constraints
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';

--infomações sobre as colunas de determinada constraint:
SELECT *
FROM user_cons_columns
WHERE table_name = 'EMPLOYEES' AND constraint_name = 'EMP_EMP_ID_PK';
--infomações sobre as colunas de determinada constraint com all:
SELECT *
FROM all_cons_columns
WHERE owner = 'HR' AND table_name = 'EMPLOYEES' AND constraint_name = 'EMP_EMP_ID_PK';

--infomações sobre index de tabelas do próprio user:
SELECT *
FROM user_indexes
WHERE table_name = 'EMPLOYEES';
--infomações sobre index de tabelas do próprio user com all:
SELECT *
FROM all_indexes
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';

--infomações sobre as colunas que compõem um index do próprio user:
SELECT *
FROM user_ind_columns
WHERE table_name = 'EMPLOYEES' AND index_name = 'EMP_EMP_ID_PK';
--infomações sobre as colunas que compõem um index com o all:
SELECT *
FROM all_ind_columns
WHERE index_owner = 'HR' AND table_name = 'EMPLOYEES' AND index_name = 'EMP_EMP_ID_PK';

--infomações sobre sequences do próprio user:
SELECT *
FROM user_sequences;
--infomações sobre sequences do próprio user com all:
SELECT *
FROM all_sequences
WHERE sequence_owner = 'HR';

--infomações sobre views do próprio user:
SELECT *
FROM user_views;
--infomações sobre views do próprio user com all:
SELECT *
FROM all_views
WHERE owner = 'HR';