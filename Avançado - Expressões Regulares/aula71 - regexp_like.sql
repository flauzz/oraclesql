--utilizando regexp_like em uma consulta:
--é uma mutação do operador like para a utilização com expressões regulares
--necessita de três argumentos: 1.string - onde será a pesquisa, 2.padrão - expressão regular a ser procurada dentro do string
--e 3.opção de match - c (case sensitive - default), i (não case sensitive) e m (origem como múltiplas linhas) (3º é opcional)
--comparação case sensitive(default):
SELECT *
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');
--mesma comparação case sensitive com c:
SELECT *
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$', 'c'); --c não obrigatório, pois já é o padrão

--comparação não case sensitive:
SELECT *
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$','i');

--utilizando regexp_like em uma consulta constraint do tipo check:
--apagando e recriando a tabela employees_copy vazia:
DROP TABLE employees_copy;

CREATE table employees_copy 
AS
SELECT *
FROM employees
WHERE 1=2;

ALTER TABLE employees_copy
ADD CONSTRAINT phone_number_ck
CHECK (REGEXP_LIKE(phone_number, '^[0-9]{3}\.[0-9]{3}\.[0-9]{4}$')); --constraint de validação: só aceitará telefones que seguem o que está entre aspas