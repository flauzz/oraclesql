-- produto cartesiano: cada linha de uma tabela combinada com cada linha da outra tabela
-- cross join: combina��o muitos para muitos
SELECT last_name, department_name
FROM employees
CROSS JOIN departments;