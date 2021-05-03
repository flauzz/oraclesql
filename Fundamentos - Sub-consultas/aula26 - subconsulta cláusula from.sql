-- sub-consulta na cl�usula from. "tabela virtual"
-- utilizado quando n�o se tem uma view do que precisamos
-- on � a condi��o de liga��o entre as duas tabelas
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.job_id, salary,
ROUND(max_salary_job.max_salary,2) "Sal�rio M�ximo", e1.salary - ROUND(max_salary_job.max_salary,2) Diferen�a
FROM employees e1
LEFT JOIN (SELECT e2.job_id, MAX(e2.salary) max_salary
           FROM employees e2
           GROUP BY e2.job_id) max_salary_job
           ON e1.job_id = max_salary_job.job_id;