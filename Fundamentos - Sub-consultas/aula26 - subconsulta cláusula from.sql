-- sub-consulta na cláusula from. "tabela virtual"
-- utilizado quando não se tem uma view do que precisamos
-- on é a condição de ligação entre as duas tabelas
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.job_id, salary,
ROUND(max_salary_job.max_salary,2) "Salário Máximo", e1.salary - ROUND(max_salary_job.max_salary,2) Diferença
FROM employees e1
LEFT JOIN (SELECT e2.job_id, MAX(e2.salary) max_salary
           FROM employees e2
           GROUP BY e2.job_id) max_salary_job
           ON e1.job_id = max_salary_job.job_id;