-- nonequijoins, quando a ligação entre tabelas não é uma igualdade
-- para remover uma tabela: drop table 'nome da tabela'
DROP TABLE job_grades;
-- para criar uma tabela:
-- criando a tabela job_grades:
CREATE TABLE JOB_GRADES (
grade_level VARCHAR2(2) NOT NULL,
lowest_sal NUMBER (11,2),
highest_sal NUMBER (11,2),
CONSTRAINT job_grades_pk PRIMARY KEY (grade_level));
-- os nomes entre parênteses definem as colunas
-- para inserir as linhas usa-se insert into
-- inserindo linhas na tabela job_grades:
INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 25999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);
-- para efetivar a transição executar o commit
COMMIT;

SELECT *
FROM job_grades;

-- realizando o nonequijoin:
SELECT e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM employees e JOIN job_grades j
ON NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY e.salary;