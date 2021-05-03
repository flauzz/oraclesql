--função tz_offset:
--globalização tratamento de datas e diferentes times zones:
--tz_offset: recebe o nome do time zone, dbtimezone ou sessiontimezone e retorna a time zone offset (deslocamento da utc)
--alterando a utc do banco de dados: 
--conectando como user sys/dba:
--alterando a time zone do banco de dados:
ALTER DATABASE SET TIME_ZONE='+00:00'; 
--para que esse parâmetro seja efetivado fazer o shutdown e startup
--consultando para verificar a mudança. dbtimezone:
SELECT DBTIMEZONE --retorna a utc do banco de dados
FROM dual;
--conferindo que a time zone da sessão não foi alterado:
SELECT SESSIONTIMEZONE
FROM dual;

--utilizando a função tz_offset:
SELECT TZ_OFFSET(DBTIMEZONE) --deslocamento do banco de dados
FROM dual;
--deslocamento do session:
SELECT TZ_OFFSET(SESSIONTIMEZONE)
FROM dual;

--consultando os nomes das times zones de new york:
SELECT *
FROM V$timezone_names
WHERE tzname like '%New_York%';
--distância de new york para utc zero:
SELECT TZ_OFFSET('America/New_York')
FROM dual;

consultando os nomes das times zones de paris:
SELECT *
FROM V$timezone_names
WHERE tzname like '%Paris%';
--distância de paris para utc zero:
SELECT TZ_OFFSET('Europe/Paris')
FROM dual;