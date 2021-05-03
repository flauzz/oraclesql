-- equijoin com sintaxe oracle:
SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- com várias colunas na sintaxe oracle:
SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM employees e, jobs j, departments d, locations l
WHERE e.job_id = j.job_id AND e.department_id = d.department_id AND d.location_id = l.location_id
ORDER BY e.employee_id;

-- mesmo exemplo anterior com condições adicionais:
SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM employees e, jobs j, departments d, locations l
WHERE e.job_id = j.job_id AND e.department_id = d.department_id AND d.location_id = l.location_id AND e.salary >= 1000
ORDER BY e.employee_id;

--nonequijoins com sintaxe oracle
SELECT e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM employees e, job_grades j
WHERE NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY e.salary;

-- outer join com sintaxe oracle. (+) ao lado (após) da coluna que pode ter valor nulo
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id
ORDER BY d.department_id;
-- em ansi 1999 seria o right outer join

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
ORDER BY d.department_id;
-- em ansi 1999 seria o left outer join

-- self-join com sintaxe oracle:
SELECT empregado.employee_id "ID Empregado", empregado.last_name "Sobrenome Empregado",
        gerente.employee_id "ID Gerente", gerente.last_name "Sobrenome Gerente"
FROM employees empregado, employees gerente
WHERE (empregado.manager_id = gerente.employee_id(+))
ORDER BY empregado.employee_id;
-- exite empregado que pode não ter gerente, por isso o (+) em gerente. gerente pode ter valor nulo

-- produto cartesiano na sintaxe oracle:
SELECT e.last_name, d.department_name
FROM employees e, departments d;
-- para corrigir o produto cartesiano basta empregar a condição de ligação na cláusa where. cargo de cada empregado
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;