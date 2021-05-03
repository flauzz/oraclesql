-- comandos dml, data manipulation language: insert, update, delete
-- ao executar um comando dml inicia-se uma transação
-- insert: adiciona linha
-- update: atualiza/altera linhas
-- delete: apaga linhas
-- primeiro exemplo de insert:
DESCRIBE departments; -- estrutura da tabela departments

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Project Management', 103, 1400);
-- ao não especificar as colunas, deve ser respeitada a ordem original da tabela
-- inserindo null pelo método explícito
INSERT INTO departments
VALUES (290, 'Data Science', NULL, NULL);
-- especificando apenas algumas colunas. automaticamente as colunas não especificadas recebem o valor null
-- inserindo null pelo médoto implícito
INSERT INTO departments(department_id, department_name)
VALUES (300, 'Business Intelligent');
-- ao fazer commit efetiva-se a transação e não se volta atrás
COMMIT;
-- mais exemplos de insert:
INSERT INTO departments
VALUES (310, 'Inovation', NULL, NULL);

INSERT INTO departments(department_id, department_name)
VALUES (320, 'IOT');

SELECT *
FROM departments
ORDER BY department_id;

COMMIT;

-- inserindo valores especiais em values, com funções:
DESC employees;
-- sysdate como função
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, 
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (207, 'Daniel', 'Rock', 'DROCK', '525.342.237', SYSDATE, 'IT_PROG', 7000, NULL, 103, 60);
-- to_date como função
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, 
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (208, 'Vito', 'Corleone', 'VCCRL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'),
        'IT_PROG', 20000, NULL, 103, 60);

SELECT *
FROM employees
ORDER BY employee_id;
-- outras seções, usuários do banco de dados ainda não verão os novos empregados inseridos
-- a alteração só é passada adiante (efetivada) após o commit
COMMIT;

-- variáveis de substituição com &:
-- ao executar o comando pede-se os respectivos valores em um prompt
INSERT INTO departments(department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location);

SELECT *
FROM departments
ORDER BY department_id;

COMMIT;

-- inserindo linhas a partir de uma sub-consulta:
-- não utiliza-se a cláusula values após a sub-consulta
-- insere todas as linhas do resultado desse select
-- o número de consulta entre eles deve se coincidir
DROP TABLE sales_reps; --para garantir que não há nenhuma tabela com esse nome. apaga qlqr tabela existente com esse mesmo nome
-- create table usado para criar uma tabela. monta-se a estrutura completa da tabela
CREATE TABLE sales_reps
(id NUMBER(6,0),
name VARCHAR2(20),
salary NUMBER(8,2),
commission_pct NUMBER(2,2));

DESC sales_reps;
-- inserirá na tabela criada o resultado do select
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id = 'SA_REP';

SELECT *
FROM sales_reps;

COMMIT;

-- update: modificando linhas existentes na tabela
-- cláusula where diz onde serão feitas tais atualizações. sem ela todas as linhas serão alteradas
-- exemplo a seguir com esquecimento da cláusula where e aumentando o salário de todos os funcionários:
UPDATE employees
SET salary = salary*1.2;
-- cláusula rolplback usada para desfazer uma transação equivocada
ROLLBACK;
-- exemplo anterior corrigido:
UPDATE employees
SET salary = salary*1.2
WHERE last_name = 'King';

COMMIT;

SELECT *
FROM employees
WHERE last_name = 'King';

-- utilizando o comendo update com sub-consultas:
-- sub-consultas com igual devem retornar apenas uma linha
UPDATE employees
SET job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 141),
    salary = (SELECT salary
              FROM employees
              WHERE employee_id = 141)
WHERE employee_id = 140;

COMMIT;
              
SELECT *
FROM employees
WHERE employee_id = 141 OR employee_id = 140;

-- delete: apagando linhas existentes na tabela
-- cláusula where diz onde serão feitas as exclusões. sem ela todas as linhas serão excluídas
DELETE FROM countries
WHERE country_name = 'Nigeria';

SELECT *
FROM countries;

ROLLBACK;

-- transações de bancos de dados
-- consistem em: conjuntos de DML - insert, update, delete, DDL - create, alter, drop, DCL - comandos de controle
-- transação começa quando o primeiro comando dml é executado
-- termina quando é executado o commit ou rollback
-- termina com comandos ddl e dcl por executarem o commit automaticamente
-- termina quando encerra a sessão no sql developer (avisa q há transação pendente) ou sql plus (executa o commit sem perguntar e fecha)
-- termina com o crash do sistema (queda do sistema operacional, queda do servidor) - sofre rollback nesses casos

-- criação de savepoints - criação de marcas na transação
-- ao executar um rollback é apagado/ignorado tudo que veio depois do savepoint específico
-- ou seja, desfaz a transação até um marcador
-- exemplo prático:
DELETE FROM employees
WHERE employee_id IN (207, 208);

COMMIT;

DESC employees;

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number,
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (207, 'Rock', 'Balboa', 'DROCK', '525.342.237', SYSDATE, 'IT_PROG', 7000, NULL, 103, 60);

SAVEPOINT A;

SELECT *
FROM employees
ORDER BY employee_id;

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number,
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (208, 'Vito', 'Corleone', 'VCCRL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'),
        'IT_PROG', 20000, NULL, 103, 60);
        
ROLLBACK TO SAVEPOINT A;

COMMIT;

-- ao iniciar uma transação, até que se execute o commit, ninguém poderá alterar a mesma linha, pois ficará em estado locked
-- as outras sessões ficarão em estado wait, esperando o commit ou rollback
-- executado o commit só se altera com um backup do banco de dados ou com programação específica
-- rolback a nível de comando acontece quando algo impede que um comando dentro de uma transação seja executado
-- locked não impede select
-- select não gera locked
-- se o select tiver a cláusula FOR UPDATE OF, gera sim um locked:
SELECT employee_id, salary, commission_pct, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE
ORDER BY employee_id;
--as linhas recuperadas no select anterior geraram locked. para liberar o locked - commit

COMMIT;

-- especificando o for update of garante o locked apenas em uma das tabelas consultadas
SELECT e.employee_id, e.salary, e.commission_pct
FROM employees e JOIN departments d
USING (department_id)
WHERE job_id = 'ST_CLERK'
AND location_id = 1500
FOR UPDATE OF e.salary
ORDER BY e.employee_id;