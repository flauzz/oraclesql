--referenciando objetos de outro schema(usu�rio)
--� preciso ter privil�gio para tais consultas
--sempre prefixar qual � o usu�rio
--consultar uma tabela do pr�prio schema, n�o se faz necess�rio o uso de prefixo
--sem prefixo:
SELECT *
FROM employees;
--com prefixo:
SELECT *
FROM hr.employees;

--concedendo privil�gios ao usu�rio aluno:
GRANT SELECT ON hr.employees TO aluno;