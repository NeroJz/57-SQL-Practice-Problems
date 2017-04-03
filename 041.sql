#   Late orders

SELECT
    `O`.`OrderID`,
    CONVERT(`O`.`OrderDate`, DATE) AS `OrderDate`,
    CONVERT(`O`.`RequiredDate`,DATE) AS `RequiredDate`,
    CONVERT(`O`.`ShippedDate`, DATE) AS `ShippedDate`
FROM
    `Orders` `O`
WHERE
    `ShippedDate` > `RequiredDate`
;