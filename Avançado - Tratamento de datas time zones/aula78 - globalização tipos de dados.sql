--globaliza��o, tipos de dados:
--globaliza��o, tratamento de datas e diferentes times zones:
--o tipo de dado timestamp � semelhante ao date, mas tem bem mais precis�o, al�m disso, pode armazenar fuso hor�rio
--op��es timestamp: 1.timestamp(n), 2.timestamp(n) with time zone, 3.timestamp(n) with local time zone
--1. com at� 9 d�gitos decimais de segundo. n de 0 a 9
--2. armazena o tempo absoluto de um fuso, convertido para o fuso do banco de dados (server)
--3. armazena o tempo absoluto de um fuso, convertido para o fuso da aplica��o cliente
--op��es interval year: 1.interval year(n) to month, 2.interval day(n) to second(n)
--1. armazena diferen�a de ano e m�s entre duas timestamp
--2. armazena a diferen�a de dias, horas, minutos e segundos entre duas timestamp
--consultando sysdate, retornando a data atual de tipo date:
SELECT sysdate
FROM dual; --somente o dba pode alterar o formato default com q a data � exibida

SELECT TO_CHAR(sysdate, 'DD/MM/YYYY') --para visualizar a data em outro formato
FROM dual;

--consultando systimestamp, retornando data atual de tipo timestamp:
SELECT systimestamp
FROM dual;

--utilizando interval year to month:
SELECT INTERVAL '55-11' YEAR TO MONTH --55 anos e 11 meses
FROM dual;
--outro exemplo:
SELECT INTERVAL '1-4' YEAR TO MONTH --1 ano e 4 meses
FROM dual;

--causando um erro de precis�o para o ano:
SELECT INTERVAL '555-11' YEAR TO MONTH --precis�o default para ano s�o dois d�gitos
FROM dual;
--corrigindo o erro de precis�o anterior:
SELECT INTERVAL '555-11' YEAR(4) TO MONTH
FROM dual;

--quantos anos equivalem uma determinada quantidade de meses:
SELECT INTERVAL '350' MONTH
FROM dual;

--day to second:
SELECT INTERVAL '33 20:20:20' DAY TO SECOND
FROM dual;
--causando erro de precis�o para o dia:
SELECT INTERVAL '333 20:20:20' DAY TO SECOND --precis�o default para o dia s�o dois d�gitos
FROM dual;
--corrigindo o erro de precis�o anterior:
SELECT INTERVAL '333 20:20:20' DAY(3) TO SECOND
FROM dual;

--quantos dias equivalem uma determinada quantidade de horas:
SELECT INTERVAL '500' HOUR
FROM dual;