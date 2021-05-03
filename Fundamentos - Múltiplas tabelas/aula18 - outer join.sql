-- outer join: condi��o de liga��o pode n�o ter correspondente em uma das tabelas
-- left outer join: mostra a tabela da esquerda independente de haver correspond�ncia na tabela da direita
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_id;
-- order by asc: o null sempre � o �ltimo
-- empregados sem departamento(null) n�o seriam exibidos no inner join, mas ser�o com left outer join
-- a linha 107 (Kimberely) n�o � exibida no inner join:
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_id;
-- exibe empregados sem departamento

-- right outer join: fixa o da direita e mostra todos da esquerda independente da condi��o
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_id;
-- a parir da linha 107 aparecem os null, pois existem departamentos, que est�o � direita, sem empregados
-- exibe departamentos sem empregados

-- full outer join: mostra tudo independente da condi��o
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_id;