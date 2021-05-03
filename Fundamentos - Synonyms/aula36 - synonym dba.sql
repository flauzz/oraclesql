--conectado como dba
--criando synonym público:
CREATE PUBLIC SYNONYM departamentos
FOR hr.departments;

CREATE PUBLIC SYNONYM dept
FOR hr.departments;

--acessando como hr:
SELECT *
FROM departamentos;

SELECT *
FROM dept;
--volte para conexão hr
--removendo synonym público:
DROP PUBLIC SYNONYM departamentos;
DROP PUBLIC SYNONYM dept;