--objetos do banco de dados
--divididos em: schema objects e nonschema objects

--schema objects: esquema do usuário tem o mesmo nome do usuário
--coleção de estruturas lógicas de objetos - tabelas, views, suquences, procedures, synonym, constraints

--nonoschema objects: objetos que não pertencem a um schema de usuário. são objetos de administração (dba)
--ex: directories, roles(conjunto de privilégios), tablespaces(espaços lógicos), users

--estrutura que é acessada pelo dicionário do oracle. mostra os objetos que o usuário tem acesso, objetos do schema
DESC user_objects;

SELECT object_name, object_type, status
FROM user_objects
ORDER BY object_type;