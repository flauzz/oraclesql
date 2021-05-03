--na view dba_objects há todos os objetos do banco
SELECT *
FROM dba_objects;
--somente os objetos do user hr:
SELECT *
FROM dba_objects
WHERE owner = 'HR';
--somaente as tabelas do user hr:
SELECT *
FROM dba_tables
WHERE owner = 'HR';
--todas as colunas de determinada tabela e de determinado user como dba:
SELECT *
FROM dba_tab_columns
WHERE owner = 'HR' AND table_name = 'EMPLOYEES'
ORDER BY column_id;
--informações sobre as constraints de determinada tabela e determinado user como dba:
SELECT *
FROM dba_constraints
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';
--infomações sobre as colunas de determinada constraint como dba:
SELECT *
FROM dba_cons_columns
WHERE owner = 'HR' AND table_name = 'EMPLOYEES' AND constraint_name = 'EMP_EMP_ID_PK';
--infomações sobre index de tabelas do próprio user como dba:
SELECT *
FROM dba_indexes
WHERE owner = 'HR' AND table_name = 'EMPLOYEES';
--infomações sobre as colunas que compõem um index como dba:
SELECT *
FROM dba_ind_columns
WHERE index_owner = 'HR' AND table_name = 'EMPLOYEES' AND index_name = 'EMP_EMP_ID_PK';
--infomações sobre sequences do próprio user como dba:
SELECT *
FROM dba_sequences
WHERE sequence_owner = 'HR';
--infomações sobre views do próprio user como dba:
SELECT *
FROM dba_views
WHERE owner = 'HR';

--mais informações só como dba:
--todos os usuários do banco de dados:
SELECT *
FROM dba_users;
--todas as tablespaces do banco de dados: espaços lógicos de dados
SELECT *
FROM dba_tablespaces;
--todos os data_files do banco de dados:
SELECT *
FROM dba_data_files;
--todos os temp_files do banco de dados:
SELECT *
FROM dba_temp_files;