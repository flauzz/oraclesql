--indexes
--s�o objetos do schema do usu�rio. quando acessada pelo oracle pode aumentar a performance das recupera��es de linhas
--o oracle d� pref�ncia por navegar pelo index (plano de execu��o) ao inv�s de ler a tabela inteira (full table scan), ou seja, reduz o i/o
--s�o independentes da tabela, objeto separado
--s�o criados manualmente (create index para fk - recomendado, colunas frequentemente utilizadas na cl�usula where)...
--ou automaticamente (ao definir/utilizar pk ou uniq)
--ap�s a cria��o s�o utilizados automaticamente pelo oracle, se for o melhor plano de execu��o
--indexes simples(uma coluna) ou compostos(mais de uma coluna)
--exemplo de full table scan:
--para confirmar full table scan basta executar o select e clicar f10
SELECT *
FROM employees;
--ao executar um comando o oracle passa por tr�s fases:
--1. parse - analisa as alternativas de plano de execu��o, escolhe o de menor custo 2.execute 3.fatch

--select com cl�usula where:
SELECT *
FROM employees
WHERE phone_number = '515.127.4565';
--mesmo com a cl�usula where que s� traz uma linha o oracle realizou um full table scan, leu desnecessariamente
--para melhorar a performance � preciso criar um index para phone number

--por default os indexes s�o valores n�o �nicos. para alterar basta digitar unique ap�s o create
--por defaul ele � bitree, �rvore bin�ria. para mudar basta digitar bitmap ap�s o create
--criando manualmente um index para o phone number:
CREATE INDEX employees_phone_number_idX
ON employees(phone_number);
--s� cria um unique index quando n�o h� dados repetidos, nesse caso h� phone_numbers iguais
--executando o select novamente:
SELECT *
FROM employees
WHERE phone_number = '515.127.4565';
--oracle executa cl�usula where no �ndice,
--encontrando igualdade idenfica o endere�o l�gico da linha (rowid),
--com ele o orale l� o endere�o f�sico, a tabela apenas onde houve igualdade e o devolve
--80% dos problemas com performance � devido ao uso inadequado ou n�o uso de index
--quando definido a constraint pk ou uk o index para cada uma delas � criado automaticamente
--uma boa pr�tica � criar uma constraint unique que automaticamente criar� o index desejado:
DROP INDEX employees_phone_number_idx;

ALTER TABLE employees
ADD CONSTRAINT employees_phone_number_uk UNIQUE (phone_number);

SELECT *
FROM employees;

UPDATE employees
SET phone_number = '525.342.238'
WHERE employee_id = 208;

COMMIT;