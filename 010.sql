#   Employees, in order of age

SELECT
    `E`.`FirstName`,
    `E`.`LastName`,
    `E`.`Title`,
    `E`.`BirthDate`
FROM
    `Employees` `E`
ORDER BY
    `E`.`BirthDate` ASC
;