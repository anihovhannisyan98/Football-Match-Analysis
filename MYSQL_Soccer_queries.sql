-- Core SQL for Football Match Analysis

-- 1) Outcome distribution
SELECT Result, COUNT(*) AS Matches
FROM soccer_matches_sample
GROUP BY Result;

-- 2) Average goals by league
SELECT League, ROUND(AVG(Home_Goals + Away_Goals), 2) AS Avg_Total_Goals
FROM soccer_matches_sample
GROUP BY League
ORDER BY Avg_Total_Goals DESC;

-- 3) Home advantage (points per game)
SELECT ROUND(AVG(
  CASE WHEN Result='H' THEN 3 WHEN Result='D' THEN 1 ELSE 0 END
), 3) AS Home_PPG
FROM soccer_matches_sample;

-- 4) Correlation proxy: shots on target vs goals (home)
SELECT ShotsOnTarget_Home, ROUND(AVG(Home_Goals),3) AS Avg_Home_Goals
FROM soccer_matches_sample
GROUP BY ShotsOnTarget_Home
ORDER BY ShotsOnTarget_Home;

-- 5) Possession buckets vs win rate (home)
SELECT
  CASE
    WHEN Possession_Home < 40 THEN '<40'
    WHEN Possession_Home BETWEEN 40 AND 60 THEN '40-60'
    ELSE '>60'
  END AS Poss_Bucket,
  ROUND(AVG(CASE WHEN Result='H' THEN 1 ELSE 0 END), 3) AS Home_Win_Rate
FROM soccer_matches_sample
GROUP BY Poss_Bucket
ORDER BY Poss_Bucket;
