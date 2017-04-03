#   Orders with many line

SELECT
    `O`.`OrderID`,
    COUNT(1)
FROM 
    `Orders` `O`
JOIN 
    `Order_Details` `OD` ON 1=1
        AND `OD`.`OrderID` = `O`.`OrderID`
GROUP BY
    `O`.`OrderID`
ORDER BY 2 DESC
LIMIT 10;