--aperfeiçoando a cláusula group by:
--cube:
--extensão da cláusula group by utilizada para executar as mesmas funções de grupo para todas as combinações de subgrupo possíveis:
--grande utilidade na construção de subtotais
--conectado como user sales:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city);