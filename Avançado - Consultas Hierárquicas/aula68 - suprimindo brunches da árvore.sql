--suprimindo galhos (brunches) da estrutura hier�rquica (�rvore):
--utilizando a cl�usula where n�o se elimina os registros filhos, apenas aqueles que n�o satisfazem a condi��o
--para eliminar os registros que n�o satisfazem e os filhos, condi��o no connect by prior
--utilizando apenas a cl�usula where:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
WHERE employee_id <> 205 --eliminou o 205, mas n�o o filho 206
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

--utilizado a cl�usula connect by prior:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id AND --condi��o que faz a navega��o na hierarquia
                 employee_id <> 205;