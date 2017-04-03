#   EMPLOYEES FULL NAME

SELECT
    `E`.`FirstName`,
    `E`.`LastName`,
    CONCAT(`E`.`FirstName`,' ', `E`.`LastName`) AS `FullName`
FROM
    `EMPLOYEES` `E`
;