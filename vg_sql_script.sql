-- First let's check the what's in the data 
SELECT *
FROM sales.dbo.video_games_sale;



-- with common table expression creating a temporary table and grouping the rows with same data that will be numbered in a new column rn and then deleting those duplicates
WITH Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY title, console,developer, release_date
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM sales.dbo.video_games_sale
)
DELETE FROM Duplicates
WHERE rn > 1;



-- removing leading and trailing unneccssary white spaces using trim function
UPDATE sales.dbo.video_games_sale
SET
    title = LTRIM(RTRIM(title)),
    console = LTRIM(RTRIM(console)),
    genre = LTRIM(RTRIM(genre)),
    publisher = LTRIM(RTRIM(publisher)),
    developer = LTRIM(RTRIM(developer));



-- replacing the nulls in sales data to zero
UPDATE sales.dbo.video_games_sale
SET
    total_sales  = ISNULL(total_sales, 0),
    na_sales     = ISNULL(na_sales, 0),
    jp_sales     = ISNULL(jp_sales, 0),
    pal_sales    = ISNULL(pal_sales, 0),
    other_sales  = ISNULL(other_sales, 0);


-- Making all console values uppercase
UPDATE sales.dbo.video_games_sale
SET console = UPPER(console);


-- updating the critic score's inconsistent value with nulls
UPDATE sales.dbo.video_games_sale
SET critic_score = Null
WHERE
    TRY_CAST(critic_score AS FLOAT) IS NULL AND critic_score IS NOT NULL
    OR TRY_CAST(critic_score AS FLOAT) < 0
    OR TRY_CAST(critic_score AS FLOAT) > 10;



-- previewing the data where one of these columns are missing( 17 only)
SELECT *
FROM sales.dbo.video_games_sale
WHERE
    title IS NULL OR title = ''
    OR console IS NULL OR console = ''
    OR genre IS NULL OR genre = ''
    OR publisher IS NULL OR publisher = ''
    OR developer IS NULL OR developer = '';

DELETE FROM sales.dbo.video_games_sale
WHERE
    title IS NULL OR title = ''
    OR console IS NULL OR console = ''
    OR genre IS NULL OR genre = ''
    OR publisher IS NULL OR publisher = ''
    OR developer IS NULL OR developer = '';

















