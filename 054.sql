#   Countries with total suppliers or customers 

#   Step 1 - Create VIEW for total suppliers and customers
CREATE VIEW ViewTotalSuppliers AS (SELECT
    `S`.`Country`,
    COUNT(1) AS `TotalSuppliers`
FROM
    `Suppliers` `S`
GROUP BY
    `S`.`Country`
ORDER BY `S`.`Country`);
    
    
CREATE VIEW ViewTotalCustomers AS (SELECT
    `C`.`Country`,
    COUNT(1) AS `TotalCustomers`
FROM
    `Customers` `C`
GROUP BY
    `C`.`Country`
ORDER BY `C`.`Country`);


#   Step 2 - Get the total customers and supplier by joining both views
#   It is important to highlight that both views have different number of records.
#   Some countries appear on one view may not appear on another view.
#   Therefore, it is recommend to join both views in vice-versa

#   First View1 LEFT JOIN with View2
SELECT
    `VTS`.`Country`,
    `VTS`.`TotalSuppliers`,
    IFNULL(`VTC`.`TotalCustomers`, 0) AS `TotalCustomers`
FROM
    `ViewTotalSuppliers` `VTS`
LEFT JOIN `ViewTotalCustomers` `VTC` ON `VTC`.`Country` = `VTS`.`Country`

#   Then View2 LEFT JOIN with View 1
SELECT
    `VTC`.`Country`,
    IFNULL(`VTS`.`TotalSuppliers`,0) AS `TotalSuppliers`,
    `VTC`.`TotalCustomers`
FROM
    `ViewTotalCustomers` `VTC`
LEFT JOIN `ViewTotalSuppliers` `VTS` ON `VTS`.`Country` = `VTC`.`Country`
ORDER BY `Country`
;


#   Step 3 - Union both Queries above
SELECT
    `VTS`.`Country`,
    `VTS`.`TotalSuppliers`,
    IFNULL(`VTC`.`TotalCustomers`, 0) AS `TotalCustomers`
FROM
    `ViewTotalSuppliers` `VTS`
LEFT JOIN `ViewTotalCustomers` `VTC` ON `VTC`.`Country` = `VTS`.`Country`
UNION
SELECT
    `VTC`.`Country`,
    IFNULL(`VTS`.`TotalSuppliers`,0) AS `TotalSuppliers`,
    `VTC`.`TotalCustomers`
FROM
    `ViewTotalCustomers` `VTC`
LEFT JOIN `ViewTotalSuppliers` `VTS` ON `VTS`.`Country` = `VTC`.`Country`
ORDER BY `Country`
;


#   The ideal solution is to use FULL OUTER JOIN.  
#   However, MYSQL does not support FULL OUTER JOIN.







