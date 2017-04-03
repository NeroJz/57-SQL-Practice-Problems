#   Countries with suppliers or customers

#   We need to output the distinct countries from both tables 
#   but avoid duplicated country in the result
#   UNION provides this feature

SELECT 
    DISTINCT(`Country`)
FROM 
    `Suppliers` 
UNION
SELECT 
    DISTINCT(`Country`)
FROM 
    `Customers`
ORDER BY
    `Country`