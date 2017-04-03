#   Customers with no orders


#   Step 1 - Select the customers with or without order
#   Left JOIN - return all the data from the left, null result
#   if there's no match on the right side

    
SELECT
    `C`.`CustomerID`,
    `O`.`OrderID`
FROM
    `Customers` `C`
LEFT JOIN 
    `Orders` `O` ON 1=1
        AND `O`.`CustomerID` = `C`.`CustomerID`;


#   Step 2 - Return all the data there is NULL on the right side
    
SELECT
    `C`.`CustomerID`,
    `O`.`OrderID`
FROM
    `Customers` `C`
LEFT JOIN 
    `Orders` `O` ON 1=1
        AND `O`.`CustomerID` = `C`.`CustomerID`
WHERE
    `O`.`OrderID` IS NULL
;