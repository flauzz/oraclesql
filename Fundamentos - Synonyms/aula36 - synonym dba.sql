--conectado como dba
--criando synonym p�blico:
CREATE PUBLIC SYNONYM departamentos
FOR hr.departments;

CREATE PUBLIC SYNONYM dept
FOR hr.departments;

--acessando como hr:
SELECT *
FROM departamentos;

SELECT *
FROM dept;
--volte para conex�o hr
--removendo synonym p�blico:
DROP PUBLIC SYNONYM departamentos;
DROP PUBLIC SYNONYM dept;