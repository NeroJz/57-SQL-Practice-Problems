#   Products with associated supplier names


SELECT
    `P`.`ProductID`,
    `P`.`ProductName`,
    `S`.`CompanyName`
FROM
    `Products` `P`
JOIN `Suppliers` `S` ON 1=1
    AND `S`.`SupplierID` = `P`.`SupplierID`
ORDER BY `P`.`ProductID` ASC
;