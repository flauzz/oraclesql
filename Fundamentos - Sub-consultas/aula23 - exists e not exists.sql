-- utilizando exists e not exists. são alternativas ao uso do in
-- com o exists há uma pequena vantagem em relação a performance. o custo do comando
-- custo: soma de recursos utilizados para a execução do programa, memória, cpu
-- outra vantagem do exists é que não é necessário o tratamentos dos null
-- com o in:
SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id IN (SELECT e.department_id
                          FROM employees e);

-- mesma finalidade utilizando o exists:
-- seleciona todos os departamentos que possuem empregados
SELECT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (SELECT e.department_id
              FROM employees e
              WHERE d.department_id = e.department_id);
              
-- com o not in:
SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id NOT IN (SELECT NVL(e.department_id, 0)
                              FROM employees e);

-- mesma finalidade com o not exists:
-- seleciona todos os departamentos que não possuem empregados
SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (SELECT e.department_id
                  FROM employees e
                  WHERE d.department_id = e.department_id);