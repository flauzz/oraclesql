--criando e gerenciando sequences
--é um tipo de objeto utilizado para geração de números sequenciais
--o principal uso é para geração de números sequenciais para primary keys
--realizar cache de memória pode otimizar a performance
--se sequence cycle, ao atingir o valor máximo volta ao início
--se sequence nocycle, ao atingir o valor máximo dá erro
--deve existir uma sequence para cada tabela
--criando uma sequence:
SELECT MAX(employee_id)
FROM employees;

DROP SEQUENCE employees_seq;

CREATE SEQUENCE employees_seq
START WITH 208
INCREMENT BY 1
NOMAXVALUE
NOCACHE
NOCYCLE;

--consultar sequences que o usuário possui, com a visão do dicionário de dados:
SELECT *
FROM user_sequences;

--pseudo-colunas: nextval e currval
--nextval: retorna o próximo valor da sequence, retorna um valor único
--currval: retorna o valor corrente da sequence
--para utilizar o currval é necessário ter usado o nextval anteriormente
--nextval:
SELECT employees_seq.NEXTVAL
FROM dual;
--apenas referenciar o nextval quando realmente for utilizar o número,
--pois a partir do momento que fizer a referência, o próximo valor já foi alterado
--mesmo executando o rollback o número da sequence não volta
--caso isso aconteça, remova a sequence e a recrie
--currval:
SELECT employees_seq.CURRVAL
FROM dual;

--utilizando a sequence na prática(direto no insert):
INSERT INTO employees
        (employee_id, first_name, last_name, email, phone_number, hire_date,
        job_id, salary, commission_pct, manager_id, department_id)
VALUES  (employees_seq.NEXTVAL, 'Paul', 'Simon', 'PSIMO', '525.342.237',
        TO_DATE('12/02/2020', 'DD/MM/YYYY'), 'IT_PROG', 15000, NULL, 103, 60);
        
DELETE employees
WHERE employee_id = 209;

SELECT *
FROM employees
ORDER BY employee_id DESC;

COMMIT;

--utilizando o cache: colocar os valores da sequence em caches de memória proporciona acesso mais rápido
--pode-se alterar qlqr valor ou parâmetro, com exceção do start with(só com o drop)
--alter sequence sofre validação. exemplo: definir valor máximo já ultrapassado
--somente valores futuros da sequence empregarão a alteração feita
ALTER SEQUENCE employees_seq
MAXVALUE 999999
CACHE 20; --passa a usar um cache de 20 números

--buracos na numeração da sequence:
--podem occorer porq: houve um rollback, sequence definida com cache (mais perigoso) e houve um crash no banco de dados
--ou a sequence é utilizada em outra tabela