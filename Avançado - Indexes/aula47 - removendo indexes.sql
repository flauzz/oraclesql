--removendo indexes
--ao remover uma tabela, todos os indexes ligados a ela são removidos
--ao remover um index nada acontece com a tabela ou com os outros indexes
--não é possível remover um index que foi criado automaticamente por uma pk ou uk
--o processo de remoção de um index bloqueia todos os comandos dml
--para não bloquear completamente utilizar o ONLINE (bem mais recomendável)
--apagando um index:
DROP INDEX employees_job_id_idx ONLINE;

--consultando os indexes da table a employees
SELECT ix.owner, ix.index_name, ic.column_name, ic.column_position, ix.index_type, ix.uniqueness, ix.status, ix.tablespaces_name, visibility
FROM user_indexes ix --ou all_indexes/ dba_indexes que apresentam uma coluna a mais (owner)
JOIN user_ind_columns ic ON (ix.index_name = ic.index_name AND ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position;

--recriando o index (non unique, b-tree e simples):
CREATE INDEX employees_job_id_idx
ON employees(job_id);