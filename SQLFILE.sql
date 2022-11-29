-- 3. Display the total number of customers based on gender who have placed orders of worth at least Rs. 3000.
select COUNT(C.CUS_GENDER), SUM(O.ORD_AMOUNT), C.CUS_GENDER 
FROM customer AS C INNER JOIN `order` AS O 
ON C.CUS_ID = O.CUS_ID AND O.ORD_AMOUNT >= 3000 
GROUP BY C.CUS_GENDER;

-- 4. Display all the order along with product name order by a customer having Customer_Idj=2.
SELECT * FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID) 
AS Supp_Pro INNER JOIN `order` AS O ON O.PRICING_ID = Supp_Pro.PRICING_ID AND O.CUS_ID = '2';

-- 5. Display the Supplier details who can supply more than one product.
SELECT S.SUPP_NAME, S.SUPP_ID, COUNT(S.SUPP_ID), SP.PRO_ID 
FROM supplier AS S INNER JOIN supplier_pricing AS SP ON S.SUPP_ID = SP.SUPP_ID GROUP BY S.SUPP_ID HAVING COUNT(S.SUPP_ID) > 1;


-- 6. Find the least expensive product from each categary and print the table with category id, name, product name and price of the product.

SELECT C.CAT_NAME, sup_pro.minSP, sup_pro.PRO_ID, sup_pro.PRO_NAME, sup_pro.CAT_ID FROM (SELECT MIN(SP.SUPP_PRICE) AS minSP, P.PRO_ID, P.PRO_NAME, CAT_ID FROM supplier_pricing AS SP INNER JOIN product AS P ON SP.PRO_ID = P.PRO_ID GROUP BY P.CAT_ID) AS sup_pro
INNER JOIN category AS C ON C.CAT_ID = sup_pro.CAT_ID;

-- 7. Display the ID and Name of the Product Ordered After "2021-10-05".
SELECT Supp_Pro.PRO_ID, Supp_Pro.PRO_NAME, O.ORD_DATE, O.ORD_ID FROM (SELECT product.PRO_NAME, product.PRO_ID, supplier_pricing.PRICING_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID = product.PRO_ID) 
AS Supp_Pro INNER JOIN `order` AS O ON O.PRICING_ID = Supp_Pro.PRICING_ID AND O.ORD_DATE > '2021-10-05';

-- 8. Display customer name and gender whose names start or end with character "A".
SELECT C.CUS_NAME, C.CUS_GENDER FROM customer AS C WHERE C.CUS_NAME LIKE 'A%' OR C.CUS_NAME LIKE '%A';

-- 9. Create a stored procedure to display id, name, rating and Type_of_Service. for Type_of_Service, if rating = 5, pring "Excellent Service", 
-- if rating >4 print "Good Service", if rating > 2 print "Average Sevice" else print "poor Service"

CALL ServiceRating();