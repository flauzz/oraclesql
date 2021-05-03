-- funções de grupo
--avg e sum
SELECT TO_CHAR(AVG(salary), 'L999G999G999D99') MEDIA, TO_CHAR(SUM(salary), 'L999G999G999D99') SOMATORIO
FROM employees;

-- min e max
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

SELECT MIN(salary), MAX(salary)
FROM employees;

-- função count
SELECT COUNT(*)
FROM employees;

SELECT COUNT(commission_pct), COUNT(*)
FROM employees;

SELECT COUNT(NVL(commission_pct,0))
FROM employees;
-- com linhas repetidas
SELECT COUNT(department_id)
FROM employees;
-- sem linhas repetidas
SELECT COUNT(DISTINCT department_id)
FROM employees;
-- valor distorcido por ignorar os null
SELECT AVG(commission_pct)
FROM employees;
-- valor correto por considerar os null
SELECT AVG(NVL(commission_pct, 0))
FROM employees;