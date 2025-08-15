USE energy_consumption_db;

-- a. How have global emissions changed year over year?
SELECT `year`, SUM(emission) AS total_global_emissions
	FROM emission_3
    GROUP BY `year`
    ORDER BY `year`;

-- b. What is the trend in GDP for each country over the given years?
SELECT Country, `year`, `Value`
	FROM gdp_3
    ORDER BY Country, `year`;

-- c. How has population growth affected total emissions in each country?
SELECT 
    p.countries AS country,
    p.year,
    p.Value AS population,
    SUM(e.emission) AS total_emissions,
    ROUND(SUM(e.emission) / p.Value, 4) AS emissions_per_capita
	FROM population p
	JOIN emission_3 e
		ON p.countries = e.country
		AND p.year = e.year
	GROUP BY p.countries, p.year, p.Value
	ORDER BY country, p.year;

-- d. Has energy consumption increased or decreased over the years for major economies?
SELECT c.Country, c1.`year`, SUM(c1.consumption) AS total_consumption
	FROM consumption c1
    JOIN country c
		ON c1.country = c.Country
	WHERE c.Country IN ('United States', 'China', 'India', 'Japan', 'Germany', 'Australia')
    GROUP BY c.Country, c1.`year`
    ORDER BY c.Country, c1.`year`;

-- e. What is the average yearly change in emissions per capita for each country?
SELECT country, AVG(yearly_change) AS avg_yearly_change
	FROM (
		SELECT country, `year`,
        per_capita_emission - LAG(per_capita_emission)
        OVER 
        (PARTITION BY country ORDER BY `year`) AS yearly_change
        FROM emission_3
	) AS changes
    WHERE yearly_change IS NOT NULL
    GROUP BY country;

SELECT country, year, per_capita_emission
FROM emission_3
ORDER BY country, year;