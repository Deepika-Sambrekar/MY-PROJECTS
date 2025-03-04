SELECT 
    p.productCode, 
    p.productName, 
    p.quantityInStock, 
    COALESCE(SUM(od.quantityOrdered), 0) AS totalOrdered,
    (p.quantityInStock - COALESCE(SUM(od.quantityOrdered), 0)) AS inventoryShortage
FROM 
    mintclassics.products AS p
LEFT JOIN 
    mintclassics.orderdetails AS od ON p.productCode = od.productCode
GROUP BY 
    p.productCode, 
    p.productName, 
    p.quantityInStock
HAVING 
    inventoryShortage > 0
ORDER BY 
    inventoryShortage DESC;
