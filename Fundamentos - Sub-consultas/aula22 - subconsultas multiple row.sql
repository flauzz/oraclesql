-- sub-consultas: multiple-row. podem retornar mais de uma linha
-- fazem uso dos operadores de compara��o de m�ltiplas linhas: in, any, all
-- in: esteja dentro de uma lista. substitui cada item da lista e realiza a compara��o. internamente usa or. not in usa and
-- any: retorna os valores que satisfa�am a sub-consulta no modo mais abrangente. os valores precisam atender pelo menos uma restri��o
-- all: retorna os valores que satisfa�am a sub-consulta no modo menos abrangente. os valores precisam atender todas as restri��es
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary IN (SELECT AVG(NVL(salary,0))
                FROM employees
                GROUP BY department_id);
                
-- utilizando o not in. n�o estejam dentro da lista:
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary NOT IN (SELECT AVG(NVL(salary,0))
                FROM employees
                GROUP BY department_id);

-- utilizando any. precisa ser precedido de algum operador de compara��o
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');

-- utilizando all. precisa ser precedido de algum operador de compara��o
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
-- utitlizando o in n�o h� problema se um dos valores da sub-consulta for null:
SELECT emp.employee_id, emp.last_name
FROM employees emp
WHERE emp.employee_id IN (SELECT mgr.manager_id
                          FROM employees mgr);