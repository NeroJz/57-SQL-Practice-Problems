#   Customer Grouping - fixing null value

#   BETWEEN ... AND clause is suitable to deal with Interger
#   More ideal solution is to use < and <= operator



SELECT
    `C`.`CustomerID`,
    `C`.`CompanyName`,
    FORMAT(IFNULL(SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)),0),2) AS `Amount`,
    CASE
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) > 0 AND SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) < 1000 THEN 'Low'
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) >= 1000 AND SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) < 5000 THEN 'Medium'
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) >= 5000 AND SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) < 10000 THEN 'High' 
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) >= 10000 THEN 'Very High' 
    END AS `CustomerGroup`
FROM
    `Customers` `C`
LEFT JOIN
    `Orders` `O` ON `O`.`CustomerID` = `C`.`CustomerID`
    AND YEAR(`O`.`OrderDate`) = 1998
LEFT JOIN
    `Order_Details` `OD` ON `OD`.`OrderID` = `O`.`OrderID`
GROUP BY
    `C`.`CustomerID`
    HAVING `Amount` > 0
;
