-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A.
select c.first_name, c.last_name, c.email, g.name as genre
from genre as g
join track as t on t.genre_id = g.genre_id
join invoice_line as il on il.track_id = t.track_id
join invoice as i on i.invoice_id = il.invoice_id
join customer  as c on c.customer_id = i.customer_id
where g.name='Rock'
order by c.email;

-- 2. Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

select a.name as Artist_name , count(a.artist_id) as songs_count
from genre as g
join track as t on t.genre_id = g.genre_id
join album on album.album_id = t.album_id
join artist as a on a.artist_id = album.artist_id
where g.name like 'Rock'
group by Artist_name, a.artist_id
order by songs_count desc
limit 10;

-- 3. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
select t.name as Song_name, t.milliseconds as length_in_ms 
from track as t 
where milliseconds > (
	select avg(milliseconds) as avg_length
	from track
)
order by milliseconds desc
limit 10

