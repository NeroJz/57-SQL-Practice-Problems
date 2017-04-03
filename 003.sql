# Sale Representatives

SELECT
    e.FirstName,
    e.LastName,
    e.HireDate
FROM
    `Employees` e
WHERE
    LOWER(e.Title) = 'sales representatives'
;