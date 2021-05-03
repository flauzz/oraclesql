--funções:
--globalização tratamento de datas e diferentes times zones
--dbtimezone: retorna a utc do banco de dados
--sessiontimezone: retorna o nome da time zone do banco de dados
--conectado como user sys/dba:
--consultando a utc do banco de dados com dbtimezone:
SELECT DBTIMEZONE --por default é o 00, meridiano de greenwicht
FROM dual;
--para alterar a utc do banco de dados:
ALTER DATABASE SET TIME_ZONE='-03:00'; --time zone de são paulo
--para que a alteração anterior tenha efeito: shutdown e startup (reiniciar) da instância, sessão, banco de dados
--em windows, serviços, procurar oracleservicexe, entrar, parar, iniciar e reconectar
--consultando novamente para confirmar a alteração:
SELECT DBTIMEZONE
FROM dual;

--consultando o nome da time zone com sessiontimezone:
SELECT SESSIONTIMEZONE
FROM dual;

--conectado como user hr:
--sysdate: retorna a data(tipo date) do servidor de banco de dados (apenas data):
SELECT sysdate --exibe o formato definido no parâmetro nls_date_format (pelo dba)
FROM dual;

--systimestamp: retorna a data(tipo timestamp) do servidor de banco de dados (data, hora, minuto, segundo e utc):
SELECT systimestamp
FROM dual;

--current_date: retorna a data(tipo date) da sessão do usuário do banco de dados (apenas data):
SELECT CURRENT_DATE
FROM dual;

--current_timestamp: retorna a data(tipo timestamp with time zone) da sessão do usuário do banco de dados(data, hora, minuto, segundo e utc):
SELECT CURRENT_TIMESTAMP
FROM dual;

--localtimestamp: retorna a data(tipo timestamp) local sem fuso horário da sessão do usuário(data, hora, minuto, segundo):
SELECT LOCALTIMESTAMP
FROM dual;