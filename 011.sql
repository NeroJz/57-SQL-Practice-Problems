#   Showing only Date with a DateTime Field

SELECT
    `E`.`FirstName`,
    `E`.`LastName`,
    `E`.`Title`,
    DATE(`E`.`BirthDate`) AS `DateOnlyBirthDate`
FROM
    `Employees` `E`
ORDER BY
    `E`.`BirthDate` ASC
;