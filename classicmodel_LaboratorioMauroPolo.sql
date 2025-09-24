SELECT officeCode, phone
FROM offices;
 
SELECT employeeNumber, lastName, firstName, email
FROM employees
WHERE email LIKE '%.es';
 
SELECT customerNumber, customerName, city, state
FROM customers
WHERE state IS NULL;
 
SELECT customerNumber
FROM payments
WHERE amount > 20000;
 
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 20000
  AND YEAR(paymentDate) = 2005;
 
SELECT DISTINCT productCode
FROM orderdetails;
 
SELECT country, COUNT(o.orderNumber) AS total_pedidos
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY country;
 
 
SELECT productLine, LENGTH(textDescription) AS longitud
FROM productlines
ORDER BY longitud DESC
LIMIT 1;
 
SELECT e.officeCode, COUNT(DISTINCT c.customerNumber) AS total_clientes
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.officeCode;
 
SELECT DAYNAME(o.orderDate) AS dia_semana, COUNT(*) AS total_ventas
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Classic Cars'
GROUP BY dia_semana
ORDER BY total_ventas DESC
LIMIT 1;
 
SELECT officeCode,
       city,
       CASE 
            WHEN territory IS NULL OR territory = 'NA' THEN 'USA'
            ELSE territory
       END AS territory_corrected
FROM offices;
 
SELECT YEAR(o.orderDate) AS anio,
       MONTH(o.orderDate) AS mes,
       AVG(od.quantityOrdered * od.priceEach) AS promedio_carrito,
       SUM(od.quantityOrdered) AS total_articulos
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE (e.lastName = 'Patterson')
  AND YEAR(o.orderDate) IN (2004, 2005)
GROUP BY anio, mes;
 
 
SELECT anio, mes,
       AVG(total_carrito) AS promedio_carrito,
       SUM(total_items) AS total_articulos
FROM (
    SELECT YEAR(o.orderDate) AS anio,
           MONTH(o.orderDate) AS mes,
           o.orderNumber,
           SUM(od.quantityOrdered * od.priceEach) AS total_carrito,
           SUM(od.quantityOrdered) AS total_items
    FROM customers c
    JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE e.lastName = 'Patterson'
      AND YEAR(o.orderDate) IN (2004, 2005)
    GROUP BY anio, mes, o.orderNumber
) AS sub
GROUP BY anio, mes;
 
SELECT DISTINCT e.officeCode
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.state IS NULL;