--tabelas tempor�rias:
--s�o vis�veis em todas as sess�es, mas suas linhas s�o privativas para a sess�o que as criou/inseriu ou alterou
--ao encerrar a sess�o os dados inseridos ou alterados s�o automaticamente eliminados
--h� uma cl�usula opcional que determina o tempo de vida de todas as linhas inseridas
--o default as elimina assim que a transa��o � conclu�da, mas pode ser alterado para que sejam eliminadas ao t�rmino da sess�o
--independente da escolha os dados s�o privativos � sess�o(usu�rio se conecta, inicia-se uma sess�o)
--� poss�vel executar nelas quaisquer comando dml e o select. pode ter indexes, constraints e triggers
--� poss�vel referenci�-las nas views e synonyms e fazer join com outras tabelas
--todos os comandos executados nela ser�o mais r�pidos que os comandos nas tabelas permanentes
--fica gravada numa mem�ria oracle chamada pga(program global area) - caso comporte a tabela inteira, mais r�pido de acessar do que as gravadas em disco
--usadas largamente para a elabora��o de relat�rios, exibir uma tabela com diversos dados de diversas tabelas para mostrar informa��es espec�ficas
--ao final da cria��o da tabela tempor�ria existem duas op��es: on commit delete rows ou on commit preserve rows
--on commit delete rows: default, determina que os dados da tabela ser�o eliminados (truncate) ap�s o commit
--on commit preserve rows: determina que os dados da tabela ser�o preservados ap�s o commit e eliminados apenas ao t�rmino da sess�o
--a estrutura da tabela fica permanente, o que � tempor�rio s�o os dados
--criando uma tabela tempor�ria:
CREATE GLOBAL TEMPORARY TABLE hr.tmp_employees
(employee_id  NUMBER(6),
first_name VARCHAR2(20),
last_name VARCHAR2(25),
email VARCHAR2(25),
phone_number VARCHAR2(20),
hire_date DATE,
job_id VARCHAR2(10),
salary NUMBER(8,2),
commission_pct NUMBER(2,2),
manager_id NUMBER(6),
department_id NUMBER(4))
ON COMMIT PRESERVE ROWS;
--consultando a tabela tempor�ria rec�m criada:
SELECT *
FROM hr.tmp_employees;

--conectando-se como usu�rio sys, dba ou qlqr outro usu�rio n�o ser� poss�vel visualizar os dados(linhas) da tabela tempor�ria
--inserindo linhas na tabela tempor�ria:
INSERT INTO hr.tmp_employees
SELECT *
FROM hr.employees;
  
COMMIT;
--consultando novamente a tabela tempor�ria para confirmar a inser��o de linhas:
SELECT *
FROM hr.tmp_employees;
--conectando-se como usu�rio sys, dba ou qlqr outro usu�rio n�o ser� poss�vel visualizar os dados(linhas) da tabela tempor�ria
--encerrando a sess�o, os dados(linhas) da tabela tempor�ria s�o automaticamente eliminados, mesmo que para mesma sess�o