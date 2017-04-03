#   Month-end orders

SELECT
    `O`.`EmployeeID`,
    `O`.`OrderID`,
    `O`.`OrderDate`
FROM
    `Orders` `O`
WHERE
    `O`.`OrderDate` = LAST_DAY(`O`.`OrderDate`)
ORDER BY
    `O`.`EmployeeID` ASC,
    `O`.`OrderID` ASC
;