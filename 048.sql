#   Customer Grouping

#   Use multiple cases

SELECT
    `C`.`CustomerID`,
    `C`.`CompanyName`,
    FORMAT(IFNULL(SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)),0),2) AS `Amount`,
    CASE
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) BETWEEN 0 AND 1000 THEN 'Low'
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) BETWEEN 1001 AND 5000 THEN 'Medium'
        WHEN SUM((`OD`.`Quantity` * `OD`.`UnitPrice`)) BETWEEN 5001 AND 10000 THEN 'High' ELSE 'Very High' 
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


#   The query above includes 4 calculations (SUM((`OD`.`Quantity` * `OD`.`UnitPrice`))).  
#   The more ideal solution is to have the calculation in one place.
#   An alternative way is to Create View Or use Derived Table.