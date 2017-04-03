#   Inventory List


SELECT
    `E`.`EmployeeID`,
    `E`.`LastName`,
    `O`.`OrderID`,
    `P`.`ProductName`,
    `OD`.`Quantity`
FROM
    `Orders` `O`
JOIN
    `Employees` `E` ON 1=1
        AND `E`.`EmployeeID` = `O`.`EmployeeID`
JOIN
    `Order_Details` `OD` ON 1=1
        AND `OD`.`OrderID` = `O`.`OrderID`
JOIN
    `Products` `P` ON 1=1
        AND `P`.`ProductID` = `OD`.`ProductID`
;