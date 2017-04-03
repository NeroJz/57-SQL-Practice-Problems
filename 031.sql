#   Customers with no orders for EmployeeID 4

SELECT
    `C`.`CustomerID`,
    `O`.`CustomerID`
FROM
    `Customers` `C`
LEFT JOIN
    `Orders` `O` ON 1=1
        AND `O`.`CustomerID` = `C`.`CustomerID`
        AND `O`.`EmployeeID` = 4
WHERE 1=1
    AND `O`.`CustomerID` IS NULL
;


-- Or --

SELECT
    `C`.`CustomerID`
FROM
    `Customers` `C`
WHERE 1=1
    AND `C`.`CustomerID` NOT IN (
        SELECT 
            `O`.`CustomerID` 
        FROM 
            `Orders` `O` 
        WHERE 1=1
            AND `O`.`EmployeeID` = 4
    )
;


-- Or --

SELECT
    `C`.`CustomerID`
FROM
    `Customers` `C`
WHERE NOT EXISTS(
    SELECT
        *
    FROM
        `Orders` `O`
    WHERE 1=1
        AND `O`.`CustomerID` = `C`.`CustomerID`
        AND `O`.`EmployeeID` = 4
)