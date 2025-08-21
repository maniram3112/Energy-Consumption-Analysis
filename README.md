# SQL Data Analysis: Global Emissions & GDP

## Project Overview

This project focuses on analyzing the relationship between **carbon emissions, GDP, and population trends** across countries over time using SQL. The analysis aims to derive insights into global emission patterns, economic efficiency, and environmental impact.

By combining multiple datasets (emissions, GDP, and population), the project highlights:

* Global emission shares by country.
* Trends in emission-to-GDP ratios.
* Identification of efficient economies (high GDP, low emissions).
* Per capita emissions analysis.
* Impact of population on emissions.
* Top and bottom contributors to global emissions.

---

## Dataset Details

* **Emissions Dataset (`emission_3`)** – Contains total and per capita emissions by country and year.
* **GDP Dataset (`gdp_3`)** – Contains annual GDP values of countries.
* **Population Dataset (`population_3`)** – Contains yearly population data.

---

## Key Analysis Questions (Use Cases)

1. What is the global share of emissions by each country?
2. What is the trend of emission-to-GDP ratio over years?
3. Which countries show high GDP but low emissions (efficient economies)?
4. Which countries show high emissions per capita?
5. How do population trends impact emissions?
6. Who are the top 5 and bottom 5 contributors to emissions globally?

---

## Tech Stack

* **SQL (MySQL / PostgreSQL)** – Core analysis.
* **Excel / Tableau / Power BI (optional)** – For visualization.
* **GitHub** – Version control and collaboration.

---

## Sample Queries

### Emission-to-GDP Ratio

```sql
SELECT e.country, e.year, e.emission, g.Value AS GDP_value, 
       (e.emission / g.Value) AS emission_GDP_ratio
FROM emission_3 e
JOIN gdp_3 g 
     ON e.country = g.country 
    AND e.year = g.year
ORDER BY e.country, e.year;
```

### Top 5 and Bottom 5 Emitters

```sql
SELECT country, SUM(emission) AS total_emission
FROM emission_3
GROUP BY country
ORDER BY total_emission DESC
LIMIT 5;

SELECT country, SUM(emission) AS total_emission
FROM emission_3
GROUP BY country
ORDER BY total_emission ASC
LIMIT 5;
```

### Change in Per Capita Emissions (10-Year Comparison)

```sql
SELECT e1.country, e1.energy_type,
       e1.per_capita_emission AS emission_10yrs_ago,
       e2.per_capita_emission AS emission_now,
       (e1.per_capita_emission - e2.per_capita_emission) AS reduction
FROM emission_3 e1
JOIN emission_3 e2
     ON e1.country = e2.country
    AND e1.year = (SELECT MIN(year) FROM emission_3)
    AND e2.year = (SELECT MAX(year) FROM emission_3)
ORDER BY reduction DESC;
```

---

## Key Findings

* Developed nations often show **higher emissions per capita** despite efficient economies.
* Emerging economies are **increasing their global share of emissions**.
* Population growth strongly impacts total emissions, but **efficiency improves with higher GDP per capita**.
* Some countries demonstrate **sustainable growth** (high GDP, relatively low emissions).

---

## Business Insights & Recommendations

* Encourage **green policies** in high-GDP, high-emission countries.
* Support **renewable energy adoption** in emerging economies.
* Promote **carbon efficiency benchmarking** across nations.
* Invest in **population-aware emission reduction strategies**.

---

## Challenges Faced

* Data inconsistencies across multiple datasets (emission, GDP, population).
* Missing values and misaligned country names.
* Handling different units of measurement (GDP in USD, emissions in MT, population in billions).
* Optimizing SQL queries for performance.

---

## Conclusion

This project demonstrates how SQL can be leveraged for **real-world data analysis** to answer **sustainability and economic questions**. It highlights the **trade-offs between growth and environment** and provides actionable insights for policymakers, businesses, and researchers.

---

## Q\&A

Feel free to explore the queries and suggest improvements! Contributions are welcome.

---

If you like this project, don’t forget to ⭐ **star this repo** on GitHub!

---