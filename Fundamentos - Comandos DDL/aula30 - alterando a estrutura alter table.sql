-- alter table para:
-- adicionar uma nova coluna, modificar uma coluna,
-- definir um valor default para uma coluna, remover uma coluna, renomear uma coluna,
-- alterar o status de uma tabela para read-only ou read-write
ALTER TABLE projects
ADD (department_id NUMBER(4) NOT NULL);

SELECT *
FROM projects;

DESC projects;

--se adicionarmos uma coluna em uma tabela que já possui linhas, os valores para cada linha será null
--para não ser preenchida com null, para nova coluna deve ser acrescentado um valor default

-- removendo uma coluna:
-- comando ddl, commit automático, única forma de recuperar é com um backup do banco de dados
ALTER TABLE projects
DROP COLUMN department_id;

DESC projects;

--adicionando novamente:
ALTER TABLE projects
ADD (department_id NUMBER(4) NOT NULL);

DESC projects;

--modificando colunas. é possível alterar o tamanho do dado, tipo do dado(com conversão implícita compatível)
ALTER TABLE projects
MODIFY (project_code VARCHAR2(6));

DESC projects;

--renomeando uma coluna:
ALTER TABLE projects
RENAME COLUMN project_name TO name;

DESC projects;

--alterando tabela para o modo read-only:
--com isso, não é mais permitido comandos dml e ddl na tabela especificada
ALTER TABLE employees READ ONLY;

--alterando tabela para o modo read-write:
--com isso, é permitido comando dml e ddl na tabela especificada
ALTER TABLE employees READ WRITE;