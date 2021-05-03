-- sub-consultas correlacionadas
-- empregados cujos salários são maiores ou iguais a média do departamento correspondente
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.department_id, e1.salary
FROM employees e1
WHERE e1.salary >= (SELECT TRUNC(AVG(NVL(salary,0)),0)
                    FROM employees e2
                    WHERE e1.department_id = e2.department_id);
-- prova real do exercício anterior. média de um departamento específico:
SELECT TRUNC(AVG(NVL(salary,0)),0)
FROM employees e2
WHERE e2.department_id = 60;
                    
-- média de salários por departamento:
SELECT e.department_id, d.department_name, AVG(NVL(salary,0))
FROM employees e, departments d
GROUP BY e.department_id, d.department_name;