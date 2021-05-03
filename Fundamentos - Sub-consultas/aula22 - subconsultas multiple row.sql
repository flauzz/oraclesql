-- sub-consultas: multiple-row. podem retornar mais de uma linha
-- fazem uso dos operadores de comparação de múltiplas linhas: in, any, all
-- in: esteja dentro de uma lista. substitui cada item da lista e realiza a comparação. internamente usa or. not in usa and
-- any: retorna os valores que satisfaçam a sub-consulta no modo mais abrangente. os valores precisam atender pelo menos uma restrição
-- all: retorna os valores que satisfaçam a sub-consulta no modo menos abrangente. os valores precisam atender todas as restrições
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary IN (SELECT AVG(NVL(salary,0))
                FROM employees
                GROUP BY department_id);
                
-- utilizando o not in. não estejam dentro da lista:
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary NOT IN (SELECT AVG(NVL(salary,0))
                FROM employees
                GROUP BY department_id);

-- utilizando any. precisa ser precedido de algum operador de comparação
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');

-- utilizando all. precisa ser precedido de algum operador de comparação
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
-- utitlizando o in não há problema se um dos valores da sub-consulta for null:
SELECT emp.employee_id, emp.last_name
FROM employees emp
WHERE emp.employee_id IN (SELECT mgr.manager_id
                          FROM employees mgr);