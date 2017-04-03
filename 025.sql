#   High freight charges

# Step 1 - Select ShipCountry and Freight

SELECT
    `O`.`ShipCountry`,   
    `O`.`Freight`   
FROM
    `Orders` `O`
;


# Step 2 - Average the Freight based on Country

SELECT
    `O`.`ShipCountry`,   
    AVG(`O`.`Freight`) AS `AverageFreight`  
FROM
    `Orders` `O`
GROUP BY
    `O`.`ShipCountry`
ORDER BY
    `AverageFreight` DESC
LIMIT 3
;

