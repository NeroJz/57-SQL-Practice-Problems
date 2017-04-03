#   Products that need reordering, continued

SELECT
    `P`.`ProductID`,
    `P`.`ProductName`,
    `P`.`UnitsInStock`,
    `P`.`UnitsOnOrder`,
    `P`.`UnitsInStock`,
    `P`.`Discontinued`
FROM
    `Products` `P`
WHERE 1=1
    AND (`P`.`UnitsInStock` + `P`.`UnitsOnOrder`)<= `P`.`ReorderLevel`
    AND `P`.`Discontinued` = 0
ORDER BY
    `P`.`ProductID` ASC
;