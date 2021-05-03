--funções de conversão:
--globalização tratamento de datas e diferentes times zones:
--from_tz: converter um timestamp em timestamp with timezone
--utilizando o from_tz. altera a utc sem mudar a hora:
SELECT LOCALTIMESTAMP, --data local do user
       FROM_TZ(LOCALTIMESTAMP,'America/Sao_Paulo'), 
       FROM_TZ(LOCALTIMESTAMP,'Asia/Dubai'), 
       FROM_TZ(LOCALTIMESTAMP,'America/Chicago')
FROM dual;
--informando a utc em horas-minutos:
SELECT FROM_TZ(TIMESTAMP '2021-08-08 11:00:00', '-03:00'),
       FROM_TZ(TIMESTAMP '2021-08-08 11:00:00', '-05:00'),
       FROM_TZ(TIMESTAMP '2021-08-08 11:00:00', '-07:00')
FROM DUAL;
--mesmo exemplo anterior pegando a data atual:
SELECT FROM_TZ(localtimestamp, '-03:00'),
       FROM_TZ(localtimestamp, '-05:00'),
       FROM_TZ(localtimestamp, '-07:00')
FROM DUAL;
  
--to_timestamp: converter string em timestamp(formato especificado):
SELECT TO_TIMESTAMP ('2006-01-18 08:15:32.1234', 'YYYY-MM-DD HH24:MI:SS.FF') NOVO_TIMESTAMP
FROM dual;

--to_timestamp_tz: converter uma string em timestamp with timezone:
SELECT TO_TIMESTAMP_TZ ('2006-01-18 08:15:32.1234 -5:00', 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') NOVO_TIMESTAMP_WITH_TIMEZONE
FROM dual;
--mesmo exemplo anterior, mas com a região (region), não a hora e minuto da timezone:
SELECT TO_TIMESTAMP_TZ ('2006-01-18 08:15:32.1234 America/Sao_Paulo', 'YYYY-MM-DD HH24:MI:SS.FF TZR') NOVO_TIMESTAMP_WITH_TIMEZONE
FROM dual;