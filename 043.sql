#   Late Orders VS. total Orders


SELECT
    DT.EmployeeID,
    DT.LastName,
    COUNT(DT.OrderID) AS 'AllOrders',
    SUM(DT.isDelayed) AS 'LateOrders'
FROM
    (
        SELECT
            `E`.`EmployeeID`,
            `E`.`LastName`,
            `O`.`OrderID`,
            CASE
                WHEN `O`.`ShippedDate` >= `O`.`RequiredDate` THEN 1 ELSE 0
            END  AS `isDelayed`
        FROM
            `Employees` `E`
        JOIN `Orders` `O` ON 1=1
            AND `O`.`EmployeeID` = `E`.`EmployeeID`
    ) DT
GROUP BY
    DT.EmployeeID