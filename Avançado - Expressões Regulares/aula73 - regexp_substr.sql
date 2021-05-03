--utilizando regexp_substr:
--mesmo princípio da substr(), mas permitindo expressões regulares
--retorna a parte do string que combina com o padrão da expressão regular
--pode ter até 5 argumentos: 1.string - onde será a pesquisa, 2.padrão - o que será procurado,
--3.posição - posição(número) para iniciar a pesquisa(default - 1),
--4.ocorrência - ql ocorrêcia deve ser retornada(0 - todas, 1 - a primeira(default), 2 - a segunda...) e 5.opção de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma cópia da tabela employees juntando o nome com sobrenome em uma única coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;
--consultando a tabela recém criada:
SELECT *
FROM   employees_copy;

--comparação case sensitive(default):
--dentro de uma linha(name) o oracle retornará apenas o primeiro nome (a primeira ocorrência que satisfaz) de cada coluna:
SELECT name, REGEXP_SUBSTR(name, '^[A-Z][[:alpha:]]+ ') as first_name
FROM employees_copy;
--mesma comparação inserindo os default:
SELECT name, REGEXP_SUBSTR(name, '^[A-Z][[:alpha:]]+ ',1,1,'c') as first_name
FROM employees_copy;