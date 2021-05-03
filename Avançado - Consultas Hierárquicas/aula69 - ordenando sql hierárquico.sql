--ordenando sql hier�rquico:
--ordena-se por n�vel, portanto, n�o utilizar a cl�ula order by normal, estraga toda a visualiza��o hir�rquica
--utilizando de maneira errada apenas o order by:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER BY last_name;
--utilizando de maneira correta o order siblings by:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name; --com desc ou asc normalmente
--formatando e ordenando por last name:
SELECT LEVEL, LPAD(last_name, LENGTH(last_name)+(LEVEL*4)-4,' ') last_name --(dado, tamanho(dado+preenchimento), conte�do)
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;

