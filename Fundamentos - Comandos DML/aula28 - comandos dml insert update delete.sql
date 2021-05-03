-- comandos dml, data manipulation language: insert, update, delete
-- ao executar um comando dml inicia-se uma transa��o
-- insert: adiciona linha
-- update: atualiza/altera linhas
-- delete: apaga linhas
-- primeiro exemplo de insert:
DESCRIBE departments; -- estrutura da tabela departments

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Project Management', 103, 1400);
-- ao n�o especificar as colunas, deve ser respeitada a ordem original da tabela
-- inserindo null pelo m�todo expl�cito
INSERT INTO departments
VALUES (290, 'Data Science', NULL, NULL);
-- especificando apenas algumas colunas. automaticamente as colunas n�o especificadas recebem o valor null
-- inserindo null pelo m�doto impl�cito
INSERT INTO departments(department_id, department_name)
VALUES (300, 'Business Intelligent');
-- ao fazer commit efetiva-se a transa��o e n�o se volta atr�s
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

-- inserindo valores especiais em values, com fun��es:
DESC employees;
-- sysdate como fun��o
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, 
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (207, 'Daniel', 'Rock', 'DROCK', '525.342.237', SYSDATE, 'IT_PROG', 7000, NULL, 103, 60);
-- to_date como fun��o
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, 
                      hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (208, 'Vito', 'Corleone', 'VCCRL', '525.342.237', TO_DATE('11/02/2020', 'DD/MM/YYYY'),
        'IT_PROG', 20000, NULL, 103, 60);

SELECT *
FROM employees
ORDER BY employee_id;
-- outras se��es, usu�rios do banco de dados ainda n�o ver�o os novos empregados inseridos
-- a altera��o s� � passada adiante (efetivada) ap�s o commit
COMMIT;

-- vari�veis de substitui��o com &:
-- ao executar o comando pede-se os respectivos valores em um prompt
INSERT INTO departments(department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location);

SELECT *
FROM departments
ORDER BY department_id;

COMMIT;

-- inserindo linhas a partir de uma sub-consulta:
-- n�o utiliza-se a cl�usula values ap�s a sub-consulta
-- insere todas as linhas do resultado desse select
-- o n�mero de consulta entre eles deve se coincidir
DROP TABLE sales_reps; --para garantir que n�o h� nenhuma tabela com esse nome. apaga qlqr tabela existente com esse mesmo nome
-- create table usado para criar uma tabela. monta-se a estrutura completa da tabela
CREATE TABLE sales_reps
(id NUMBER(6,0),
name VARCHAR2(20),
salary NUMBER(8,2),
commission_pct NUMBER(2,2));

DESC sales_reps;
-- inserir� na tabela criada o resultado do select
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id = 'SA_REP';

SELECT *
FROM sales_reps;

COMMIT;

-- update: modificando linhas existentes na tabela
-- cl�usula where diz onde ser�o feitas tais atualiza��es. sem ela todas as linhas ser�o alteradas
-- exemplo a seguir com esquecimento da cl�usula where e aumentando o sal�rio de todos os funcion�rios:
UPDATE employees
SET salary = salary*1.2;
-- cl�usula rolplback usada para desfazer uma transa��o equivocada
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
-- cl�usula where diz onde ser�o feitas as exclus�es. sem ela todas as linhas ser�o exclu�das
DELETE FROM countries
WHERE country_name = 'Nigeria';

SELECT *
FROM countries;

ROLLBACK;

-- transa��es de bancos de dados
-- consistem em: conjuntos de DML - insert, update, delete, DDL - create, alter, drop, DCL - comandos de controle
-- transa��o come�a quando o primeiro comando dml � executado
-- termina quando � executado o commit ou rollback
-- termina com comandos ddl e dcl por executarem o commit automaticamente
-- termina quando encerra a sess�o no sql developer (avisa q h� transa��o pendente) ou sql plus (executa o commit sem perguntar e fecha)
-- termina com o crash do sistema (queda do sistema operacional, queda do servidor) - sofre rollback nesses casos

-- cria��o de savepoints - cria��o de marcas na transa��o
-- ao executar um rollback � apagado/ignorado tudo que veio depois do savepoint espec�fico
-- ou seja, desfaz a transa��o at� um marcador
-- exemplo pr�tico:
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

-- ao iniciar uma transa��o, at� que se execute o commit, ningu�m poder� alterar a mesma linha, pois ficar� em estado locked
-- as outras sess�es ficar�o em estado wait, esperando o commit ou rollback
-- executado o commit s� se altera com um backup do banco de dados ou com programa��o espec�fica
-- rolback a n�vel de comando acontece quando algo impede que um comando dentro de uma transa��o seja executado
-- locked n�o impede select
-- select n�o gera locked
-- se o select tiver a cl�usula FOR UPDATE OF, gera sim um locked:
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