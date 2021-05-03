--diferen�a entre as vis�es com prefixo: user, all, dba
--user: inclui objetos do schema do usu�rio que est� conectado
--all: inclui objetos do schema do usu�rio que est� conectado e objetos que o usu�rio possui privil�gios de acesso
--dba: inclui todos os objetos do banco de dados. somente dba e usu�rios com muitos privil�gios podem acessar
--todos os objetos do usu�rio conectado(hr):
SELECT *
FROM user_objects;

--todos os objetos do usu�rio conectado e os que ele tem privil�gio(acesso):
SELECT *
FROM all_objects;

--todas as tabelas do usu�rio hr:
SELECT *
FROM user_tables;

--todas as tabelas do usu�rio + tableas que ele tem acesso:
SELECT *
FROM all_tables;

--informa��es sobre as colunas de todas as tabelas do user conectado:
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

--informa��es sobre todas as constraints do user conectado:
SELECT *
FROM user_constraints;
--informa��es sobre as constraints de determinada tabela:
SELECT *
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
--informa��es sobre as constraints de determinada tabela com all:
SELECT *
FROM all_constraints
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';

--infoma��es sobre as colunas de determinada constraint:
SELECT *
FROM user_cons_columns
WHERE table_name = 'EMPLOYEES' AND constraint_name = 'EMP_EMP_ID_PK';
--infoma��es sobre as colunas de determinada constraint com all:
SELECT *
FROM all_cons_columns
WHERE owner = 'HR' AND table_name = 'EMPLOYEES' AND constraint_name = 'EMP_EMP_ID_PK';

--infoma��es sobre index de tabelas do pr�prio user:
SELECT *
FROM user_indexes
WHERE table_name = 'EMPLOYEES';
--infoma��es sobre index de tabelas do pr�prio user com all:
SELECT *
FROM all_indexes
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';

--infoma��es sobre as colunas que comp�em um index do pr�prio user:
SELECT *
FROM user_ind_columns
WHERE table_name = 'EMPLOYEES' AND index_name = 'EMP_EMP_ID_PK';
--infoma��es sobre as colunas que comp�em um index com o all:
SELECT *
FROM all_ind_columns
WHERE index_owner = 'HR' AND table_name = 'EMPLOYEES' AND index_name = 'EMP_EMP_ID_PK';

--infoma��es sobre sequences do pr�prio user:
SELECT *
FROM user_sequences;
--infoma��es sobre sequences do pr�prio user com all:
SELECT *
FROM all_sequences
WHERE sequence_owner = 'HR';

--infoma��es sobre views do pr�prio user:
SELECT *
FROM user_views;
--infoma��es sobre views do pr�prio user com all:
SELECT *
FROM all_views
WHERE owner = 'HR';