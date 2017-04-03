#   Categories, and the total products in each category

SELECT
    `C`.`CategoryName`,
--    `P`.`CategoryID`,
    COUNT(`P`.`CategoryID`) AS `TotalProducts`
FROM
    `Products` `P`
JOIN `Categories` `C` ON 1=1
    AND `C`.`CategoryID` = `P`.`CategoryID`
GROUP BY
    `P`.`CategoryID`
ORDER BY
    `TotalProducts` DESC;


-- OR --

SELECT
    `C`.`CategoryName`,
    COUNT(1) AS `TotalProducts`
FROM
    `Products` `P`
JOIN `Categories` `C` ON 1=1
    AND `C`.`CategoryID` = `P`.`CategoryID`
GROUP BY
    `C`.`CategoryName`
ORDER BY
    COUNT(1) DESC;