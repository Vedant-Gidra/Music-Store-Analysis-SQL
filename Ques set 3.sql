-- Q1.
-- Find how much amount spent by each customer on artists?  
-- Write a query to return customer name, artist name and total spent.

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM 
    invoice i
JOIN 
    customer c ON i.customer_id = c.customer_id
JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id
JOIN 
    track t ON il.track_id = t.track_id
JOIN 
    album al ON t.album_id = al.album_id
JOIN 
    artist ar ON al.artist_id = ar.artist_id
GROUP BY 
    c.customer_id, ar.artist_id
ORDER BY 
    customer_name, artist_name;


-- Q2.
-- We want to find out the most popular music Genre for each country.  
-- We determine the most popular genre as the genre with the highest count of purchases.  
-- Write a query that returns each country along with the top Genre.  
-- For countries where the maximum number of purchases is shared, return all Genres.

with genre_country_count as (
	select c.country, g.name as genre_name,
	count(il.invoice_line_id) as purchase_count
	from customer c
	join invoice i on i.customer_id = c.customer_id
	join invoice_line il on il.invoice_id = i.invoice_id
	join track t on t.track_id = il.track_id
	join genre g on g.genre_id = t.genre_id
	group by 1,2
	order by 1,3 desc
),
max_genre_country as (
	select country,
	max(purchase_count) as max_purchase
	from genre_country_count
	group by country
)

select gcc.country , gcc.genre_name , mgc.max_purchase
from genre_country_count gcc
join max_genre_country mgc on 
		mgc.country = gcc.country and 
		gcc.purchase_count = mgc.max_purchase
ORDER BY 3;

-- Q3.
-- Write a query that determines the customer that has spent the most on music for each country.  
-- Write a query that returns the country along with the top customer and how much they spent.  
-- For countries where the top amount spent is shared, provide all customers who spent this amount.

with customer_country_spend as(
	select c.first_name || ' ' || c.last_name as customer_name,
			c.country,
			sum(il.quantity*il.unit_price) as total_purchase
	from customer c
	join invoice i on i.customer_id = c.customer_id
	join invoice_line il on il.invoice_id = i.invoice_id
	group by 1,2
),
max_customer_spend_country as(
	select country , max(total_purchase) as max_purchase
	from customer_country_spend
	group by 1
)

select ccs.country,ccs.customer_name,ccs.total_purchase
from customer_country_spend ccs
join max_customer_spend_country mcsc on
	mcsc.country = ccs.country and
	mcsc.max_purchase = ccs.total_purchase
order by 1



