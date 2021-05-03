--time zones:
--conceito de fuso-horário (gmt/utc)
--quando utilizar diferença de hora: +/- HH:MI (maior ou menor que a referência, dois dígitos para horas e dois dígitos para minutos)
--como user sys/dba(somente ele pode consultar):
--consultando times zones:
SELECT *
FROM v$timezone_names --view de performance dinâmica. contém o nome das times zones e abreviações
WHERE tzname like '%Sao_Paulo%';

SELECT *
FROM v$timezone_names
WHERE tzname like '%Brazil%';

SELECT *
FROM v$timezone_names
WHERE tzname like '%New_York%';