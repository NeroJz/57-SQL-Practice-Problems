#   Countries where there are customers

SELECT
    DISTINCT(`C`.`Country`) AS `Country`
FROM
    `Customers` `C`
;


-- OR --

SELECT
    `C`.`Country`
FROM
    `Customers` `C`
GROUP BY
    `C`.`Country`
;