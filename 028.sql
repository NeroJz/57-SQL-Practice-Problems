#   High freight charges last year

#   Step 1 - Get last order
SELECT
    MAX(`O`.`OrderDate`)
FROM
    `Orders`
;


#   Step 2 - Get order for the past 12 months
SELECT
    *
FROM
    `Orders` `O`
WHERE
    `O`.`OrderDate` >= DATE_SUB(
        (
            SELECT
                MAX(`O`.`OrderDate`)
            FROM
                `Orders` `O`
        ), INTERVAL 12 MONTH
    )
;


#   Step 3 - Get the three ship countries with highes averge freight
SELECT
    `O`.`ShipCountry`,
    AVG(`O`.`Freight`) AS `AverageFreight`
FROM
    `Orders` `O`
WHERE
    `O`.`OrderDate` >= DATE_SUB(
        (
            SELECT
                MAX(`O`.`OrderDate`)
            FROM
                `Orders` `O`
        ), INTERVAL 12 MONTH
    )
GROUP BY
    `O`.`ShipCountry`
ORDER BY
    `AverageFreight` DESC
LIMIT 3
;