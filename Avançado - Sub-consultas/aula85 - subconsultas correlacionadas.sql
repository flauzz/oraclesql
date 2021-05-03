--update utilizando subconsultas correlacionadas:
--atualizar tabelas a partir dos dados de outra tabela(sub-query)
--tendem a ter alto custo, pois para cada linha da tabela ser� executada uma subconsulta
--apagando e recriando a tabela departments_average_temp para realiza��o da pr�tica:
DROP TABLE departments_average_temp;

CREATE table departments_average_temp
(department_id          NUMBER(4),
salary_average          NUMBER(8,2),
commission_pct_average  NUMBER(2,2));
 
--inserindo dados na tabela departments_average_temp a partir de uma query:
INSERT INTO departments_average_temp
SELECT department_id, 0, 0
FROM employees
GROUP BY department_id;

COMMIT; --comando dml, portanto n�o h� commit autom�tico
--consultando a tabela rec�m criada:
SELECT *
FROM departments_average_temp;

--atualizando a tabela rec�m criada com update a partir de uma subconsulta correlacionada:
UPDATE departments_average_temp d
SET (d.salary_average, d.commission_pct_average) = (SELECT ROUND(AVG(e.salary),2), AVG(e.commission_pct)
                                                    FROM   employees e
                                                    WHERE  d.department_id = e.department_id
                                                    GROUP BY e.department_id);
                                                    
COMMIT;
--consultando a tabela rec�m atualizada:
SELECT *
FROM departments_average_temp;