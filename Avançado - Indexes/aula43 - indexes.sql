--indexes
--são objetos do schema do usuário. quando acessada pelo oracle pode aumentar a performance das recuperações de linhas
--o oracle dá prefência por navegar pelo index (plano de execução) ao invés de ler a tabela inteira (full table scan), ou seja, reduz o i/o
--são independentes da tabela, objeto separado
--são criados manualmente (create index para fk - recomendado, colunas frequentemente utilizadas na cláusula where)...
--ou automaticamente (ao definir/utilizar pk ou uniq)
--após a criação são utilizados automaticamente pelo oracle, se for o melhor plano de execução
--indexes simples(uma coluna) ou compostos(mais de uma coluna)
--exemplo de full table scan:
--para confirmar full table scan basta executar o select e clicar f10
SELECT *
FROM employees;
--ao executar um comando o oracle passa por três fases:
--1. parse - analisa as alternativas de plano de execução, escolhe o de menor custo 2.execute 3.fatch

--select com cláusula where:
SELECT *
FROM employees
WHERE phone_number = '515.127.4565';
--mesmo com a cláusula where que só traz uma linha o oracle realizou um full table scan, leu desnecessariamente
--para melhorar a performance é preciso criar um index para phone number

--por default os indexes são valores não únicos. para alterar basta digitar unique após o create
--por defaul ele é bitree, árvore binária. para mudar basta digitar bitmap após o create
--criando manualmente um index para o phone number:
CREATE INDEX employees_phone_number_idX
ON employees(phone_number);
--só cria um unique index quando não há dados repetidos, nesse caso há phone_numbers iguais
--executando o select novamente:
SELECT *
FROM employees
WHERE phone_number = '515.127.4565';
--oracle executa cláusula where no índice,
--encontrando igualdade idenfica o endereço lógico da linha (rowid),
--com ele o orale lê o endereço físico, a tabela apenas onde houve igualdade e o devolve
--80% dos problemas com performance é devido ao uso inadequado ou não uso de index
--quando definido a constraint pk ou uk o index para cada uma delas é criado automaticamente
--uma boa prática é criar uma constraint unique que automaticamente criará o index desejado:
DROP INDEX employees_phone_number_idx;

ALTER TABLE employees
ADD CONSTRAINT employees_phone_number_uk UNIQUE (phone_number);

SELECT *
FROM employees;

UPDATE employees
SET phone_number = '525.342.238'
WHERE employee_id = 208;

COMMIT;