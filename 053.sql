#   Countries with supplier or customers
#   An alternative is use FULL OUTER JOIN
#   However, MYSQL does not support FULL OUTER JOIN

SELECT
    S.`Country` AS `SupplierCountry`,
    C.`Country` AS `CustomerCountry`
FROM
    (SELECT DISTINCT `Country` FROM `Suppliers` ORDER BY `Country`) S
LEFT JOIN
    (SELECT DISTINCT `Country` FROM `Customers` ORDER BY `Country`) C ON C.`Country` = S.`Country`
UNION
SELECT
    S.`Country` AS `SupplierCountry`,
    C.`Country` AS `CustomerCountry`
FROM
    (SELECT DISTINCT `Country` FROM `Suppliers` ORDER BY `Country`) S
RIGHT JOIN
    (SELECT DISTINCT `Country` FROM `Customers` ORDER BY `Country`) C ON C.`Country` = S.`Country`