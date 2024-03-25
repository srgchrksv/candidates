

-- INSERT INTO dim_date (date, day, month, year) SELECT '2023-01-01', 1, 2, 3 WHERE NOT EXISTS ( SELECT date FROM dim_date WHERE date = '2023-01-01');

SELECT * FROM dim_date;