--utilizando cl�usula with:
--usado qndo necess�rio muitos joins, quando uma consulta de alto custo � utilizada muitas vezes
--recupera o resultado de uma query e armazena na tablespace tempor�ria, assim a consulta ao inv�s das tabelas bases
--melhorando a performance

WITH max_salaries AS --nome para sub-consulta
       (SELECT department_id, MAX(salary) maximum_salary, ROUND(AVG(salary),2) average_salary        
        FROM employees e
        GROUP BY department_id
       ) --resultado armazenado numa tablespace tempor�ria do pr�prio user
SELECT e.employee_id, e.salary, e.department_id, max_salaries.maximum_salary, max_salaries.average_salary
FROM employees e
JOIN max_salaries ON (e.department_id = max_salaries.department_id);