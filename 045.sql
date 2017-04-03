#   Late Orders vs. total orders - fix null

#   You can views as solution for 043.sql - 044.sql

#   Step 1 - Create view for Total late order
CREATE VIEW ViewLateOrders AS (
    SELECT
        `E`.`EmployeeID`,
        `E`.`LastName`,
        COUNT(1) AS `LateOrders`
    FROM
        `Employees` `E`
    LEFT JOIN `Orders` `O` ON `O`.`EmployeeID` = `E`.`EmployeeID`
    WHERE 1=1
        AND `O`.`ShippedDate` >= `O`.`RequiredDate`
    GROUP BY
        `E`.`EmployeeID`,
        `E`.`LastName`
);


#   Step 2 - Create view for Total Orders
CREATE VIEW ViewTotalOrders AS (
    SELECT
        `E`.`EmployeeID`,
        `E`.`LastName`,
        COUNT(1) AS `TotalOrders`
    FROM
        `Employees` `E`
    LEFT JOIN `Orders` `O` ON `O`.`EmployeeID` = `E`.`EmployeeID`
    GROUP BY
        `E`.`EmployeeID`,
        `E`.`LastName`
);

#   Step 3 - Join the Employees table with the view tables
SELECT
    `E`.`EmployeeID`,
    `E`.`LastName`,
    `VTO`.`TotalOrders`,
    `VLO`.`LateOrders`
FROM
    `Employees` `E`
LEFT JOIN
    `ViewTotalOrders` AS `VTO` ON `VTO`.`EmployeeID` = `E`.`EmployeeID`
LEFT JOIN
    `ViewLateOrders` AS `VLO` ON `VLO`.`EmployeeID` = `E`.`EmployeeID`
ORDER BY
    `E`.`EmployeeID`;


# Solution for 045.sql
# Since the joining of ViewTotalOrders and ViewLaterOrder will return NULL result
# for Employee who does not have late order, we can use IFNULL function to convert
# NULL data to the desired output.
# We can covert the NULL to O for the Employee who does not have late order in this case
SELECT
    `E`.`EmployeeID`,
    `E`.`LastName`,
    `VTO`.`TotalOrders`,
    IFNULL(`VLO`.`LateOrders`,0) AS `LateOrders`
FROM
    `Employees` `E`
LEFT JOIN
    `ViewTotalOrders` AS `VTO` ON `VTO`.`EmployeeID` = `E`.`EmployeeID`
LEFT JOIN
    `ViewLateOrders` AS `VLO` ON `VLO`.`EmployeeID` = `E`.`EmployeeID`
ORDER BY
    `E`.`EmployeeID`;


#   The solution above returns the result as identical with the solution 043.sql - 044.sql












