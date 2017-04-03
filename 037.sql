#   Orders - random assortment

SELECT
    `O`.`OrderID`
FROM
    `Orders` `O`
ORDER BY
    RAND() ASC