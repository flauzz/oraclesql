--objetos do banco de dados
--divididos em: schema objects e nonschema objects

--schema objects: esquema do usu�rio tem o mesmo nome do usu�rio
--cole��o de estruturas l�gicas de objetos - tabelas, views, suquences, procedures, synonym, constraints

--nonoschema objects: objetos que n�o pertencem a um schema de usu�rio. s�o objetos de administra��o (dba)
--ex: directories, roles(conjunto de privil�gios), tablespaces(espa�os l�gicos), users

--estrutura que � acessada pelo dicion�rio do oracle. mostra os objetos que o usu�rio tem acesso, objetos do schema
DESC user_objects;

SELECT object_name, object_type, status
FROM user_objects
ORDER BY object_type;