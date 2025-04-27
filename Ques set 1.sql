-- 1.Who is the senior most employee based on job title?
select * 
from employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices?
select count(invoice_id) as count_of_bills_per_country, billing_country 
from invoice
group by billing_country
order by count_of_bills_per_country desc;

-- 3. What are top 3 values of total invoice?
select total 
from invoice
order by total desc
limit 3;

-- 4. Which city has the best customers?
-- We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals.

select sum(total) as Total_biling_amount , billing_city
from invoice
group by billing_city
order by Total_biling_amount desc
limit 1;

-- 5. Who is the best customer?
-- The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

select  c.customer_id , c.first_name , c.last_name , sum(total)  as invoice_total
from customer as c
join invoice as i on i.customer_id = c.customer_id
group by c.customer_id , first_name , last_name
order by invoice_total desc
limit 1;


