--utilizando regexp_count:
--semelhante a função count, mas com expressões regulares
--retorna o número de vezes que o padrão da expressão regular combina com o conteúdo do string pesquisado
--pode ter até 4 argumentos: 1.string - onde será a pesquisa, 2.padrão - o que será procurado,
--3.posição - posição(número) para iniciar a pesquisa (default - 1) e 4.opção de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma cópia da tabela employees juntando o nome com sobrenome em uma única coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;

--comparação case sensitive(default):
--retornará o número de vogais que aparecem em cada linha da coluna:
SELECT name, REGEXP_COUNT(name, 'a|e|i|o|u') as numero_de_combinações
FROM employees_copy;

--comparação case sensitive(default):
--retornará o sobrenome que combine com o padrão e quantas vezes o mesmo padrão pesquisado irá se repetir em cada linha da coluna:
SELECT name, REGEXP_SUBSTR(name, ' [A-Z][[:alpha:]]+$') as last_name, REGEXP_COUNT(name, ' [A-Z][[:alpha:]]+$') as count
FROM employees_copy;