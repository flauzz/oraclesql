--delete utilizando subconsultas correlacionadas:
--remover linhas de tabelas a partir dos dados de outra tabela(sub-query)
--para cada linha da tabela será realizada a subconsulta
--consultando a tabela departments_average_temp:
SELECT *
FROM departments_average_temp;

SELECT d.department_id, d.department_name
FROM departments d
JOIN locations l ON (d.location_id = l.location_id)
WHERE country_id = 'US';

--delete a partir de uma subconsulta correlacionada:
DELETE FROM departments_average_temp d
WHERE d.department_id IN (SELECT d.department_id
                          FROM departments d
                          JOIN locations l ON (d.location_id = l.location_id)
                          WHERE country_id = 'US');
                            
COMMIT;

--consultando a tabela departments_average_temp para verificar o que não foi deletado:
SELECT *
FROM departments_average_temp;