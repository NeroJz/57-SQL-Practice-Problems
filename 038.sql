#   Orders - accidental double-entry

SELECT
    `OrderID`
FROM
    `Order_Details`
WHERE
    `Quantity` >= 60
GROUP BY
    `OrderID`,
    `Quantity`
    HAVING
        COUNT(1) > 1