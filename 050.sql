#   Customer grouping with percentage

#   Step 1 - Get all the customer group
#   This is identical with the solution of 049.sql
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

#   Set define variable to hold the sum of all customer group
SET @totalOrders := (
    SELECT
        COUNT(1)
    FROM (
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
    ) DT
);

#   Apply the queries above as derived table 
#   and calculate the occurance of each group
SELECT
    DT.`CustomerGroup`,
    COUNT(1) AS `TotalInGroup`,
    COUNT(1) / @totalOrders AS `PercentageInGroup`
FROM (
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
) DT
GROUP BY
    DT.`CustomerGroup`
ORDER BY
    `TotalInGroup` DESC;


#   Another approach

#   It is better to create VIEW for the CustomerGroup.
#   The VIEW can be applied on the Second Query to obtain the total of the group
#   The VIEW can be applied on the Third Query to obtain the final result
#   Such approach follows the REUSABLE terminology

#   Step 1 - Create View
CREATE VIEW ViewCustomerGroup1998 AS (
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
);


#   Step 2 - Apply the view
SELECT
    `VC`.`CustomerGroup`,
    COUNT(1) AS `TotalInGroup`,
    COUNT(1) / (SELECT COUNT(1) FROM `ViewCustomerGroup1998`) AS `PercentageInGroup`
FROM
    `ViewCustomerGroup1998` `VC`
GROUP BY
    `VC`.`CustomerGroup`
ORDER BY
    `TotalInGroup` DESC;


#   Notice that the query is clean when applying the VIEW.



















