-- To check NUll values in the dataset
SELECT order_ID
FROM orders_data
WHERE order_ID IS NULL;
SELECT customer_name
FROM orders_data
WHERE customer_name IS NULL;
SELECT Restaurant_ID
from orders_data
WHERE Restaurant_ID IS NULL;
SELECT order_date
from orders_data
WHERE order_date IS null;
SELECT Quantity_of_items
from orders_data
where Quantity_of_items IS NULL;
select Order_Amount
from orders_data
where Order_Amount IS NULL;
SELECT Payment_Mode
from orders_data
where Payment_Mode IS NULL;
SELECT Delivery_time_taken_mins
from orders_data
where Delivery_time_taken_mins is null;
SELECT Customer_Rating_Food
FROM orders_data
where Customer_Rating_Food is null;
select Customer_Rating_Delivery
from orders_data
where Customer_Rating_Delivery IS NULL;
SELECT Order_time
FROM orders_data
WHERE order_time IS NULL;

-- To check NULL VALE in restaurants_data
select RestaurantID
from restaurants_data
WHERE RestaurantID is null;
select RestaurantName
from restaurants_data
where RestaurantName IS null;
select Cuisine
from restaurants_data
where cuisine is null;
select zone
from restaurants_data
where zone is null;
select category
from restaurants_data
where Category is null;

-- total summary of the anaylsis
SELECT SUM(order_Amount) AS 'Total order'
from orders_data;
SELECT SUM(Quantity_of_items) AS 'Total item sold'
from orders_data;
Select AVG(Delivery_time_taken_mins) AS 'Avgerage Delivery Time'
from orders_data;
select AVG(Customer_Rating_Food) AS 'Avgerage Rating Food'
from orders_data;
Select count(cuisine) AS 'Number of Cusine'
from restaurants_data;


--  Payment mmode
-- Mode of payment by COD
SELECT count(Payment_Mode) AS "Total no COD"
FROM orders_data
Where Payment_Mode ="Cash on Delivery" ;




-- Join the two two tables together 
select * 
from Orders_Data 
inner join restaurants_data 
on orders_data.Restaurant_ID = restaurants_data.RestaurantID;

-- 6. To  get the amount of customers in each zone.
With Order_TABLE as (
SELECT RestaurantName,
        Cuisine, 
        Zone, 
        Category, 
		Payment_Mode,
		Customer_Name, 
		Order_Amount, 
		Quantity_of_Items, 
	Delivery_time_taken_mins
FROM orders_data
inner join restaurants_data
on orders_data.Order_ID = restaurants_data.RestaurantID)
SELECT COUNT(distinct(order_table.Customer_Name)) as "Total Customer",
Zone
from order_table 
group by zone
order by count(distinct(Customer_Name)) desc;

SELECt count(Customer_Name) AS "Total customer", restaurants_data.zone
FROM orders_data
INNER JOIN restaurants_data
ON orders_data.Order_ID = restaurants_data.RestaurantID;

-- To know the restaurant with the highest orders
 --   It was limited to the top 5 restaurants


select sum(order_Amount) as 'Total Orders' ,restaurants_data.RestaurantName
from  orders_data
inner join restaurants_data
on orders_data.Restaurant_ID = restaurants_data.RestaurantID
group by RestaurantName
order by sum(Order_Amount) desc
limit 5;

-- Which customer ordered the most?
-- To know the total orders of each customer 
-- It was limited to the top 5 highest ordering customers

select  Sum(order_Amount) as 'Total Orders' ,orders_data.Customer_Name
from  orders_data
inner join restaurants_data
on orders_data.Restaurant_ID = restaurants_data.RestaurantID
group by Customer_Name
order by sum(Order_Amount) DESC
LIMIT 5;


--  Which zone has the most sales?
-- To know the total order in each zone
-- then max sale in zone
select SUM(Order_Amount) as "Total order " , restaurants_data.zone
from orders_data
inner join restaurants_data
on orders_data.Restaurant_ID = restaurants_data.RestaurantID
group by zone
order by sum(Order_Amount) desc ;

-- Which is the most liked cuisine?
-- To get the most liked cuisine using the amount of orders in top 5
select SUM(order_amount) AS "total order " , Cuisine
from orders_data
inner join restaurants_data
on orders_data.Restaurant_ID = restaurants_data.RestaurantID
group by Cuisine
order by sum(Order_Amount) desc 
limit 5;

-- To get the time of day customers ordered the most.
-- I tegorized the times into Morning, Afternoon and Night
with TOD as 
(select 
case
when Order_Time between '12:00:00' and '17:59:00' then 'Afternoon'
when Order_Time between '18:00:00' and '23:59:00' then 'Night'
else 'Morning'
end as 'Time_of_Day'
from Orders_Data)
select Time_of_Day, count(Time_of_Day) as 'Orders by time of day' 
from TOD
group by Time_of_Day
order by count(Time_of_Day) desc;

-- To get count Mode of payment 

With Mode_of_Payment as
( select payment_mode,
case
when Payment_Mode ="Debit Card" then 'card'
when payment_mode = "Credit card" then "Card"
else "cash"
end as mode_of_payment
from orders_data)
select count(Mode_of_payment) as "Quantity",
Mode_of_payment
from 
Mode_of_payment
group by Mode_of_payment
order by count(Mode_of_payment) desc;


