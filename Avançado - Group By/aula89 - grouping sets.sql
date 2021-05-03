--aperfei�oando a cl�usula group by:
--grouping sets:
--extens�o da cl�usula group by utilizada para obtermos subtotais de um select que utiliza fun��es de agrega��o(de grupo)
--conectado como user sales:
--visualizando a table sales ordenada:
SELECT *
FROM sales
ORDER BY continent, country, city;

--para visualizar a soma de vendas
--por continente, por pa�s e por cidade usando o group by � preciso fazer um select para cada e visualizar separadamente:
SELECT continent, SUM(units_sold)
FROM sales 
GROUP BY continent;

SELECT country, SUM(units_sold)
FROM sales 
GROUP BY country;

SELECT city, SUM(units_sold)
FROM sales 
GROUP BY city;

--para visualizar as mesmas informa��es das queries anteriores em uma �nica visualiza��o e um �nico select(query):
--utiliza-se grouping sets:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city);
--utilizando grouping sets com total geral:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ()); --() = total geral