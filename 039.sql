#   Orders - accidental double-entry details

# Using in subquery
SELECT
    `OD`.`OrderID`,
    `OD`.`ProductID`,
    `OD`.`Quantity`,
    `OD`.`UnitPrice`
FROM
    `Order_Details` `OD`
WHERE
    `OD`.`OrderID` IN (
        SELECT
            `OrderID`
        FROM
            `Order_Details`
        WHERE
            `Quantity` >= 60
        GROUP BY
            `OrderID`,
            `Quantity`
            HAVING
                COUNT(1) > 1
    )
ORDER BY
    `OD`.`ProductID`
;


# View
CREATE VIEW PotentialDuplicates AS (
    SELECT
        `OrderID`
    FROM
        `Order_Details`
    WHERE
        `Quantity` >= 60
    GROUP BY
        `OrderID`,
        `Quantity`
        HAVING
            COUNT(1) > 1
);

SELECT
    `OD`.`OrderID`,
    `OD`.`ProductID`,
    `OD`.`Quantity`,
    `OD`.`UnitPrice`
FROM
    `Order_Details` `OD`
WHERE
    `OD`.`OrderID` IN (
        SELECT 
            `orderID`
        FROM
            `PotentialDuplicates`
    )
ORDER BY
    `OD`.`ProductID`






