#   Late orders vs. total orders - percentage

# Using the solution of 045.sql, we can compute the percentage of late order as follow

SELECT
    `E`.`EmployeeID`,
    `E`.`LastName`,
    `VTO`.`TotalOrders`,
    IFNULL(`VLO`.`LateOrders`,0) AS `LateOrders`,
    (IFNULL(`VLO`.`LateOrders`,0) / `VTO`.`TotalOrders`) AS `PercentageLateOrders`
FROM
    `Employees` `E`
LEFT JOIN
    `ViewTotalOrders` AS `VTO` ON `VTO`.`EmployeeID` = `E`.`EmployeeID`
LEFT JOIN
    `ViewLateOrders` AS `VLO` ON `VLO`.`EmployeeID` = `E`.`EmployeeID`
ORDER BY
    `E`.`EmployeeID`;