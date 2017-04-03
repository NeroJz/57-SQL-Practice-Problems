#   Orders placed by specific EmployeeID

SELECT
    o.OrderID,
    o.OrderDate
FROM
    `Orders` o
WHERE 1=1
    AND o.EmployeeID = 5