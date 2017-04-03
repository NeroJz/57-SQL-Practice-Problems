#   Supplier and ContactTitles

SELECT
    S.SupplierID,
    S.ContactName,
    S.ContactTitle
FROM
    `Suppliers` S
WHERE 1=1
  --  AND S.ContactTitle <> 'Marketing Manager'
    AND S.ContactTitle != 'Marketing Manager'
;