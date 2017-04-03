#   Sales representative in the United Stated

SELECT
    e.FirstName,
    e.LastName,
    e.HireDate
FROM
    `employees` e
WHERE 1=1
    AND LOWER(e.Title) = 'sales representative'
    AND LOWER(e.Country) = 'usa'