#   Orders and the Shipper thas was used

SELECT
    `O`.`OrderID`,
    CONVERT(`O`.`OrderDate`, DATE) AS `OrderDate`,
    `S`.`CompanyName`
FROM
    `Orders` `O`
JOIN `Shippers` `S` ON 1=1
    AND `S`.`ShipperID` = `O`.`ShipVia`
WHERE
    `O`.`OrderID` < 10300
;