#   Orders shipping to any country in Latin America


SELECT
    `O`.`OrderID`,
    `O`.`CustomerID`,
    `O`.`ShippingCountry`
FROM
    `Orders` `O`
WHERE 1=1
    AND `O`.`ShipCountry` IN ("Brazil", "Mexico", "Argentina", "Venzuela")
;