#   Products that need reordering

SELECT
    `P`.`ProductID`,
    `P`.`ProductName`,
    `P`.`UnitsInStock`,
    `P`.`ReorderLevel`
FROM
    `Products` `P`
WHERE
    `P`.`UnitsInStock` <= `P`.`ReorderLevel`
ORDER BY
    `P`.`ProductID` ASC
;