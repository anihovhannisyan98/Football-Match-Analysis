# Football-Match-Analysis
# ⚽ Football Performance Dashboard (2021–2024)

## 📌 Overview
This project is an end-to-end football analytics pipeline that combines:
- Python – Data cleaning, transformation, and feature engineering
- MySQL – Data querying and aggregation
- Power BI – Interactive dashboard & visualization

The goal is to analyze match performance, possession trends, and league comparisons.

---

## 🎯 Key Features
- KPIs
  - Total Matches
  - Average Total Goals
  - Home Win %
- Filters (Slicers)
  - Year
  - League
  - Home Team
  - Away Team
- Visuals
  - Matches by Result (Home win / Draw / Away win)
  - Avg Total Goals by League
  - Home Win % by Possession Groups (`<40%`, 40–60%, `>60%`)
  - Goals vs. Shots on Target (line chart)

---

## 🛠 Workflow

### 1️⃣ Python (Data Preprocessing)
Used pandas, numpy, matplotlib:
- Cleaned raw dataset (handled missing values, renamed columns)
- Engineered new features:
  - Total_Goals = HomeGoals + AwayGoals
  - Result = Home Win / Away Win / Draw
  - Possession_Group = <40%, 40–60%, >60%
- Exported cleaned dataset as football_clean.csv

📂 File: python/football_analysis.ipynb

---

### 2️⃣ MySQL (Data Analysis)
Wrote SQL queries to validate and analyze:
```sql
-- Average goals per match
SELECT AVG(HomeGoals + AwayGoals) AS avg_goals
FROM football_matches;

-- Matches by result
SELECT Result, COUNT(*) AS match_count
FROM football_matches
GROUP BY Result;

-- Average goals by league
SELECT League, AVG(HomeGoals + AwayGoals) AS avg_goals
FROM football_matches
GROUP BY League;

-- Home win % by possession group
SELECT Possession_Group,
       ROUND(SUM(CASE WHEN Result='Home Win' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS home_win_pct
FROM football_matches
GROUP BY Possession_Group;
