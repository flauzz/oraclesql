--insert pivoting - pivotiando, girando em torno do eixo
--serve para converter uma tabela com dados não relacionais para uma com dados relacionais e inserir esses dados
--apagando e criando a tabela job_salaries:
DROP TABLE job_salaries;

CREATE TABLE job_salaries
(year  NUMBER (4) NOT NULL,
month NUMBER (2) NOT NULL,
it_prog NUMBER (8,2) NOT NULL, --oito dígitos dos quais dois são decimais
sa_man NUMBER (8,2) NOT NULL, 
st_man NUMBER (8,2) NOT NULL);
 
--inserindo linhas na tabela(populando) job_salaries:
INSERT INTO job_salaries (year, month, it_prog, sa_man, st_man)
VALUES (2015, 9, 31300, 61000, 36400);

INSERT INTO job_salaries (year, month, it_prog, sa_man, st_man)
VALUES (2015, 8, 35000, 79500, 37000);

COMMIT; --efetivando a transação
--consultando a tabela job_salaries:
SELECT *
FROM job_salaries;

--apagando e criando a tabela job_sal no formato relacional:
DROP TABLE job_sal;

CREATE TABLE job_sal
(year  NUMBER (4) NOT NULL,
month NUMBER (2) NOT NULL,
job_id VARCHAR2(10) NOT NULL, 
total_salary NUMBER (8,2) NOT NULL);
--consultando a Tabela job_sal: 
SELECT *
FROM job_sal; --ainda está vazia, nada foi inserido

--preenchendo a tabela(populando) job_sal com a tabela job_salaries utilizando o comando insert pivoting (insert inconditional):
INSERT ALL
INTO job_sal VALUES (year, month, 'IT_PROG', it_prog) --selecionando as colunas que serão inseridas
INTO job_sal VALUES (year, month, 'SA_MAN', sa_man)
INTO job_sal VALUES (year, month, 'ST_MAN', st_man)
SELECT *
FROM job_salaries;
  
COMMIT; --comando dml, sempre comitar
  
--consultando a tabela de origem:
SELECT *
FROM job_salaries;

--consultando a tabela de destino:
SELECT *
FROM job_sal;