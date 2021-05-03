--criando index baseados em funções
--quando é utilizada alguma função sobre a coluna indexada o index pode não funcionar normalmente
--para corrigir, existe o index baseado em funções
--ao invés de citar a coluna q será aplicada o index eu digito uma função
--index só será utilizado quando a query solicitar tal função na cláusula where
--criando um index normal para comparação:
CREATE INDEX employees_first_name_idx ON employees(first_name);

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL'; --não foi usado o index pois o index criado não é baseado em funções e a cláusula where solicita

-- Criando um index baseado em função para melhorar a performance da query anterior:
CREATE INDEX employees_upper_first_name_idx ON employees(UPPER(first_name));

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL';
--verificar/analisar o plano de execução da query anterior