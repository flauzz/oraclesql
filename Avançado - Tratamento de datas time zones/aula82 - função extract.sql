--fun??o extract:
--globaliza???o tratamento de datas e diferentes times zones
--extraindo e retornando ano, mes e dia de um tipo date:
SELECT EXTRACT(YEAR FROM SYSDATE) ANO,
       EXTRACT(MONTH FROM SYSDATE) M?S,
       EXTRACT(DAY FROM SYSDATE) DIA
FROM dual;

--extraindo ano, mes, dia, hora, minuto, segundo de um tipo timestamp:
SELECT EXTRACT(YEAR FROM CURRENT_TIMESTAMP) ANO, --current data da sess?o vigente
       EXTRACT(MONTH FROM CURRENT_TIMESTAMP) M?S,
       EXTRACT(DAY FROM CURRENT_TIMESTAMP) DIA,
	   EXTRACT(HOUR FROM CURRENT_TIMESTAMP) HORA,
       EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) MINUTO,
       EXTRACT(SECOND FROM CURRENT_TIMESTAMP) SEGUNDO,
       EXTRACT(TIMEZONE_HOUR FROM CURRENT_TIMESTAMP) TIMEZONE_HOUR, --timezone retorna data do banco de dados
       EXTRACT(TIMEZONE_MINUTE FROM CURRENT_TIMESTAMP) TIMEZONE_MINUTE,
	   EXTRACT(TIMEZONE_REGION FROM CURRENT_TIMESTAMP) TIMEZONE_REGION,
       EXTRACT(TIMEZONE_ABBR FROM CURRENT_TIMESTAMP) TIMEZONE_ABBR
FROM dual;

--extraindo ano, mes de interval year to month:
SELECT EXTRACT( YEAR FROM INTERVAL '5-2' YEAR TO MONTH ) ANO, 
       EXTRACT( MONTH FROM INTERVAL '5-2' YEAR TO MONTH) M?S
FROM dual;

--extraindo dia, hora, minuto, segundo de interval day to second:
SELECT EXTRACT( DAY FROM INTERVAL '5 04:30:20.11' DAY TO SECOND ) DIA,
       EXTRACT( HOUR FROM INTERVAL '5 04:30:20.11' DAY TO SECOND ) HORA,
       EXTRACT( MINUTE FROM INTERVAL '5 04:30:20.11' DAY TO SECOND ) MINUTO,
       EXTRACT( SECOND FROM INTERVAL '5 04:30:20.11' DAY TO SECOND ) SEGUNDO
FROM dual;