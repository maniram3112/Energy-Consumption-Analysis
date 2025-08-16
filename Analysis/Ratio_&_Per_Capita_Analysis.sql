use energy_consumption_db;

-- a. What is the emission-to-GDP ratio for each country by year?
SELECT e.country, e.`year`,
	e.energy_type, e.emission,
    g.`Value` as GDP_value,
    (e.emission/g.`Value`) as emission_GDP_ratio
	FROM emission_3 e
    INNER JOIN gdp_3 g
		ON (e.country = g.country)
        AND (e.`year`  = g.`year`)
	ORDER BY e.country, e.`year`;

-- 2. What is the energy consumption per capita for each country over the last decade?
SELECT c.country, c.`year`, c.energy, c.consumption, p.`Value`,
	(c.consumption/p.`Value`) as consumption_per_capita
	FROM consumption c
    INNER JOIN population p
		ON c.country = p.countries
        AND c.`year` = p.`year`
	WHERE c.`year` >= (
		SELECT MAX(`year`) - 10 FROM consumption)
	ORDER BY c.country, c.`year`;

-- 3. How does energy production per capita vary across countries?
SELECT pr.country, pr.`year`, pr.energy, pr.production, p.`Value`,
	(pr.production/p.`Value`) AS production_per_capita
	FROM production pr
    INNER JOIN population p
		ON pr.country = p.countries
        AND pr.`year` = p.`year`
	ORDER BY pr.country, pr.`year`;

-- 4. Which countries have the highest energy consumption relative to GDP?
SELECT c.country, c.`year`, c.energy, c.consumption, g.`Value`,
	(c.consumption/g.`Value`) AS consumption_per_GDP
    FROM consumption c
    INNER JOIN gdp_3 g
		ON c.country = g.country
        AND c.`year` = g.`year`
	ORDER BY consumption_per_GDP DESC
    LIMIT 10;

-- 5. What is the correlation between GDP growth and energy production growth?
WITH gdp_growth AS (
    SELECT g1.Country,
           g1.year,
           ((g1.Value - g2.Value) / g2.Value) * 100 AS gdp_growth
    FROM gdp_3 g1
    JOIN gdp_3 g2
      ON g1.Country = g2.Country
     AND g1.year = g2.year + 1
),
prod_growth AS (
    SELECT p1.country,
           p1.year,
           ((p1.production - p2.production) / p2.production) * 100 AS prod_growth
    FROM production p1
    JOIN production p2
      ON p1.country = p2.country
     AND p1.year = p2.year + 1
),
joined AS (
    SELECT g.country,
           g.year,
           g.gdp_growth,
           p.prod_growth
    FROM gdp_growth g
    JOIN prod_growth p
      ON g.country = p.country
     AND g.year = p.year
)
SELECT 
    j.country,
    ROUND(AVG(j.gdp_growth), 2) AS avg_gdp_growth,
    ROUND(AVG(j.prod_growth), 2) AS avg_prod_growth,
    ROUND(
        (AVG(j.gdp_growth * j.prod_growth) 
         - (AVG(j.gdp_growth) * AVG(j.prod_growth)))
        / (STDDEV_POP(j.gdp_growth) * STDDEV_POP(j.prod_growth)),
        4
    ) AS correlation
	FROM joined j
	GROUP BY j.country
	-- ORDER BY correlation DESC;