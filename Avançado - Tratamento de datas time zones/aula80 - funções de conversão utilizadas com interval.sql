--funções de conversão utilizadas com interval:
--globalização tratamento de datas e diferentes times zones:
--to_yminterval: uma string para year to month
--to_dsinterval: uma string para day to second

--somando dias a uma data (somar 30 dias a sysdate):
SELECT sysdate, sysdate + 30 
FROM dual;
-- Somando horas a uma data (somar 3 horas a sysdate):
SELECT TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(sysdate + 3/24,'DD/MM/YYYY HH24:MI:SS')
FROM dual;
--somando minutos a uma data (somar 10 minutos a sysdate):
SELECT TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(sysdate + 10/24/60,'DD/MM/YYYY HH24:MI:SS')
FROM dual;
--somando segundos a uma data (somar 10 segundos a sysdate):
SELECT TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(sysdate + 10/24/60/60,'DD/MM/YYYY HH24:MI:SS')
FROM dual;

--utilizando a função to_yminterval:
--adicionar 1 ano e 6 meses a data atual:
SELECT sysdate, sysdate + TO_YMINTERVAL('01-06')
FROM dual;

--utilizando a função to_dsinterval:
--adicionar 6 dias e 2 horas a data atual:
SELECT TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(sysdate + TO_DSINTERVAL('6 02:00:00'),'DD/MM/YYYY HH24:MI:SS')
FROM dual;