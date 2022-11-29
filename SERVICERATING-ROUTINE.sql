CREATE DEFINER=`root`@`localhost` PROCEDURE `ServiceRating`()
BEGIN
-- Create a stored procedure to display id, name, rating and Type_of_Service.
-- for Type_of_Service, if rating = 5, pring "Excellent Service", if rating >4 print "Good Service", if rating > 2 print "Average Sevice" else print "poor Service"

SELECT SOP.SUPP_ID, R.RAT_RATSTARS,
CASE
WHEN R.RAT_RATSTARS = 5 THEN 'EXCELLENT SERVICE'
WHEN R.RAT_RATSTARS > 4 THEN 'GOOD SERVICE'
WHEN R.RAT_RATSTARS > 2 THEN 'AVERAGE SERVICE'
else 'POOR SERVICES'
END AS Type_of_Service
FROM (SELECT SUPP_pro.SUPP_ID, O.ORD_ID 
FROM (SELECT supplier_pricing.PRICING_ID, supplier_pricing.SUPP_ID FROM supplier_pricing INNER JOIN product ON supplier_pricing.PRO_ID= product.PRO_ID) As Supp_Pro
INNER JOIN `order` AS O ON O.PRICING_ID = Supp_Pro.PRICING_ID) AS SOP
INNER JOIN rating AS R ON R.ORD_ID = SOP.ORD_ID;
END