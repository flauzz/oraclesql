-- criando e gerenciando views
-- view: representação lógica de um select baseado em uma ou mais tabela e visões
-- é um select armazenado em um dicionário de dados com um nome
-- vantagens: restringe o acesso ao dados,
-- podem ser selecionadas apenas as colunas que são permitidas, dando o privilégio para view e não para tabela
-- torna simples consultas complexas. salva-se selects complexos para q não seja mais necessário montá-los
-- proporciona independência dos dados originais
-- por padrão noforce, para não criar uma view com um select errado
-- criando uma view:
CREATE OR REPLACE VIEW vemployeesdept60
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 60;
--ao criar uma view o oracle armazena o select no dicionário de dados
DESC vemployeesdept60; --visualiza e estrutura da view, parecido com a tabela

SELECT *
FROM vemployeesdept60;
--oracle vai no dicionário de dados, procura a view e executa o select e retorna o resultado

CREATE OR REPLACE VIEW vemployeesdept60
AS SELECT employee_id, first_name, last_name, department_id, salary, commission_pct
FROM employees
WHERE department_id = 60;

DESC vemployeesdept60;

-- criando uma visão complexa:
CREATE OR REPLACE VIEW vdepartments_total
(department_id, department_name, minsal, maxsal, avgsal) --renomeando o nome das colunas na view
AS SELECT e.department_id, d.department_name, MIN(e.salary), MAX(e.salary), AVG(e.salary)
FROM employees e JOIN departments d
                 ON (e.department_id = d.department_id)
GROUP BY e.department_id, department_name;

SELECT *
FROM vdepartments_total;

--regras para usar delete em uma view:
--não pode haver funções de grupo, cláusla group by, distinct e pseudo-coluna rownum
--regras para usar update em uma view:
--não pode haver funções de grupo, cláusla group by, distinct, pseudo-coluna rownum e colunas definidas por expressões
--regras para usar insert em uma view:
--não pode haver funções de grupo, cláusla group by, distinct, pseudo-coluna rownum, colunas definidas por expressões
--e colunas not null na tabela base que não estejam no select da visão

--check option: cria uma validação a ser checada antes de adicionar algo
--por padrão a cláusla where apenas indica que dados pegarei
--mas usando check option ela se torna uma validação
--ou seja, no caso posterior, não dá mais para adicionar um funcionário com department_id diferente de 100
CREATE OR REPLACE VIEW vemployeesdept100
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 100
WITH CHECK OPTION CONSTRAINT vemployeesdept100_ck;

--with read only: possível criar uma view que não permite operações dml de maneira alguma
CREATE OR REPLACE VIEW vemployeesdept20
AS SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 20
WITH READ ONLY;

--removendo uma view: ao remover uma view os dados da tabela de origem permancem
DROP VIEW vemployeesdept20;