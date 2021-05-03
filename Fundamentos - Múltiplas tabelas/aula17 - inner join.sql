-- inner join: todos aqueles joins que retornam apenas as linhas coincidentes. há correspondência nas duas tabelas
-- palavra inner é opcional
-- todos joins vistos até agr são inner join
SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
ORDER BY e.employee_id;