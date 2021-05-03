--aperfei�oando a cl�usula group by:
--setup: criando schema sales
--conectado como user sys/dba:
--apagando e recriando o user sales:
DROP user sales cascade; --cascade, caso o usu�rio j� tenha tables, queira remov�-lo mesmo assim

CREATE USER sales --nome do user
IDENTIFIED BY sales --senha para conctar
DEFAULT TABLESPACE users --espa�o de trabalho
QUOTA UNLIMITED ON USERS --liberar qnto espa�o o user quiser
TEMPORARY TABLESPACE TEMP; --usada pra source ou merge
--grant para conceder privil�gios, connect para que o user conecte-se e inicie uma sess�o e resource para que ele possa criar objetos 
GRANT CONNECT, RESOURCE TO sales;

--criar conex�o para user sales e conectar-se como sales:
--conectado como sales:
--criando a tabela sales:
CREATE TABLE sales
(continent varchar(20),
country varchar(20),
city varchar(20),
units_sold integer);

--inserindo linhas na tabela rec�m criada:
INSERT INTO sales VALUES ('North America', 'Canada', 'Toronto', 10000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Montreal', 5000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Vancouver', 15000);
INSERT INTO sales VALUES ('Asia', 'China', 'Hong Kong', 7000);
INSERT INTO sales VALUES ('Asia', 'China', 'Shanghai', 3000);
INSERT INTO sales VALUES ('Asia', 'Japan', 'Tokyo', 5000);
INSERT INTO sales VALUES ('Europe', 'UK', 'London', 6000);
INSERT INTO sales VALUES ('Europe', 'UK', 'Manchester', 12000);
INSERT INTO sales VALUES ('Europe', 'France', 'Paris', 5000);

COMMIT; --efetivar a transa��o

--consultando a table sales:
SELECT *
FROM sales;