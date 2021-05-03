--referenciando objetos de outro schema(usuário)
--é preciso ter privilégio para tais consultas
--sempre prefixar qual é o usuário
--consultar uma tabela do próprio schema, não se faz necessário o uso de prefixo
--sem prefixo:
SELECT *
FROM employees;
--com prefixo:
SELECT *
FROM hr.employees;

--concedendo privilégios ao usuário aluno:
GRANT SELECT ON hr.employees TO aluno;