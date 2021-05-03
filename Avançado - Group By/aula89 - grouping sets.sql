--aperfeiçoando a cláusula group by:
--grouping sets:
--extensão da cláusula group by utilizada para obtermos subtotais de um select que utiliza funções de agregação(de grupo)
--conectado como user sales:
--visualizando a table sales ordenada:
SELECT *
FROM sales
ORDER BY continent, country, city;

--para visualizar a soma de vendas
--por continente, por país e por cidade usando o group by é preciso fazer um select para cada e visualizar separadamente:
SELECT continent, SUM(units_sold)
FROM sales 
GROUP BY continent;

SELECT country, SUM(units_sold)
FROM sales 
GROUP BY country;

SELECT city, SUM(units_sold)
FROM sales 
GROUP BY city;

--para visualizar as mesmas informações das queries anteriores em uma única visualização e um único select(query):
--utiliza-se grouping sets:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city);
--utilizando grouping sets com total geral:
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ()); --() = total geral