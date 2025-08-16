USE energy_consumption_db;

-- a. What are the top 10 countries by population and how do their emissions compare?
SELECT p.countries AS country,
	p.value AS population,
    e.emission
	FROM population p
	JOIN emission_3 e 
	  ON p.countries = e.country
	  AND p.year = (SELECT MAX(year) FROM population p2 WHERE p2.countries = p.countries)
	  AND e.year = (SELECT MAX(year) FROM emission_3 e2 WHERE e2.country = e.country)
	ORDER BY p.value DESC
	LIMIT 10;

-- b. Which countries have improved (reduced) their per capita emissions the most over the last decade?
SELECT 
    e1.country, e1.energy_type,
    e1.per_capita_emission AS emission_10yrs_ago,
    e2.per_capita_emission AS emission_now,
    (e1.per_capita_emission - e2.per_capita_emission) AS reduction
	FROM emission_3 e1
	JOIN emission_3 e2
		ON e1.country = e2.country
	   AND e1.year = (SELECT MIN(year) FROM emission_3)
	   AND e2.year = (SELECT MAX(year) FROM emission_3)
	ORDER BY reduction DESC;
	-- LIMIT 10;

-- c. What is the global share (%) of emissions by country?
SELECT 
    country,
    SUM(emission) AS total_emission,
    (SUM(emission) * 100.0 / (SELECT SUM(emission) FROM emission_3)) AS global_share_percent
	FROM emission_3
	GROUP BY country
	ORDER BY global_share_percent DESC;

-- d. What is the global average GDP, emission, and population by year?
SELECT 
    g.year,
    AVG(g.Value) AS avg_gdp,
    AVG(e.emission) AS avg_emission,
    AVG(p.Value) AS avg_population
	FROM gdp_3 g
	JOIN emission_3 e 
		ON g.Country = e.country AND g.year = e.year
	JOIN population p
		ON g.Country = p.countries AND g.year = p.year
	GROUP BY g.year
	ORDER BY g.year;