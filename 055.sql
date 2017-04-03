#   First Order in each country

#   Alternative 1 - We can use Derived Table
SET @count := 0;
SET @country := '';

SELECT
    DT.`ShipCountry`,
    DT.`CustomerID`,
    DT.`OrderID`,
    CONVERT(DT.`OrderDate`, DATE) AS `OrderDate`
FROM (
    SELECT
        `O`.`ShipCountry`,
        `O`.`CustomerID`,
        `O`.`OrderID`,
        `O`.`OrderDate`,
        @count := IF(@country = `O`.`ShipCountry`, @count + 1, 1) AS 'row_num',
        @country := `O`.`ShipCountry` AS 'tmp_country'
    FROM
        `Orders` `O`
    ORDER BY
        `O`.`ShipCountry`,
        `O`.`OrderID`
) DT
WHERE
    DT.`row_num` = 1
ORDER BY
    DT.`ShipCountry`
;


#   Alertnative 2 - We can use Stored Procedure
#   Stored Procedure allows definition of variables.
#   Thus, the developer can get the data by calling the stored proceudre using:
#   CALL procedure_name()


#   Step 1 - Create Stored Procedure
DELIMITER //

DROP PROCEDURE IF EXISTS CountryFirstOrder//

CREATE PROCEDURE CountryFirstOrder()
BEGIN
    SET @count := 0;
    SET @country := '';
    
    SELECT
        DT.`ShipCountry`,
        DT.`CustomerID`,
        DT.`OrderID`,
        CONVERT(DT.`OrderDate`, DATE) AS `OrderDate`
    FROM (
        SELECT
            `O`.`ShipCountry`,
            `O`.`CustomerID`,
            `O`.`OrderID`,
            `O`.`OrderDate`,
            @count := IF(@country = `O`.`ShipCountry`, @count + 1, 1) AS 'row_num',
            @country := `O`.`ShipCountry` AS 'tmp_country'
        FROM
            `Orders` `O`
        ORDER BY
            `O`.`ShipCountry`,
            `O`.`OrderID`
    ) DT
    WHERE
        DT.`row_num` = 1
    ORDER BY
        DT.`ShipCountry`
    ;
END //


#   Step 2 - CALL Store Procedure
CALL CountryFirstOrder();


