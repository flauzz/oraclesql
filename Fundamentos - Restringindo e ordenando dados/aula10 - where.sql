-- aprendendo o uso do where
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 60;

SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = 'IT_PROG';

SELECT first_name, last_name, job_id, department_id, hire_date
FROM employees
WHERE hire_date = '30/01/04';

-- operadores de comparação dentro do where
SELECT last_name, salary
FROM employees
WHERE salary >= 10000;

-- faixa de valores
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 10000 AND 15000;

-- compara um valor uma lista de outros valores
SELECT employee_id, last_name, salary, manager_id, job_id
FROM employees
WHERE job_id IN ('IT_PROG', 'FI_ACCOUNT', 'SA_REP');

-- uso do like
SELECT first_name, last_name, job_id
FROM employees
WHERE first_name LIKE 'Sa%';

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '_a%';

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%a';

-- comparações com o null
SELECT last_name, manager_id
FROM employees
WHERE manager_id = NULL;
-- qlqr comparação desse tipo retorna nada. para resolver:
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

-- operador and
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 5000
AND job_id = 'IT_PROG';

-- operador or
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 5000
OR job_id = 'IT_PROG';

-- operador not
SELECT employee_id, last_name, job_id, salary, manager_id
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'FI_ACCOUNT', 'SA_REP');

-- precedencia com operadores
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP' OR job_id = 'IT_PROG' AND salary > 10000;

SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'SA_REP' OR job_id = 'IT_PROG') AND salary > 10000;

-- order by. default: asc. portanto, não é necessário colocá-lo
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date ASC;

SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC;

-- order by com alias
SELECT employee_id, last_name, salary*12 "Salário Anual"
FROM employees
ORDER BY "Salário Anual";

-- order com referência
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 4;

-- order múltiplo. especificação desc ou asc serve apenas para 1
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;

-- variável de substituição com um & (número)
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_id;
-- variável de substituição com dois && (número)
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &&employee_id;

-- variável de substituição com um & (string ou date)
SELECT employee_id, last_name, job_id, salary*12
FROM employees
WHERE job_id = '&job_id';

-- uso do define
DEFINE employee_id = 101;
DEFINE employee_id;
UNDEFINE employee_id;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_id;