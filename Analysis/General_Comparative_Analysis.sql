USE energy_consumption_db;

-- a. What is the total emission per country for the most recent year available?
SELECT country, sum(emission) total_emission
	FROM emission_3
    WHERE `year` = (SELECT MAX(`year`) FROM emission_3)
    GROUP BY country
    ORDER BY total_emission DESC;

-- b. What are the top 5 countries by GDP in the most recent year?
SELECT Country, `Value` as GDP_Value
	FROM gdp_3
    WHERE `year` = (SELECT MAX(`year`) FROM gdp_3)
    ORDER BY `Value` DESC
    LIMIT 5;

-- c. Compare energy production and consumption by country and year?
SELECT c.country,
	c.`year`,
    SUM(p.production) as total_production,
    SUM(c.consumption) as total_consumption
	FROM consumption c
    INNER JOIN production p
		ON (c.country = p.country)
        AND (c.`year` = p.`year`)
	GROUP BY p.country, p.`year`
    ORDER BY p.`year` DESC, p.country;

-- d. Which energy types contribute most to emissions across all countries?
SELECT energy_type, SUM(emission) as total_emissions
	FROM emission_3
    GROUP BY energy_type
    ORDER BY total_emissions DESC;