DESC dba_objects; --possui informações sobre todos os objetos do banco de dados e dos usuários existentes

SELECT owner, object_name, object_type, status
FROM dba_objects
WHERE owner = 'HR'
ORDER BY object_type;

SELECT *
FROM dba_users;