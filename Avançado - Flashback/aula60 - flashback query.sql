--flashback query:
--forma de consultar o passado
--quanto mais tempo o erro permanece mais ele se propaga
--consultando uma tabela para executar um update equivocado:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';
--multiplicando indevidamente o salário de todos os empregdos de fi_account por 2:
UPDATE employees
SET    salary = salary * 2
WHERE  job_id = 'FI_ACCOUNT';
--confirmando a mudança:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';

COMMIT;

--resolvendo com o flashback:
DECLARE --declarar um cursor
    CURSOR c_employees IS SELECT *
                          FROM employees AS OF TIMESTAMP (systimestamp - INTERVAL '15' MINUTE); --consultar a tabela como ela estava 15min antes
    
    r_employees  c_employees%ROWTYPE; --declaração de uma variável do tipo
  
BEGIN  
    OPEN c_employees; --ao abrir o cursor o oracle executará o select do cursor e as linhas resultante ficarão na memória resultset
    LOOP --rodará o loop até que todas as linhas estejam restauradas/atualizadas
        FETCH c_employees INTO r_employees; 
        
        EXIT WHEN c_employees%NOTFOUND; 
        
        UPDATE employees 
        SET    salary = r_employees.salary
        WHERE  employee_id = r_employees.employee_id;
    END LOOP; 
    CLOSE c_employees;
  
    COMMIT;
END;

--consultando se houve correção do problema:
SELECT employee_id, first_name, last_name, job_id, salary
FROM   employees
WHERE  job_id = 'FI_ACCOUNT';

--consultar todos os parâmetros undo existentes no banco como dba:
SELECT name, value
FROM v&parameter
WHERE name LIKE '%undo%';
--undo retation é o tempo máximo em que posso voltar para corrigir algo feito errado, mas sofre interferência do tamanho da tablespace de undo
--quanto maior o tamanho da tablespace de undo, por mais tempo mantém os dados para poder fazer um flashback maior