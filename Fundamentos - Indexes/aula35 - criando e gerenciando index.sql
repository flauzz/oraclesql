--criando e gerenciando index
--� uma estrutura/objeto do oracle separado da tabela
--serve para melhorar a performance de uma recupera��o de linhas em uma consulta
--para eliminar a full scan desnecess�ria
--index s�o criados de forma autom�tica na defini��o de uma constraint primary key ou unique
--normalmente criado index para foreign keys manualmente
DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;

--select sem index:
SELECT *
FROM employees
WHERE last_name = 'Himuro';
--apertar f10 para mostrar o plano de explica��o/execu��o
--acesso foi pela tabela employees lendo a tabela completamente, full, com o filtro himuro, totalizando um custo de 3
--criando um index:
CREATE INDEX employees_last_name_idx
ON employees(last_name);
--executar o select anterior a comparar/analisar o custo e o caminho
--procura o q foi pedido pelo index, no caso apenas no last_name ao inv�s de ler a tabela inteira
--e pra cada last_name igual ao solicitado ele acessa a tabela pelo rowid (endere�o l�gico da linha)
--diminuir o custo do comando melhora a performance
--custo: uso de cpu, mem�ria, leitura e grava��o em disco (recursos)

--criando index composto:
CREATE INDEX employees_last_name_first_name_idx
ON employees(last_name, first_name);

SELECT *
FROM employees
WHERE last_name = 'Himuro'
AND   first_name = 'Guy';

--reconstruindo e reorganizando um index (para que a performance seja mantida depois de muitas altera��es nas tabelas):
ALTER INDEX employees_last_name_first_name_idx REBUILD;

--consultando os index do usu�rio:
--user_indexes: informa��es sobre os indexes do meu usu�rio
--user_ind_columns: colunas que comp�em os indices do meu usu�rio
DESC user_indexes;

SELECT ix.index_name, ic.column_position, ic.column_name, ix.index_type, ix.uniqueness, ix.status
FROM user_indexes ix
JOIN user_ind_columns ic ON  (ix.index_name = ic.index_name)
                         AND (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position;

--removendo um index:
DROP INDEX employees_last_name_idx;
DROP INDEX employees_last_name_first_name_idx;