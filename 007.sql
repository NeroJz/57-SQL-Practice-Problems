#   Products with "queso" in ProductName

SELECT
    `p`.`ProductID`,
    `p`.`ProductName`
FROM
    `Products` `p`
WHERE 1=1
    AND `p`.`ProductName` LIKE '%queso%'
;