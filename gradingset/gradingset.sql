-- ProblemSet 1, November 25,2017
-- Submission by r.elizabeth.ranjit@accenture.com 


/*non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.*/

	select Customer.FirstName,Customer.LastName,Customer.CustomerId,Customer.Country from Customer where Customer.Country <>'USA';

/*brazil_customers.sql: Provide a query only showing the Customers from Brazil.*/

	select Customer.FirstName from Customer where Customer.Country ='Brazil';

/*brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil.The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.*/

	select Customer.FirstName,Customer.LastName,Invoice.InvoiceId,Invoice.InvoiceDate,Invoice.BillingCountry from Customer join Invoice where Customer.CustomerId=Invoice.CustomerId;

/*sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.*/

	select Employee.FirstName from Employee where title='Sales Support Agent';

/*unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.*/

	select distinct Invoice.BillingCountry from Invoice;

/*sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.*/

	select Employee.FirstName,Employee.LastName,Invoice.InvoiceId,Invoice.InvoiceDate from Invoice join Employee where Employee.Title='Sales Support Agent';

/*invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.*/

	select Customer.FirstName,Customer.LastName,Customer.Country,Invoice.Total from Customer join Invoice on Customer.CustomerId=Invoice.CustomerId; 	

/*total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?*/

	select count(InvoiceDate) from Invoice where InvoiceDate in(Select InvoiceDate from Invoice where InvoiceDate like '%2009%' union Select InvoiceDate from Invoice where InvoiceDate like '%2011%');

/*total_sales_{year}.sql: What are the respective total sales for each of those years?*/

	select total from Invoice where InvoiceDate in(Select InvoiceDate from Invoice where InvoiceDate like '%2009%' union Select InvoiceDate from Invoice where InvoiceDate like '%2011%');

/*invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.*/

	select count(InvoiceLine.InvoiceLineId) as no_of_line_items from InvoiceLine where InvoiceLine.InvoiceId=37;

/*line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY*/

	select InvoiceLine.InvoiceId,count(InvoiceLine.InvoiceLineId) as no_of_line_items from InvoiceLine group by InvoiceLine.InvoiceId ;

/*line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.*/

	select InvoiceLine.InvoiceLineId,Track.Name from InvoiceLine join Track where InvoiceLine.TrackId=Track.TrackId group by InvoiceLine.InvoiceLineId;

/*line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.*/

	select InvoiceLine.InvoiceLineId,Track.Name,Artist.Name from InvoiceLine join Track join Artist where InvoiceLine.TrackId=Track.TrackId and Artist.Name=Track.Composer group by InvoiceLine.InvoiceLineId;

/*country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY*/

	select count(Invoice.InvoiceId),Invoice.BillingCountry from Invoice group by Invoice.BillingCountry;

/*playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.*/

	select Playlist.Name,count(Track.TrackId) from Playlist join Track join PlaylistTrack where Playlist.PlaylistId=PlaylistTrack.PlaylistId and Track.TrackId=PlaylistTrack.TrackId group by Playlist.Name;	

/*tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.*/

	select t.Name,a.Title,m.Name,g.Name from Album a,Track t,MediaType m,Genre g on a.AlbumID=t.AlbumID and g.GenreId=t.GenreId and m.MediaTypeId=t.MediaTypeID; 

/*invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.*/

	select Invoice.InvoiceId,count(InvoiceLine.InvoiceLineId) from Invoice join InvoiceLine where Invoice.InvoiceId=InvoiceLine.InvoiceId group by Invoice.InvoiceId;

/*sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.*/

	select Employee.FirstName,Invoice.Total from Invoice,Employee where Employee.Title='Sales Support Agent' group by Employee.FirstName;

/*top_2009_agent.sql: Which sales agent made the most in sales in 2009?*/

	select Employee.FirstName from Employee join Invoice on Invoice.CustomerId=Employee.ReportsTo where Invoice.Total in (select max(Invoice.Total) from Invoice where Invoice.InvoiceDate like '%2009%') ;

/*top_agent.sql: Which sales agent made the most in sales over all?*/

	select Employee.FirstName from Employee join Invoice on Invoice.CustomerId=Employee.ReportsTo where Invoice.Total in (select max(Invoice.Total) from Invoice);

/*sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.*/

	select count(Customer.CustomerId) from Customer,Employee where Employee.EmployeeId=Customer.SupportRepId group by Employee.EmployeeId having Employee.Title='Sales Support Agent';

/*sales_per_country.sql: Provide a query that shows the total sales per country.*/

	select Invoice.BillingCountry,max(Invoice.Total) from Invoice group by Invoice.BillingCountry;

/*top_country.sql: Which country's customers spent the most?*/

	select max(Invoice.Total),Invoice.BillingCountry from Invoice group by Invoice.BillingCountry;

/*top_2013_track.sql: Provide a query that shows the most purchased track of 2013.*/

	select t.TrackID,t.Name,i.InvoiceDate from Invoice i join InvoiceLine il on i.InvoiceId=il.InvoiceID join Track t on il.TrackId=t.TrackId where InvoiceDate like '%2013%' ;

/*top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.*/

	select t.Name,count(il.TrackID)  FROM Track t, InvoiceLine il WHERE il.TrackId = t.TrackId GROUP BY t.Name order by il.TrackId desc Limit 5;

/*top_3_artists.sql: Provide a query that shows the top 3 best selling artists.*/

	select a.name, count(il.TrackId) from Artist a, InvoiceLine il, Track t, Album al where il.TrackId == t.TrackId and t.AlbumId == al.AlbumId and al.ArtistId == art.ArtistId
group by art.Name order by count(il.TrackId) desc Limit 3;

/*top_media_type.sql: Provide a query that shows the most purchased Media Type.*/

	select mt.Name as "media_type" from MediaType mt, InvoiceLine il, Track t where il.TrackId == t.TrackId and t.MediaTypeId == mt.MediaTypeId group by mt.Name order by il.TrackId desc;
	