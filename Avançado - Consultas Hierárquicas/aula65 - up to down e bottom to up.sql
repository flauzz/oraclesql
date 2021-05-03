--consultas hierárquicas up to down e bottom to up:
--consultas hierárquicas sobre a tabela employees up to down a partir do employee_id = 103:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 103
CONNECT BY PRIOR employee_id = manager_id;
--mesmo exemplo anterior com prior do outro lado:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 103
CONNECT BY manager_id = PRIOR employee_id;

--consultas hierárquicas sobre a tabela employees bottom to up a partir do employee_id = 103:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 103
CONNECT BY PRIOR manager_id = employee_id;
--mesmo exemplo anterior com prior do outro lado:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 103
CONNECT BY employee_id = PRIOR manager_id;

--consultas hierárquicas sobre a tabela employees up to down a partir do manager_id is null(empregado sem gerente - presidente):
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;
--mesmo exemplo anterior com prior do outro lado:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY manager_id = PRIOR employee_id;

--consultas hierárquicas sobre a tabela employees bottom to up a partir do manager_id is null(empregado sem gerente - presidente):
SELECT     LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM       employees
START WITH manager_id IS NULL
CONNECT BY PRIOR manager_id = employee_id;
--mesmo exemplo anterior com prior do outro lado:
SELECT     LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM       employees
START WITH manager_id IS NULL
CONNECT BY employee_id = PRIOR manager_id;