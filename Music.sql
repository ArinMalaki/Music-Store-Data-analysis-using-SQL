-- senior most employee base on job title
select first_name,last_name,levels from employee
order by levels desc;

--which countyr has most invoices
select count(billing_country) as most_invoice,billing_country from invoice
group by billing_country
order by most_invoice desc;

--what are top 3 value total ivoice
select * from invoice
order by total desc;

--which city has best custmer?would like to through a music fest in city we make most money
--write a quary whhich has the highest sum of total invoice and return both city and sum of total invoice
select billing_city,round(sum(total),2) as total_invoice from invoice
group by billing_city
order by total_invoice desc;

--who is the best custmer ? the custmer spend the most money  will be declared the best custmer 
select customer.first_name,customer.last_name,round(sum(invoice.total),2) as money_spend 
from customer join invoice
on customer.customer_id = invoice.customer_id
group by customer.first_name,customer.last_name
order by money_spend desc;

--write a quary return the email,first name, last name & genre of all rock music listener 
--order yout list ordered alphabatically by email starting with A?

select customer.first_name,customer.last_name,customer.email as Email,genre.name from track join genre
on genre.genre_id = track.genre_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
where genre.name = 'Rock'
group by customer.first_name,customer.last_name,customer.email,genre.name
order by Email asc;

--lets invite the artist who has writtern the most rock music in our data set 
--write a quary that return the arist name and total track count on top 10 bands

select artist.name,count(artist.artist_id) as No_of_Songs,genre.name as Genre_name 
from track 
join genre on track.genre_id = genre.genre_id
join album on album.album_id = track.album_id
join album2 on album.album_id = album2.album_id
join artist on artist.artist_id = album.artist_id

where genre.name = 'Rock'
group by artist.name,artist.artist_id,genre.name 
order by No_of_Songs desc;

--return all the track name thatv has a song length longer then the average song length
--return the name and milliseconds for each track. order by the song length with the longest song listed first
select name,milliseconds from track
where milliseconds > (select AVG(milliseconds) as Avg_Song_Length from track)
order by milliseconds desc;

--find how much amount spend by custmer on artist? write quary returning custmer name,artist name,totel spend
select customer.customer_id,customer.first_name,customer.last_name,
round(sum(invoice_line.quantity*invoice_line.unit_price),2) as Spend_Money,artist.name 
from track 
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join album on album.album_id = track.album_id
join album2 on album2.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
group by customer.customer_id,customer.first_name,customer.last_name,artist.name 
order by Spend_Money desc;

--most populer genre in country as genre with highest selling price
select invoice.billing_country,max(genre.genre_id) as popular_genre,
sum(invoice_line.quantity*invoice_line.unit_price) as Total_sale 
from genre
join track on track.genre_id = genre.genre_id
join invoice_line on invoice_line.track_id = track.track_id
join invoice on invoice.invoice_id = invoice_line.invoice_id
group by invoice.billing_country
order by  invoice.billing_country asc,Total_sale desc ;
