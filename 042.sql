#   Late orders - which employee?


SELECT
    `E`.`EmployeeID`,
    `E`.`FirstName`,
    `E`.`LastName`,
    `O`.`OrderID`,
    `O`.`OrderDate`,
    `O`.`ShippedDate`,
    `O`.`RequiredDate`,
    COUNT(1) AS `TotalOrder`
FROM
    `Employees` `E`
JOIN
    `Orders` `O` ON 1=1
        AND `O`.`EmployeeID` = `E`.`EmployeeID`
        AND `ShippedDate` >= `RequiredDate`
GROUP BY
    `EmployeeID`,
    `LastName`
        HAVING `TotalOrder` > 1
ORDER BY
    `TotalOrder` DESC
;