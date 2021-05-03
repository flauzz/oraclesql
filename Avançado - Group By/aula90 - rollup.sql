--aperfeiçoando a cláusula group by:
--rollup:
--extensão da cláusula group by utilizada para executar as mesmas funções de grupo em subgrupos(n, n-1, n-2...)
--grande utilidade na construção de subtotais
--conectado como user sales:
--utilizando apenas a extensão rollup:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);

--grouping_id(): utilizada para identificação de grupos e subgrupos
--utilizando a função rollup com grouping_id(retorna 0, tem valor, retorna 1, não tem valor):
SELECT continent, GROUPING_ID(continent) GCONTINENT,
       country, GROUPING_ID(country) GCOUNTRY, 
       city, GROUPING_ID(city) GCITY,
       SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);