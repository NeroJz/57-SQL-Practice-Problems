#   High-value customers who have at 1 order is equal to $10,000 or more

SELECT
    `C`.`CustomerID`,
    `C`.`CompanyName`,
    `O`.`OrderID`,
    SUM((`OD`.`UnitPrice` * `OD`.`Quantity`)) as `Amount`
FROM
    `Customers` `C`
JOIN
    `Orders` `O` ON 1=1
        AND `O`.`CustomerID` = `C`.`CustomerID`
JOIN
    `Order_Details` `OD` ON 1=1
        AND `OD`.`OrderID` = `O`.`OrderID`
WHERE 1=1
    AND `O`.`OrderDate` >= '19970101'
    AND `O`.`OrderDate` < '19980101'
GROUP BY
    `C`.`CustomerID`,
    `O`.`OrderID`
    HAVING
        `Amount` >= 10000
ORDER BY
    `Amount` DESC
;