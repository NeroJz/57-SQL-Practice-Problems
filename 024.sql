#   Customer list by region

SELECT
    `C`.`CustomerID`,
    `C`.`CompanyName`,
    `C`.`Region`
FROM
    `Customers`  `C`
ORDER BY
    (
        CASE
            WHEN `C`.`Region` IS NULL THEN 1 ELSE 0
        END
    ) ASC,
    `C`.`Region` ASC,
    `C`.`CustomerID` ASC;