--suprimindo galhos (brunches) da estrutura hierárquica (árvore):
--utilizando a cláusula where não se elimina os registros filhos, apenas aqueles que não satisfazem a condição
--para eliminar os registros que não satisfazem e os filhos, condição no connect by prior
--utilizando apenas a cláusula where:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
WHERE employee_id <> 205 --eliminou o 205, mas não o filho 206
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

--utilizado a cláusula connect by prior:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id AND --condição que faz a navegação na hierarquia
                 employee_id <> 205;