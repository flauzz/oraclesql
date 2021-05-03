--flashback query:
--forma de consultar o passado
--quanto mais tempo o erro permanece mais ele se propaga
--consultando uma tabela para executar um update equivocado:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';
--multiplicando indevidamente o sal�rio de todos os empregdos de fi_account por 2:
UPDATE employees
SET    salary = salary * 2
WHERE  job_id = 'FI_ACCOUNT';
--confirmando a mudan�a:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';

COMMIT;

--resolvendo com o flashback:
DECLARE --declarar um cursor
    CURSOR c_employees IS SELECT *
                          FROM employees AS OF TIMESTAMP (systimestamp - INTERVAL '15' MINUTE); --consultar a tabela como ela estava 15min antes
    
    r_employees  c_employees%ROWTYPE; --declara��o de uma vari�vel do tipo
  
BEGIN  
    OPEN c_employees; --ao abrir o cursor o oracle executar� o select do cursor e as linhas resultante ficar�o na mem�ria resultset
    LOOP --rodar� o loop at� que todas as linhas estejam restauradas/atualizadas
        FETCH c_employees INTO r_employees; 
        
        EXIT WHEN c_employees%NOTFOUND; 
        
        UPDATE employees 
        SET    salary = r_employees.salary
        WHERE  employee_id = r_employees.employee_id;
    END LOOP; 
    CLOSE c_employees;
  
    COMMIT;
END;

--consultando se houve corre��o do problema:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';

--consultar todos os par�metros undo existentes no banco como dba:
SELECT name, value
FROM v&parameter
WHERE name LIKE '%undo%';
--undo retation � o tempo m�ximo em que posso voltar para corrigir algo feito errado, mas sofre interfer�ncia do tamanho da tablespace de undo
--quanto maior o tamanho da tablespace de undo, por mais tempo mant�m os dados para poder fazer um flashback maior