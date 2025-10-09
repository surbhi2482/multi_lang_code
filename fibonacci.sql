WITH RECURSIVE fib(n, value) AS (
  SELECT 0, 0
  UNION ALL
  SELECT 1, 1
  UNION ALL
  SELECT n + 1, value + LAG(value) OVER (ORDER BY n)
  FROM fib
  WHERE n < 9
)
SELECT * FROM fib;
