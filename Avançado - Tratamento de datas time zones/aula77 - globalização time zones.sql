--time zones:
--conceito de fuso-hor�rio (gmt/utc)
--quando utilizar diferen�a de hora: +/- HH:MI (maior ou menor que a refer�ncia, dois d�gitos para horas e dois d�gitos para minutos)
--como user sys/dba(somente ele pode consultar):
--consultando times zones:
SELECT *
FROM v$timezone_names --view de performance din�mica. cont�m o nome das times zones e abrevia��es
WHERE tzname like '%Sao_Paulo%';

SELECT *
FROM v$timezone_names
WHERE tzname like '%Brazil%';

SELECT *
FROM v$timezone_names
WHERE tzname like '%New_York%';