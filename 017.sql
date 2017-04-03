#   Contact titles for customers

SELECT
    `C`.`ContactTitle`,
    COUNT(`C`.`ContactTitle`) AS `TotalContactTitle`
FROM
    `Customers` `C`
GROUP BY
    `C`.`ContactTitle`
ORDER BY
    `TotalContactTitle` DESC,
    `C`.`ContactTitle` ASC
;


-- OR --


SELECT
    `C`.`ContactTitle`,
    COUNT(1) AS `TotalContactTitle`
FROM
    `Customers` `C`
GROUP BY 1                      # 1 means 1st Column
ORDER BY 2 DESC, 1 ASC          # 1 means 1st Column, 2 means 2nd Column