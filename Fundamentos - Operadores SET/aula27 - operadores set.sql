-- operadores set. conjunto de linhas retornadas por cada select
-- operadores: union/union all, intersect e minus
-- devem ser o msm n�mero de colunas, dados
-- usar order by somente para o resultado final e referenciando o nome das colunas da primeira consulta
-- com exce��o do union all todos os outros eliminam as linhas duplicadas automaticamente
-- os nomes das colunas da primeira consulta s�o as q aparecer�o no resultado
-- pode haver v�rios operadores set com v�rios select
-- union: traz os dois resultados eliminando apenas as linhas duplicadas
-- utilizando operador union:
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE department_id IN (60, 90, 100)
UNION
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY employee_id;
-- confirmando o resultado anterior
SELECT DISTINCT(department_id), job_id
FROM employees
ORDER BY department_id DESC;

-- union all: traz os dois resultados sem eliminar as linhas duplicadas. sendo assim mais r�pido
-- utilizando o operador unioin all. Ex01:
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE department_id IN (60, 90, 100)
UNION ALL
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY employee_id;
--Ex02:
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE job_id = 'IT_PROG'
UNION ALL
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE department_id = 60
ORDER BY employee_id;

-- intersect: retorna a interse��o entre as duas colunas eliminando linhas duplicadas:
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE department_id IN (60, 90, 100)
INTERSECT
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY employee_id;

-- minus: retorna itens do primeiro select q n�o est�o no segundo select eliminando linhas duplicadas
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE department_id IN (60, 90, 100)
MINUS
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE job_id = 'IT_PROG'
INTERSECT
SELECT employee_id, job_id, hire_date, salary
FROM employees
WHERE salary > 10000
ORDER BY employee_id;