#   When was the fist order?

SELECT
    MIN(`O`.`OrderDate`) AS `FirstOrder`
FROM
    `Orders` `O`
;
