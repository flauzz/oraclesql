-- tipos de conversão. fm elimina os zeros à esquerda e os espaçoes desnecessários
SELECT last_name, TO_CHAR(hire_date, 'DD/MM/YYY HH24:MI:SS') DT_ADMISSAO
FROM employees;

SELECT sysdate, TO_CHAR(sysdate, 'DD/MM/YYY HH24:MI:SS') DATA
FROM dual;

SELECT last_name, TO_CHAR(hire_date, 'DD, "de" MONTH "de" YYYY') DT_ADMISSAO
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'FMDD, "de" MONTH "de" YYYY') DT_ADMISSAO
FROM employees;

SELECT first_name, last_name, TO_CHAR(salary, 'L999G999G999D99') SALARIO
FROM employees;

SELECT TO_NUMBER('12000,50')
FROM dual;

SELECT TO_DATE('06/02/2020', 'DD/MM/YYYY') DATA
FROM dual;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = TO_DATE('17/06/2003','DD/MM/YYYY');

-- funções aninhadas
SELECT first_name, last_name,
ROUND(MONTHS_BETWEEN(sysdate, hire_date),0)
FROM employees
WHERE hire_date = TO_DATE('17/06/2003','DD/MM/YYYY');

-- função nvl. substitui o null
SELECT last_name, salary, NVL(commission_pct, 0), salary*12 SALARIO_ANUAL,
(salary*12)+(salary*12*NVL(commission_pct, 0)) REMUNERECAO_ANUAL
FROM employees;

-- função coalesce. executa somente expressão sem null
SELECT COALESCE(NULL, NULL, 'Expressão 3'), COALESCE(NULL, 'Expressão 2', 'Expressão 3'),
COALESCE('Expressão 1','Expressão 2','Expressão 3')
FROM dual;

SELECT last_name, employee_id, commission_pct, manager_id,
COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id), 'Sem percentual de comissão e sem gerente') RESULTADO
FROM employees;

-- função nvl2. diferente de null, 10. igual a null, 0
SELECT last_name, salary, commission_pct,
NVL2(commission_pct, 10, 0) PERCENTUAL_ALTERADO
FROM employees;

-- função nullif. se argumentos igual, retorna null. se diferentes, retorna o primeiro
SELECT NULLIF(1000,1000), NULLIF(1000,2000)
FROM dual;

-- uso do case
SELECT last_name, job_id, salary,
                            CASE job_id
                                WHEN 'IT_PROG'
                                    THEN 1.1*salary
                                WHEN 'ST_CLERK'
                                    THEN 1.15*salary
                                WHEN 'SA_REP'
                                    THEN 1.2*salary
                                ELSE salary
                            END NOVO_SALARIO
FROM employees;

-- função decode
SELECT last_name, job_id, salary,
DECODE(job_id,  'IT_PROG', 1.1*salary,
                'ST_CLERK', 1.15*salary,
                'SA_REP', 1.2*salary
                        , salary) NOVO_SALARIO
FROM employees;