--consultas hier�rquicas - formatando a sa�da para estrutura em �rvore(tree structure):

--consulta hier�rquica sobre a tabela employees up to down a partir do manager_id is null:
--formatando a estrutura em �rvore utilizando lpad(alinha � direita e preenche a esquerda):
SELECT LEVEL, LPAD(last_name, LENGTH(last_name)+(LEVEL*4)-4,' ') last_name --(dado, tamanho(dado+preenchimento), conte�do)
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;
--varia��o de como obter o mesmo resultado do exemplo anterior(colocando tudo dentro do lpad e fazendo as concatena��es):
SELECT LPAD(LEVEL || '.' || last_name, LENGTH(LEVEL || '.' || last_name)+(LEVEL*4)-4,' ') last_name --(dado, tamanho(dado+preenchimento), conte�do)
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;