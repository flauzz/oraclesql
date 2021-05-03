--criando e gerenciando sequences
--� um tipo de objeto utilizado para gera��o de n�meros sequenciais
--o principal uso � para gera��o de n�meros sequenciais para primary keys
--realizar cache de mem�ria pode otimizar a performance
--se sequence cycle, ao atingir o valor m�ximo volta ao in�cio
--se sequence nocycle, ao atingir o valor m�ximo d� erro
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

--consultar sequences que o usu�rio possui, com a vis�o do dicion�rio de dados:
SELECT *
FROM user_sequences;

--pseudo-colunas: nextval e currval
--nextval: retorna o pr�ximo valor da sequence, retorna um valor �nico
--currval: retorna o valor corrente da sequence
--para utilizar o currval � necess�rio ter usado o nextval anteriormente
--nextval:
SELECT employees_seq.NEXTVAL
FROM dual;
--apenas referenciar o nextval quando realmente for utilizar o n�mero,
--pois a partir do momento que fizer a refer�ncia, o pr�ximo valor j� foi alterado
--mesmo executando o rollback o n�mero da sequence n�o volta
--caso isso aconte�a, remova a sequence e a recrie
--currval:
SELECT employees_seq.CURRVAL
FROM dual;

--utilizando a sequence na pr�tica(direto no insert):
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

--utilizando o cache: colocar os valores da sequence em caches de mem�ria proporciona acesso mais r�pido
--pode-se alterar qlqr valor ou par�metro, com exce��o do start with(s� com o drop)
--alter sequence sofre valida��o. exemplo: definir valor m�ximo j� ultrapassado
--somente valores futuros da sequence empregar�o a altera��o feita
ALTER SEQUENCE employees_seq
MAXVALUE 999999
CACHE 20; --passa a usar um cache de 20 n�meros

--buracos na numera��o da sequence:
--podem occorer porq: houve um rollback, sequence definida com cache (mais perigoso) e houve um crash no banco de dados
--ou a sequence � utilizada em outra tabela