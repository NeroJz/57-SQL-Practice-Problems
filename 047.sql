#   Late orders vs. total orders - fix decimal
#   use FORMAT(value, digit) to format the data

SELECT
    `E`.`EmployeeID`,
    `E`.`LastName`,
    `VTO`.`TotalOrders`,
    IFNULL(`VLO`.`LateOrders`,0) AS `LateOrders`,
    FORMAT((IFNULL(`VLO`.`LateOrders`,0) / `VTO`.`TotalOrders`),2) AS `PercentageLateOrders`
FROM
    `Employees` `E`
LEFT JOIN
    `ViewTotalOrders` AS `VTO` ON `VTO`.`EmployeeID` = `E`.`EmployeeID`
LEFT JOIN
    `ViewLateOrders` AS `VLO` ON `VLO`.`EmployeeID` = `E`.`EmployeeID`
ORDER BY
    `E`.`EmployeeID`;