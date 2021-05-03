--aperfei�oando a cl�usula group by:
--rollup:
--extens�o da cl�usula group by utilizada para executar as mesmas fun��es de grupo em subgrupos(n, n-1, n-2...)
--grande utilidade na constru��o de subtotais
--conectado como user sales:
--utilizando apenas a extens�o rollup:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);

--grouping_id(): utilizada para identifica��o de grupos e subgrupos
--utilizando a fun��o rollup com grouping_id(retorna 0, tem valor, retorna 1, n�o tem valor):
SELECT continent, GROUPING_ID(continent) GCONTINENT,
       country, GROUPING_ID(country) GCOUNTRY, 
       city, GROUPING_ID(city) GCITY,
       SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);