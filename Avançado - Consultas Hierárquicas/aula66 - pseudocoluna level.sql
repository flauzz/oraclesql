--consultas hierárquicas utilizando a pseudocoluna level:
--consulta hierárquica sobre a tabela employees up to down a partir do manager_id is null:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

--consulta hierárquica sobre a tabela employees up to down a partir do manager_id is null:
--restringido somente ao leve=2:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
WHERE LEVEL=2 --só exibirá os empregados de nível 2
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

--consulta hierárquica sobre a tabela employees up to down a partir do manager_id is null:
--restringindo somente o level<>2:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
WHERE LEVEL <> 2 --não exclui os filhos nem a mãe, apenas ele mesmo
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;