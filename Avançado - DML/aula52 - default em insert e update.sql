--utilizando a op��o default nos comandos insert e update
--na cria��o de uma tabela � poss�vel definir um valor default para cada coluna
--� poss�vel definir um default durante o insert de linhas
--criando uma tabela j� especificando para determinada coluna o valor default:
--quando fizer um insert e n�o for inserido qlqr valor para a coluna creation_date, ser� exibido o valor default
CREATE TABLE projects
(project_id    NUMBER(6)  NOT NULL,
project_code  VARCHAR2(10) NOT NULL,
project_name  VARCHAR2(100) NOT NULL,
CREATION_DATE DATE DEFAULT sysdate NOT NULL,
START_DATE    DATE,
END_DATE      DATE,
STATUS        VARCHAR2(20) NOT NULL,
PRIORITY      VARCHAR2(10)  NOT NULL,
BUDGET        NUMBER(11,2) NOT NULL,
DESCRIPTION   VARCHAR2(400) NOT NULL);
 
--para ficar mais claro o uso do que for default no insert recomenda-se digitar default
--mas s� funcionar� quando realmente existir um valor default:
INSERT INTO projects (project_id, project_code, project_name, creation_date, status, priority, budget, description)
VALUES (1, 'PROJERP001', 'Oracle ERP', DEFAULT, 'PLANNING', 'HIGH', 1000000, 'Implanta��o do Oracle ERP');
 
COMMIT; --smp utilizar para comandos dml
 
--consultando a tabela para verificar o insert com uma das colunas default:
SELECT *
FROM projects;