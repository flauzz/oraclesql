-- group by. para cada grupo formado ele exibe o que est� no select
SELECT department_id, TO_CHAR(AVG(salary), 'L999G999G999D99') MEDIA_POR_DEPARTAMENTO, COUNT(department_id) QUANT_EM_CADA_DEPART
FROM employees
GROUP BY department_id
ORDER BY MEDIA_POR_DEPARTAMENTO;

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;
-- cl�usula where n�o pode referenciar fun��es de grupo
SELECT department_id, MAX(salary) MAIOR_SALARIO
FROM employees
WHERE MAX(salary) > 10000
GROUP BY department_id;
-- para corrigir utilizamos a cl�usula having
SELECT department_id, MAX(salary) MAIOR_SALARIO
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000
ORDER BY department_id;

SELECT job_id, SUM(salary) TOTAL
FROM employees
WHERE job_id <> 'SA_REP'
GROUP BY job_id
HAVING SUM(salary) > 10000
ORDER BY SUM(salary);

-- aninhamento de fun��es de grupo
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC;

SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;