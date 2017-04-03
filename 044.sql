#   Late orders vs. total orders - missing employee

#   Refer on 043.sql

SELECT
    DT.`EmployeeID`,
    DT.`LastName`,
    COUNT(DT.`OrderID`) AS `AllOrders`,
    SUM(DT.`isLateOrder`) AS `LateOrders`
FROM (
    SELECT
        `E`.`EmployeeID`,
        `E`.`LastName`,
        `O`.`OrderID`,
        CASE
            WHEN `O`.`ShippedDate` >= `O`.`RequiredDate` THEN 1 ELSE 0
        END AS `isLateOrder`
    FROM
        `Employees` `E`
    LEFT JOIN
        `Orders` `O` ON 1=1
            AND `O`.`EmployeeID` = `E`.`EmployeeID`
    ORDER BY
        `E`.`EmployeeID`
) DT
GROUP BY
    DT.`EmployeeID`,
    DT.`LastName`
;