# Soccer-Dataset: Case Study Practical



SELECT TOP (10) [player_name]
      ,[team]
      ,[date_of_birth]
      ,[age]
      ,[marital_status]
      ,[number_of_kids]
      ,[nationality]
      ,[country_of_birth]
      ,[position]
      ,[preferred_foot]
      ,[height_cm]
      ,[weight_kg]
      ,[jersey_number]
      ,[injury_status]
      ,[agent]
      ,[matches_played]
      ,[minutes_played]
      ,[goals]
      ,[assists]
      ,[tackles]
      ,[interceptions]
      ,[saves]
      ,[clean_sheets]
      ,[yellow_cards]
      ,[red_cards]
      ,[passing_accuracy]
      ,[shot_accuracy]
      ,[previous_club]
      ,[years_at_club]
      ,[contract_end_year]
      ,[average_salary_zar]
      ,[market_value_zar]
      ,[signing_bonus_zar]
      ,[release_clause_zar]
  FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
  WHERE marital_status = 'Married' ;


  --- How does select * work?
  SELECT * FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced];

--- 1. View the first 100 rows of the dataset to understand its structure.
SELECT top 100 * FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]; -- top is like limit on snowflake, use * so you can get all the columns

--- 2. Count the total number of players in the dataset.
  SELECT COUNT (*) AS Total_Players
  FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced];

--- 3. List all unique teams in the league.

SELECT DISTINCT team
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY team;


--- 4. Count how many players are in each team.

SELECT
    team,
    COUNT(*) AS players_per_team
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY players_per_team DESC, team;


--- 5. Identify the top 10 players with the most goals.

SELECT TOP (10)
    player_name,
    team,
    position,
    goals
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY goals DESC, player_name;


--- 6. Find the average salary for players in each team.

SELECT
    team,
    AVG(CAST(average_salary_zar AS DECIMAL(18,2))) AS avg_salary_zar
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY avg_salary_zar DESC;


--- 7. Retrieve the top 10 players with the highest market value.

SELECT TOP (10)
    player_name,
    team,
    CAST(market_value_zar AS DECIMAL(18,2)) AS market_value_zar
FROM  [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY market_value_zar DESC, player_name;


--- 8. Calculate the average passing accuracy for each position.

SELECT
    position,
    AVG(CAST(passing_accuracy AS FLOAT)) AS avg_passing_accuracy
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY position
ORDER BY avg_passing_accuracy DESC, position;


--- 9. Compare shot accuracy with goals to find correlations.

WITH stats AS (
    SELECT
        COUNT(*) AS n,
        SUM(CAST(shot_accuracy AS FLOAT)) AS sum_x,
        SUM(CAST(goals AS FLOAT))        AS sum_y,
        SUM(CAST(shot_accuracy AS FLOAT) * CAST(goals AS FLOAT)) AS sum_xy,
        SUM(SQUARE(CAST(shot_accuracy AS FLOAT))) AS sum_xx,
        SUM(SQUARE(CAST(goals AS FLOAT)))        AS sum_yy
    FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
)
SELECT
    CAST( (n * sum_xy - sum_x * sum_y)
          / NULLIF( SQRT( (n * sum_xx - sum_x * sum_x)
                          * (n * sum_yy - sum_y * sum_y) ), 0)
          AS DECIMAL(10,6)) AS pearson_r_shotacc_goals
FROM stats;


--- 10. Compute total goals and assists for each team.

SELECT
    team,
    SUM(CAST(goals   AS INT)) AS total_goals,
    SUM(CAST(assists AS INT)) AS total_assists
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY total_goals DESC, total_assists DESC;


--- 11. Count players by their marital status.

SELECT
    marital_status,
    COUNT(*) AS players
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY marital_status
ORDER BY players DESC, marital_status;

--- 12. Count players by nationality 
SELECT
    nationality,
    COUNT(*) AS players
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY nationality
ORDER BY players DESC, nationality;

--- 13. Find average market value grouped by nationality.

SELECT
    nationality,
    AVG(CAST(market_value_zar AS DECIMAL(18,2))) AS avg_market_value_zar
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY nationality
ORDER BY avg_market_value_zar DESC, nationality;


--- 14. Determine how many player contracts end in each year.

SELECT
    contract_end_year,
    COUNT(*) AS players
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY contract_end_year
ORDER BY contract_end_year;


--- 15. Identify players whose contracts end next year.

DECLARE @next_year INT = YEAR(GETDATE()) + 1;

SELECT
    player_name,
    team,
    contract_end_year
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE contract_end_year = @next_year
ORDER BY team, player_name;



--- 16. Summarize the number of players by injury status.

SELECT
    injury_status,
    COUNT(*) AS players
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY injury_status
ORDER BY players DESC, injury_status;


--- 17. Calculate goals per match ratio for each player.

SELECT
    player_name,
    team,
    matches_played,
    goals,
    CAST(goals * 1.0 / NULLIF(matches_played, 0) AS DECIMAL(10,4)) AS goals_per_match
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY goals_per_match DESC, goals DESC, player_name;


--- 18. Count how many players are managed by each agent.

SELECT
    agent,
    COUNT(*) AS players
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY agent
ORDER BY players DESC, agent;


--- 19. Calculate average height and weight by player position.

SELECT
    position,
    AVG(CAST(height_cm AS DECIMAL(10,2))) AS avg_height_cm,
    AVG(CAST(weight_kg AS DECIMAL(10,2))) AS avg_weight_kg
FROM [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY position
ORDER BY position;


--- 20. Identify players with the highest combined goals and assists.

SELECT TOP (10)
    player_name,
    team,
    goals,
    assists,
    (goals + assists) AS goal_contributions
FROM  [Soccer_Analysis_Db1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY goal_contributions DESC, goals DESC, player_name;



