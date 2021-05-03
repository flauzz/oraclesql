--utilizando regexp_replace:
--substitui determinado caractere por uma expressão regular
--pode ter até 6 argumentos: 1.string - onde será a pesquisa, 2.padrão - o que será alterado, 3.string para substituição - novo padrão,
--4.posição - posição(número) para iniciar a pesquisa (default - 1), 5.ocorrência - ql ocorrêcia deve ser alterada(0 - em todas(default), 1 - na primeira,
--2 - na segunda...) e 6.opção de match - c(default), i ou m
--comparação e substituição case sensitive(default):
--onde for encontrado . nas linhas da coluna phone_number será substituído por -, levando-se em conta o case:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-') as phone
FROM employees;
--mesma comparação inserindo os default:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-',1,0,'c') as phone
FROM employees;

--comparação e substituição não case sensitive:
--onde for encontrado . nas linhas da coluna phone_number será substituído por -, não se levando em conta o case:
SELECT phone_number, REGEXP_REPLACE(phone_number, '\.','-',1,0,'i') as phone
FROM employees;