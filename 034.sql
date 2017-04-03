#   High-value customers with discount

SELECT
    `C`.`CustomerID`,
    `C`.`CompanyName`,
    SUM((`OD`.`UnitPrice` * `OD`.`Quantity`)) as `Total`,
    SUM((`OD`.`UnitPrice` * `OD`.`Quantity`) * (1 - `OD`.`Discount`)) as `TotalWithDiscount`
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
    `C`.`CompanyName`   
        HAVING
            `TotalWithDiscount` >= 15000
ORDER BY
    `TotalWithDiscount` DESC
;
