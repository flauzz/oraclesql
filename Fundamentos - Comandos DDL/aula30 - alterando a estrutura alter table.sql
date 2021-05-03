-- alter table para:
-- adicionar uma nova coluna, modificar uma coluna,
-- definir um valor default para uma coluna, remover uma coluna, renomear uma coluna,
-- alterar o status de uma tabela para read-only ou read-write
ALTER TABLE projects
ADD (department_id NUMBER(4) NOT NULL);

SELECT *
FROM projects;

DESC projects;

--se adicionarmos uma coluna em uma tabela que j� possui linhas, os valores para cada linha ser� null
--para n�o ser preenchida com null, para nova coluna deve ser acrescentado um valor default

-- removendo uma coluna:
-- comando ddl, commit autom�tico, �nica forma de recuperar � com um backup do banco de dados
ALTER TABLE projects
DROP COLUMN department_id;

DESC projects;

--adicionando novamente:
ALTER TABLE projects
ADD (department_id NUMBER(4) NOT NULL);

DESC projects;

--modificando colunas. � poss�vel alterar o tamanho do dado, tipo do dado(com convers�o impl�cita compat�vel)
ALTER TABLE projects
MODIFY (project_code VARCHAR2(6));

DESC projects;

--renomeando uma coluna:
ALTER TABLE projects
RENAME COLUMN project_name TO name;

DESC projects;

--alterando tabela para o modo read-only:
--com isso, n�o � mais permitido comandos dml e ddl na tabela especificada
ALTER TABLE employees READ ONLY;

--alterando tabela para o modo read-write:
--com isso, � permitido comando dml e ddl na tabela especificada
ALTER TABLE employees READ WRITE;