--aperfei�oando a cl�usula group by:
--cube:
--extens�o da cl�usula group by utilizada para executar as mesmas fun��es de grupo para todas as combina��es de subgrupo poss�veis:
--grande utilidade na constru��o de subtotais
--conectado como user sales:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city);