-- comparação de string é case sensitive
SELECT employee_id, last_name, department_id
FROM employees
WHERE last_name = 'KING';

SELECT employee_id, last_name, department_id
FROM employees
WHERE UPPER (last_name) = 'KING';

SELECT employee_id, UPPER (last_name) "CAIXA ALTA", department_id
FROM employees
WHERE last_name = 'King';

-- concat, length, substr e instr
SELECT CONCAT('Curso: ', 'Introdução Oracle 19c'),
SUBSTR('Introdução Oracle 19c', 1, 10),
LENGTH('Introdução Oracle 19c'),
INSTR('Introdução ORACLE 19c', 'ORACLE')
FROM dual;

-- lpad e rpad
SELECT first_name "Nome",
LPAD(first_name, 20, ' ') "Nome alinhado à direita",
RPAD(first_name, 20, ' ') "Nome alinhado à esquerda"
FROM employees;

-- replace
SELECT job_title,
REPLACE(job_title, 'President', 'Presidente') CARGO
FROM jobs
WHERE job_title = 'President';

-- funções tipo number: round, trunc, mod, abs, sqrt
SELECT ROUND(45.923, 2), ROUND(45.923, 0)
FROM dual;

SELECT TRUNC(45.923, 2), TRUNC(45.923, 0)
FROM dual;

SELECT MOD(1300,600) RESTO
FROM dual;

SELECT ABS(-9), SQRT(9)
FROM dual;

--date
SELECT sysdate
FROM dual;

--dual
DESCRIBE dual;

SELECT *
FROM dual;

SELECT (1000*1.25)
FROM dual;

-- cálculo com datas
SELECT sysdate, sysdate + 30, sysdate + 60, sysdate - 30
FROM dual;

SELECT last_name, ROUND((sysdate-hire_date)/7,2) "Semanas de Trabalho"
FROM employees;

SELECT first_name, last_name, ROUND(MONTHS_BETWEEN(sysdate, hire_date),2) "Meses de Trabalho"
FROM employees;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), NEXT_DAY(SYSDATE, 'SEGUNDA FEIRA'), last_day(SYSDATE)
FROM dual;

SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), ROUND(SYSDATE, 'YEAR'),
        TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR')
FROM dual;

SELECT SYSDATE, TO_CHAR(TRUNC(SYSDATE), 'DD/MM/YY HH24:MI:SS')
FROM dual;