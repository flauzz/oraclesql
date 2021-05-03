-- gerenciando constraints: removendo, adicionando, desabilitando, habilitanto, consultando
--primeiro passo consultar constraints:
SELECT co.constraint_name, co.constraint_type, co.search_condition, co.r_constraint_name, co.delete_rule,
       cc.column_name, cc.position, co.status
FROM user_constraints co
JOIN user_cons_columns cc ON (co.constraint_name = cc.constraint_name)
                          AND (co.table_name = cc.table_name)
WHERE co.table_name = 'PROJECTS' --consultar as constraints da tabela projects. case sensitive
ORDER BY co.constraint_name, cc.position;

-- removendo constraints:
ALTER TABLE projects
DROP CONSTRAINT projects_department_id_fk;
--ao apagar perde-se a integridade. será possível inserir department_id inexistentes

ALTER TABLE projects
DROP CONSTRAINT projects_project_id_pk
CASCADE;

--adicionando constraints:
ALTER TABLE projects
ADD CONSTRAINT projects_department_id_fk FOREIGN KEY(department_id)
REFERENCES departments(department_id);

ALTER TABLE projects
ADD CONSTRAINT projects_project_id_pk PRIMARY KEY(project_id);

--desabilitando constraints:
ALTER TABLE projects
DISABLE CONSTRAINT projects_department_id_fk;

ALTER TABLE projects
DISABLE CONSTRAINT projects_project_id_pk CASCADE;

--habilitando constraints:
ALTER TABLE projects
ENABLE CONSTRAINT projects_department_id_fk;

ALTER TABLE projects
ENABLE CONSTRAINT projects_project_id_pk;