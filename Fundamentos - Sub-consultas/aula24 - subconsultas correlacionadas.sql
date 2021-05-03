-- sub-consultas correlacionadas
-- empregados cujos sal�rios s�o maiores ou iguais a m�dia do departamento correspondente
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.department_id, e1.salary
FROM employees e1
WHERE e1.salary >= (SELECT TRUNC(AVG(NVL(salary,0)),0)
                    FROM employees e2
                    WHERE e1.department_id = e2.department_id);
-- prova real do exerc�cio anterior. m�dia de um departamento espec�fico:
SELECT TRUNC(AVG(NVL(salary,0)),0)
FROM employees e2
WHERE e2.department_id = 60;
                    
-- m�dia de sal�rios por departamento:
SELECT e.department_id, d.department_name, AVG(NVL(salary,0))
FROM employees e, departments d
GROUP BY e.department_id, d.department_name;