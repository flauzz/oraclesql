--consultas hier�rquicas: pode-se navegar pela hierarquia
--s�o realizadas a partir de uma estrutura em �rvore (tree structure)
--tree structure - surgem a partir de um relacionamento entre linhas(registros) da msm tabela
--ou seja, uma coluna possui uma foreign key que aponta para uma primary key em outra coluna da pr�pria tabela
--exemplo, relacionamento entra a coluna employee_id(pk) e manager_id(fk), o c�digo do gerente do empregado � o id de outro empregado
--nessa hierarquia a m�e � o pk e o filho fk
--quando o level � 1, root
--consultando a estrutura da tabela employees e visualizando os dados:
DESC employees

SELECT *
FROM employees;

--consulta hier�rquica sobre a tabela employees up to down a partir de manager_id is null:
SELECT LEVEL, employee_id, first_name, last_name, job_id, manager_id --level mostra o n�vel hier�rquico
FROM employees
START WITH manager_id IS NULL --a partir de q posi��o � para navegar, qual ser� a raiz (root)
CONNECT BY PRIOR employee_id = manager_id; --navega��o de cima pra baixo ou de baixo pra cima
--logo ap�s o prior determina o sentido: employee_id � a m�e, portanto, sentido da m�e para os filhos, up to down