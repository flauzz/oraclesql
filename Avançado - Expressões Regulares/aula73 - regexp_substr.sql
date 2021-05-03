--utilizando regexp_substr:
--mesmo princ�pio da substr(), mas permitindo express�es regulares
--retorna a parte do string que combina com o padr�o da express�o regular
--pode ter at� 5 argumentos: 1.string - onde ser� a pesquisa, 2.padr�o - o que ser� procurado,
--3.posi��o - posi��o(n�mero) para iniciar a pesquisa(default - 1),
--4.ocorr�ncia - ql ocorr�cia deve ser retornada(0 - todas, 1 - a primeira(default), 2 - a segunda...) e 5.op��o de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma c�pia da tabela employees juntando o nome com sobrenome em uma �nica coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;
--consultando a tabela rec�m criada:
SELECT *
FROM   employees_copy;

--compara��o case sensitive(default):
--dentro de uma linha(name) o oracle retornar� apenas o primeiro nome (a primeira ocorr�ncia que satisfaz) de cada coluna:
SELECT name, REGEXP_SUBSTR(name, '^[A-Z][[:alpha:]]+ ') as first_name
FROM employees_copy;
--mesma compara��o inserindo os default:
SELECT name, REGEXP_SUBSTR(name, '^[A-Z][[:alpha:]]+ ',1,1,'c') as first_name
FROM employees_copy;