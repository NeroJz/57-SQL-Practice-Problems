#   Total Customers per country/city

SELECT
    `C`.`Country`,
    `C`.`City`,
   COUNT(2) AS `TotalCustomer`
FROM
    `Customers` `C`
GROUP BY
    `C`.`Country`,
    `C`.`City`
ORDER BY
    COUNT(2) DESC;