--reconstruindo e reorganizando indexes:
--conforme as atualizações da tabela, adicionar e remover linhas, alterando o index pode tornar-se desorganizado e não mais fazer o efeito desejado
--duas alternativas: remover o index e recriá-lo ou rebuild
--rebuild: mantém o index antigo o inserindo no index novo. enqnto o executa o oracle faz lock das linhas que fazer parte do index (dml em wait)
--online: oracle minimiza o lock, faz parcialmente, minimiza o wait. bem recomendado (apenas na versão enterprise)
ALTER INDEX employees_job_id_idx REBUILD;
ALTER INDEX employees_job_id_idx REBUILD ONLINE;