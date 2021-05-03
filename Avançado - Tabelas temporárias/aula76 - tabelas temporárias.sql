--tabelas temporárias:
--são visíveis em todas as sessões, mas suas linhas são privativas para a sessão que as criou/inseriu ou alterou
--ao encerrar a sessão os dados inseridos ou alterados são automaticamente eliminados
--há uma cláusula opcional que determina o tempo de vida de todas as linhas inseridas
--o default as elimina assim que a transação é concluída, mas pode ser alterado para que sejam eliminadas ao término da sessão
--independente da escolha os dados são privativos à sessão(usuário se conecta, inicia-se uma sessão)
--é possível executar nelas quaisquer comando dml e o select. pode ter indexes, constraints e triggers
--é possível referenciá-las nas views e synonyms e fazer join com outras tabelas
--todos os comandos executados nela serão mais rápidos que os comandos nas tabelas permanentes
--fica gravada numa memória oracle chamada pga(program global area) - caso comporte a tabela inteira, mais rápido de acessar do que as gravadas em disco
--usadas largamente para a elaboração de relatórios, exibir uma tabela com diversos dados de diversas tabelas para mostrar informações específicas
--ao final da criação da tabela temporária existem duas opções: on commit delete rows ou on commit preserve rows
--on commit delete rows: default, determina que os dados da tabela serão eliminados (truncate) após o commit
--on commit preserve rows: determina que os dados da tabela serão preservados após o commit e eliminados apenas ao término da sessão
--a estrutura da tabela fica permanente, o que é temporário são os dados
--criando uma tabela temporária:
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
--consultando a tabela temporária recém criada:
SELECT *
FROM hr.tmp_employees;

--conectando-se como usuário sys, dba ou qlqr outro usuário não será possível visualizar os dados(linhas) da tabela temporária
--inserindo linhas na tabela temporária:
INSERT INTO hr.tmp_employees
SELECT *
FROM hr.employees;
  
COMMIT;
--consultando novamente a tabela temporária para confirmar a inserção de linhas:
SELECT *
FROM hr.tmp_employees;
--conectando-se como usuário sys, dba ou qlqr outro usuário não será possível visualizar os dados(linhas) da tabela temporária
--encerrando a sessão, os dados(linhas) da tabela temporária são automaticamente eliminados, mesmo que para mesma sessão