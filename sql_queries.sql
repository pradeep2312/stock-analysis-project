CREATE TABLE stock.crypto_prices (
    time VARCHAR(255),
    id BIGINT,
    amount DOUBLE,
    count INT,
    open DOUBLE,
    close DOUBLE,
    low DOUBLE,
    high DOUBLE,
    vol DOUBLE
);


-- Calculate the average closing price
SELECT AVG(close) AS avg_close_price
FROM stock.crypto_prices;

-- Find the highest trading volume
SELECT MAX(vol) AS max_volume
FROM stock.crypto_prices;

-- Count the number of transactions for a specific amount range
SELECT COUNT(*)
FROM stock.crypto_prices
WHERE amount BETWEEN 1000 AND 2000;


-- Calculate the total trading amount for each hour
SELECT HOUR(time) AS hour_of_day, SUM(amount) AS total_trading_amount
FROM stock.crypto_prices
GROUP BY HOUR(time);


-- Find the top 10 highest closing prices
SELECT time, close
FROM stock.crypto_prices
ORDER BY close DESC
LIMIT 10;

-- Calculate the average closing price for each day of the week
SELECT DAYOFWEEK(time) AS day_of_week, AVG(close) AS avg_close_price
FROM stock.crypto_prices
GROUP BY DAYOFWEEK(time);


-- Find the hour with the highest average trading volume on Mondays
SELECT HOUR(time) AS hour_of_day, AVG(vol) AS avg_volume
FROM stock.crypto_prices
WHERE DAYOFWEEK(time) = 2  -- Monday
GROUP BY HOUR(time)
ORDER BY avg_volume DESC
LIMIT 1;

-- Find the highest closing price for each hour of the day, excluding the first and last hour
SELECT HOUR(time) AS hour_of_day, MAX(close) AS max_close_price
FROM stock.crypto_prices
WHERE HOUR(time) NOT IN (0, 23)  -- Exclude first and last hour
GROUP BY HOUR(time);


-- Calculate the average trading amount for each hour of the day, for weekends (Saturday and Sunday) separately
SELECT DAYOFWEEK(time) AS day_of_week, HOUR(time) AS hour_of_day, AVG(amount) AS avg_amount
FROM stock.crypto_prices
WHERE DAYOFWEEK(time) IN (1, 7)  -- Saturday and Sunday
GROUP BY DAYOFWEEK(time), HOUR(time);

