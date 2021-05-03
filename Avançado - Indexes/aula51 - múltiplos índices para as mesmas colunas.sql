--múltiplos indexes para as mesmas colunas
--é possível criar vários indexes para a mesma coluno se os indexes forem de tipos diferentes
--mas para que funcione, o status dos demais deve ser invisible
--recurso utilizado para comparações de performance entre os indexes(evita criação e remoção de index)

CREATE INDEX employees_job_id_idx --index non unique e b-tree
ON employees(job_id);

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

--tentando criar outro index para a mesma coluna:
CREATE BITMAP INDEX employees_job_id_idx2
ON employees(job_id);  --error

--para resolver o problema basta tornar o outro index com status invisible e só então criar o segundo index para a mesma coluna
ALTER INDEX employees_job_id_idx INVISIBLE;

CREATE BITMAP INDEX employees_job_id_idx2
ON employees(job_id);  

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

--consultando os indexes existentes:
SELECT ix.index_name,
       ic.column_name,
       ic.column_position,
       ix.index_type,
       ix.uniqueness,
       ix.status,
       ix.tablespace_name,
       visibility
FROM    user_indexes ix
JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 

--invertendo as visibilidades:
ALTER INDEX employees_job_id_idx2 INVISIBLE;

ALTER INDEX employees_job_id_idx VISIBLE;