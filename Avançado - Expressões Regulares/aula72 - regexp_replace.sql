--utilizando regexp_replace:
--substitui determinado caractere por uma express�o regular
--pode ter at� 6 argumentos: 1.string - onde ser� a pesquisa, 2.padr�o - o que ser� alterado, 3.string para substitui��o - novo padr�o,
--4.posi��o - posi��o(n�mero) para iniciar a pesquisa (default - 1), 5.ocorr�ncia - ql ocorr�cia deve ser alterada(0 - em todas(default), 1 - na primeira,
--2 - na segunda...) e 6.op��o de match - c(default), i ou m
--compara��o e substitui��o case sensitive(default):
--onde for encontrado . nas linhas da coluna phone_number ser� substitu�do por -, levando-se em conta o case:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-') as phone
FROM employees;
--mesma compara��o inserindo os default:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-',1,0,'c') as phone
FROM employees;

--compara��o e substitui��o n�o case sensitive:
--onde for encontrado . nas linhas da coluna phone_number ser� substitu�do por -, n�o se levando em conta o case:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-',1,0,'i') as phone
FROM employees;