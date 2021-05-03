--consultas hierárquicas - formatando a saída para estrutura em árvore(tree structure):

--consulta hierárquica sobre a tabela employees up to down a partir do manager_id is null:
--formatando a estrutura em árvore utilizando lpad(alinha à direita e preenche a esquerda):
SELECT LEVEL, LPAD(last_name, LENGTH(last_name)+(LEVEL*4)-4,' ') last_name --(dado, tamanho(dado+preenchimento), conteúdo)
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;
--variação de como obter o mesmo resultado do exemplo anterior(colocando tudo dentro do lpad e fazendo as concatenações):
SELECT LPAD(LEVEL || '.' || last_name, LENGTH(LEVEL || '.' || last_name)+(LEVEL*4)-4,' ') last_name --(dado, tamanho(dado+preenchimento), conteúdo)
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;