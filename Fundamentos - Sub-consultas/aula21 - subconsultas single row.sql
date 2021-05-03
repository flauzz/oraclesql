-- sub-consultas: single-row - retornam apenas uma linha
-- realiza uma consulta a partir do resultado de outra consulta
-- sub-consulta é executada antes da principal
-- fazem uso dos operadores de comparação de linhas simples: =, >, <, <>, !=
SELECT first_name, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT AVG(NVL(salary,0))
                FROM employees)
ORDER BY salary DESC;

-- utilizando o having
SELECT e.department_id, MAX(e.salary)
FROM employees e
GROUP BY e.department_id
HAVING MAX(e.salary) < (SELECT AVG(NVL(e2.salary,0))
                        FROM employees e2);