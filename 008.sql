#   Orders Shippng to France or Belgium

SELECT
    `O`.`OrderID`,
    `O`.`CustomerID`,
    `O`.`ShipCountry`
FROM
    `Orders` `O`
WHERE 1=1
    AND  (
        `O`.`ShipCountry` = 'France' OR 
        `O`.`ShipCountry` = 'Belgium'
    )
;