DESC dba_objects; --possui informa��es sobre todos os objetos do banco de dados e dos usu�rios existentes

SELECT owner, object_name, object_type, status
FROM dba_objects
WHERE owner = 'HR'
ORDER BY object_type;

SELECT *
FROM dba_users;