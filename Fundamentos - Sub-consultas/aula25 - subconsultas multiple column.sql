-- sub-consultas multiple-column
-- se sub-consulta multiple, express�o de compara��o tbm deve ser multiple igual. compara primeira com primeira, segunda com segunda...
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.salary
FROM employees e1
WHERE (e1.job_id, e1.salary) IN (SELECT e2.job_id, MAX(e2.salary)
                                 FROM employees e2
                                 GROUP BY e2.job_id);
-- sub-consulta retorna para cada grupo de cargo o maior sal�rio
-- a consulta principal exibe as informa��es do select para quando o cargo e o sal�rio corresponderem a cada item da sub-consulta
-- compara o e1.job_id com e2.job_id e e1.salary com e2.salary
-- s� exibe a linha que ambas as compara��es s�o verdadeiras