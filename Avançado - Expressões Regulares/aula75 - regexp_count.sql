--utilizando regexp_count:
--semelhante a fun��o count, mas com express�es regulares
--retorna o n�mero de vezes que o padr�o da express�o regular combina com o conte�do do string pesquisado
--pode ter at� 4 argumentos: 1.string - onde ser� a pesquisa, 2.padr�o - o que ser� procurado,
--3.posi��o - posi��o(n�mero) para iniciar a pesquisa (default - 1) e 4.op��o de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma c�pia da tabela employees juntando o nome com sobrenome em uma �nica coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;

--compara��o case sensitive(default):
--retornar� o n�mero de vogais que aparecem em cada linha da coluna:
SELECT name, REGEXP_COUNT(name, 'a|e|i|o|u') as numero_de_combina��es
FROM employees_copy;

--compara��o case sensitive(default):
--retornar� o sobrenome que combine com o padr�o e quantas vezes o mesmo padr�o pesquisado ir� se repetir em cada linha da coluna:
SELECT name, REGEXP_SUBSTR(name, ' [A-Z][[:alpha:]]+$') as last_name, REGEXP_COUNT(name, ' [A-Z][[:alpha:]]+$') as count
FROM employees_copy;