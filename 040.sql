#   Orders - accidental double-entry details, derived table

SELECT
    `OD`.`OrderID`,
    `OD`.`ProductID`,
    `OD`.`UnitPrice`,
    `OD`.`Quantity`
FROM
    `Order_Details` `OD`
JOIN
    (
        SELECT
            `OD`.`OrderID`
        FROM
            `Order_Details` `OD`
        WHERE
            `OD`.`Quantity` >= 60
        GROUP BY
            `OD`.`OrderID`,
            `OD`.`Quantity`
                HAVING
                    COUNT(1) > 1
    ) tmp ON tmp.`OrderID` = `OD`.`OrderID`
;