#   OrderDetails amount per line item

SELECT
    `OD`.`OrderID`,
    `OD`.`ProductID`,
    `OD`.`UnitPrice`,
    `OD`.`Quantity`,
    FORMAT((`OD`.`UnitPrice` * `OD`.`Quantity`),2) AS `TotalPrice`
FROM
    `Order_Details` `OD`