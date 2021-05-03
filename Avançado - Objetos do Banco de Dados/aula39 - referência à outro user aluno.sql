--consultar uma tabela de ontro usuário, no caso o hr
SELECT *
FROM hr.employees;
--dará erro pois usuário aluno não tem privilégio para acessar tabelas alheias
--é preciso pedir acesso a tabela ao dono da tabela (hr) ou ao dba
--após o dono liberar acesso ao select de employees, dá certo:
SELECT *
FROM hr.employees;
--se tiver um synonym público para tal tabela, pode ser feito um select sem referenciar
--quem cria o synonym público é o dba
--sem um synonym público dá erro:
SELECT *
FROM employees;
--após um synonym público criado pelo dba, dá certo:
SELECT *
FROM employees;