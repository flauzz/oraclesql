--utilizando regexp_instr:
--semelhante com a fun��o instr(), mas com express�o regular
--retorna o valor inteiro da posi��o do string que combina com o padr�o da express�o regular dentro do string pesquisado
--pode ter at� 6 argumentos: 1.string - onde ser� a pesquisa, 2.padr�o - o que ser� procurado,
--3.posi��o - posi��o(n�mero) para iniciar a pesquisa (default - 1), 4.ocorr�ncia - ql ocorr�cia deve ser retornada(0 - todas, 1 - a primeira(default),
--2 - a segunda...), 5.op��o de retorno - retorna a posi��o em q foi encontrado o padr�o(0 - posi��o exata(default), 1 - a posi��o seguinte)
--e 6.op��o de match - c(default), i ou m
--apagando e recriando a tabela employees_copy:
DROP TABLE employees_copy;
--fazendo uma c�pia da tabela employees juntando o nome com sobrenome em uma �nica coluna:
CREATE TABLE employees_copy
AS 
SELECT employee_id, first_name || ' ' || last_name name, email, phone_number, hire_date, job_id,
       salary, commission_pct, manager_id, department_id
FROM employees;

--compara��o case sensitive(default):
--retorna ql � a posi��o que se encontra o padr�o procurado:
SELECT name, REGEXP_INSTR(name, '^[A-Z][[:alpha:]]+ ') as position
FROM employees_copy;
--mesma compara��o inserindo os default:
SELECT name, REGEXP_INSTR(name, '^[A-Z][[:alpha:]]+ ', 1,1,0,'c') as position
FROM employees_copy;