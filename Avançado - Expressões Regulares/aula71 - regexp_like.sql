--utilizando regexp_like em uma consulta:
--� uma muta��o do operador like para a utiliza��o com express�es regulares
--necessita de tr�s argumentos: 1.string - onde ser� a pesquisa, 2.padr�o - express�o regular a ser procurada dentro do string
--e 3.op��o de match - c (case sensitive - default), i (n�o case sensitive) e m (origem como m�ltiplas linhas) (3� � opcional)
--compara��o case sensitive(default):
SELECT *
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');
--mesma compara��o case sensitive com c:
SELECT *
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$', 'c'); --c n�o obrigat�rio, pois j� � o padr�o

--compara��o n�o case sensitive:
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
CHECK (REGEXP_LIKE(phone_number, '^[0-9]{3}\.[0-9]{3}\.[0-9]{4}$')); --constraint de valida��o: s� aceitar� telefones que seguem o que est� entre aspas