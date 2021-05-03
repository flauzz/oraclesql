--consultas hierárquicas: pode-se navegar pela hierarquia
--são realizadas a partir de uma estrutura em árvore (tree structure)
--tree structure - surgem a partir de um relacionamento entre linhas(registros) da msm tabela
--ou seja, uma coluna possui uma foreign key que aponta para uma primary key em outra coluna da própria tabela
--exemplo, relacionamento entra a coluna employee_id(pk) e manager_id(fk), o código do gerente do empregado é o id de outro empregado
--nessa hierarquia a mãe é o pk e o filho fk
--quando o level é 1, root
--consultando a estrutura da tabela employees e visualizando os dados:
DESC employees

SELECT *
FROM employees;

--consulta hierárquica sobre a tabela employees up to down a partir de manager_id is null:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id --level mostra o nível hierárquico
FROM employees
START WITH manager_id IS NULL --a partir de q posição é para navegar, qual será a raiz (root)
CONNECT BY PRIOR employee_id = manager_id; --navegação de cima pra baixo ou de baixo pra cima
--logo após o prior determina o sentido: employee_id é a mãe, portanto, sentido da mãe para os filhos, up to down