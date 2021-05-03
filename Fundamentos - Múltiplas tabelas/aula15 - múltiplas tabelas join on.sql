-- m�ltiplas tabelas
-- com join m�ltiplas tabelas tonam-se acess�veis
-- nome das tabelas como prefixo dos nomes das colunas separados por ponto: evitar ambiguidade
SELECT employees.employee_id, employees.last_name, employees.department_id, departments.department_name
FROM employees JOIN departments
ON employees.department_id = departments.department_id;

-- definindo alias de tabela para simplificar e diminuir o c�digo
-- alias de tabela sempre definir no from
-- maneira num 1 de usar o join
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;
-- join com on, exemplo 2
SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
-- como os department_id s�o iguais nas duas tabelas, basta apagar uma delas para n�o ser exibida:
SELECT e.employee_id, e.last_name, e.department_id, d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

-- com o natural join fica impl�cito que a uni�o entre tabelas se dar� onde os nomes de colunas forem iguais (location_id)
-- n�o � mto comum utilizar dessa forma
-- maneira num 2 de usar o join
SELECT department_id, department_name, location_id, city
FROM departments
NATURAL JOIN locations;

-- maneira num 3 de usar o join. as tabelas de nomes iguais n�o devem ter o prfixo
-- tbm � menos utilizada que a cl�usula join-on
SELECT e.employee_id, department_id, d.location_id, d.department_name
FROM employees e JOIN departments d
USING (department_id);

-- join-on com v�rias tabelas
SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
ORDER BY e.employee_id;

-- join com condi��o adicional, where
-- condi��es de liga��o na cl�usula on
-- condi�oes relacionais (adicionais) na cl�usula where
-- melhor maneira
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE (e.salary BETWEEN 10000 AND 15000);

-- segunda op��o (menos usada) para condi��es adicionais:
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND (e.salary BETWEEN 10000 AND 15000);

-- self-join: um join com a pr�pria tabela, com ela msm. subdivis�es
SELECT empregado.employee_id "ID Empregado", empregado.last_name "Sobrenome Empregado",
        gerente.employee_id "ID Gerente", gerente.last_name "Sobrenome Gerente"
FROM employees empregado JOIN employees gerente
ON (empregado.manager_id = gerente.employee_id)
ORDER BY empregado.employee_id;

SELECT * FROM employees;