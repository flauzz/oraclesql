--utilizando regexp_instr:
--semelhante com a função instr(), mas com expressão regular
--retorna o valor inteiro da posição do string que combina com o padrão da expressão regular dentro do string pesquisado
--pode ter até 6 argumentos: 1.string - onde será a pesquisa, 2.padrão - o que será procurado,
--3.posição - posição(número) para iniciar a pesquisa (default - 1), 4.ocorrência - ql ocorrêcia deve ser retornada(0 - todas, 1 - a primeira(default),
--2 - a segunda...), 5.opção de retorno - retorna a posição em q foi encontrado o padrão(0 - posição exata(default), 1 - a posição seguinte)
--e 6.opção de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma cópia da tabela employees juntando o nome com sobrenome em uma única coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;

--comparação case sensitive(default):
--retorna ql é a posição que se encontra o padrão procurado:
SELECT name, REGEXP_INSTR(name, '^[A-Z][[:alpha:]]+ ') as position
FROM employees_copy;
--mesma comparação inserindo os default:
SELECT name, REGEXP_INSTR(name, '^[A-Z][[:alpha:]]+ ', 1,1,0,'c') as position
FROM employees_copy;