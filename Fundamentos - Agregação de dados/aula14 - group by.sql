-- group by. para cada grupo formado ele exibe o que está no select
SELECT department_id, TO_CHAR(AVG(salary), 'L999G999G999D99') MEDIA_POR_DEPARTAMENTO, COUNT(department_id) QUANT_EM_CADA_DEPART
FROM employees
GROUP BY department_id
ORDER BY MEDIA_POR_DEPARTAMENTO;

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;
-- cláusula where não pode referenciar funções de grupo
SELECT department_id, MAX(salary) MAIOR_SALARIO
FROM employees
WHERE MAX(salary) > 10000
GROUP BY department_id;
-- para corrigir utilizamos a cláusula having
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

-- aninhamento de funções de grupo
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC;

SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;