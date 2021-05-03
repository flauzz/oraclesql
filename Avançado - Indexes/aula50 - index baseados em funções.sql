--criando index baseados em fun��es
--quando � utilizada alguma fun��o sobre a coluna indexada o index pode n�o funcionar normalmente
--para corrigir, existe o index baseado em fun��es
--ao inv�s de citar a coluna q ser� aplicada o index eu digito uma fun��o
--index s� ser� utilizado quando a query solicitar tal fun��o na cl�usula where
--criando um index normal para compara��o:
CREATE INDEX employees_first_name_idx ON employees(first_name);

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL'; --n�o foi usado o index pois o index criado n�o � baseado em fun��es e a cl�usula where solicita

-- Criando um index baseado em fun��o para melhorar a performance da query anterior:
CREATE INDEX employees_upper_first_name_idx ON employees(UPPER(first_name));

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL';
--verificar/analisar o plano de execu��o da query anterior