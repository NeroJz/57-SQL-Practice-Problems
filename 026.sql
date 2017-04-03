#   High freight charges - 1996

SELECT
    `O`.`ShipCountry`,   
    AVG(`O`.`Freight`) AS `AverageFreight`  
FROM
    `Orders` `O`
WHERE
    YEAR(`O`.`OrderDate`) = 1997
GROUP BY
    `O`.`ShipCountry`
ORDER BY
    `AverageFreight` DESC
;
