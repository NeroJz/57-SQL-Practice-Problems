#   Customers with multiple orders in 5 days period

#   Solution 1 - We can use variables to store temporary data


#   Step 1
SET @count := 0;
SET @first_date := '';
SET @tmp_customer_id = '';
SET @tmp_orderID = '';


#   Step 2 - Output the data with inital order and next order
SELECT
    `O`.`OrderID`,
    `O`.`CustomerID`,
    CONVERT(`O`.`OrderDate`, DATE) AS `OrderDate`,
    CASE
        WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN 1 ELSE 0
    END AS `isWithin5Days`,
    @first_order := 
    CASE
        WHEN @tmp_customer_id = `O`.`CustomerID`
        THEN
            CASE
                WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN @first_order 
                ELSE DATE(`O`.`OrderDate`)
            END
        ELSE
            DATE(`O`.`OrderDate`)
    END AS `firstOrderDate`,
    @initial_order := 
    CASE
        WHEN @tmp_customer_id = `O`.`CustomerID`
        THEN
            CASE
                WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN @initial_order 
                ELSE `O`.`OrderID`
            END
        ELSE
            `O`.`OrderID`
    END AS `initalOrderID`,
    @tmp_customer_id := `O`.`CustomerID` AS `tmpCustomerID`
FROM
    `Orders` `O`
ORDER BY
    `O`.`CustomerID`;



#   Step 3 - Use Step 2 AS derived table to select proper data
SELECT 
    DT.`CustomerID`,
    DT.`initialOrderID` AS `InitialOrderID`,
    DT.`firstOrderDate` AS `InitialOrderDate`,
    DT.`OrderID` AS `NextOrderID`,
    DT.`OrderDate` AS `NextOrderDate`,
    DATEDIFF(DT.`OrderDate`, DT.`firstOrderDate`) AS `DaysBetween`
FROM (
    SELECT
        `O`.`OrderID`,
        `O`.`CustomerID`,
        CONVERT(`O`.`OrderDate`, DATE) AS `OrderDate`,
        CASE
            WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN 1 ELSE 0
        END AS `isWithin5Days`,
        @first_order := 
        CASE
            WHEN @tmp_customer_id = `O`.`CustomerID`
            THEN
                CASE
                    WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN @first_order 
                    ELSE DATE(`O`.`OrderDate`)
                END
            ELSE
                DATE(`O`.`OrderDate`)
        END AS `firstOrderDate`,
        @initial_order := 
        CASE
            WHEN @tmp_customer_id = `O`.`CustomerID`
            THEN
                CASE
                    WHEN DATEDIFF(DATE(`O`.`OrderDate`), @first_order) BETWEEN 1 AND 5 THEN @initial_order 
                    ELSE `O`.`OrderID`
                END
            ELSE
                `O`.`OrderID`
        END AS `initialOrderID`,
        @tmp_customer_id := `O`.`CustomerID` AS `tmpCustomerID`
    FROM
        `Orders` `O`
    ORDER BY
        `O`.`CustomerID`
) DT
WHERE
    DT.`isWithin5Days` > 0
;


-- OR --

#   Another alternative is to use self join
#   By joining the table, we can then filter and manipulate the columns
#   to generate the desired output.


#   Step 1 - Select the columns from the Orders table
#   You can use VIEW in this case since the selection is identical in self-joining
CREATE VIEW ViewOrders AS (
    SELECT
        *,
        DATEDIFF(`NextOrders`.`OrderDate`, `InitialOrders`.`OrderDate`) AS `DaysBetween`
    FROM
        `ViewOrders` `InitialOrders`
    JOIN
        `ViewOrders` `NextOrders` ON `NextOrders`.`CustomerID` = `InitialOrders`.`CustomerID`
    WHERE
        DATEDIFF(`NextOrders`.`OrderDate`, `InitialOrders`.`OrderDate`) BETWEEN 1 AND 5 AND
        `InitialOrders`.`OrderID` != `NextOrders`.`OrderID`
    ORDER BY
        `InitialOrders`.`CustomerID`,
        `InitialOrders`.`OrderID`
);


#   Step 2 - We can make use the View above for joining
SELECT
    *,
    DATEDIFF(`NextOrders`.`OrderDate`, `InitialOrders`.`OrderDate`) AS `DaysBetween`
FROM
    `ViewOrders` `InitialOrders`
JOIN
    `ViewOrders` `NextOrders` ON `NextOrders`.`CustomerID` = `InitialOrders`.`CustomerID`
ORDER BY
    `InitialOrders`.`CustomerID`,
    `InitialOrders`.`OrderID`
;


#   Step 3 - We have all the data now.  However, we need to filter unwanted records.
#   We want OrderID that is not identical for InitialOrders and NextOrders.
#   We also want the difference of OrderDate in Between 1 - 5 days for InitialOrders and NextOrders
SELECT
    `InitialOrders`.`CustomerID` AS `CustomerID`,
    `InitialOrders`.`OrderID` AS `InitialOrderID`,
    `InitialOrders`.`OrderDate` AS `InitialOrderDate`,
    `NextOrders`.`OrderID` AS `NextOrderID`,
    `NextOrders`.`OrderDate`AS `NextOrderDate`,
    DATEDIFF(`NextOrders`.`OrderDate`, `InitialOrders`.`OrderDate`) AS `DaysBetween`
FROM
    `ViewOrders` `InitialOrders`
JOIN
    `ViewOrders` `NextOrders` ON `NextOrders`.`CustomerID` = `InitialOrders`.`CustomerID`
WHERE
    DATEDIFF(`NextOrders`.`OrderDate`, `InitialOrders`.`OrderDate`) BETWEEN 1 AND 5 AND
    `InitialOrders`.`OrderID` != `NextOrders`.`OrderID`
ORDER BY
    `InitialOrders`.`CustomerID`,
    `InitialOrders`.`OrderID`
;



#   The solution 2 is more simple and easy to read compare to Solution 1












