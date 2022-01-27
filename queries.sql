--Mostrar los datos de los clientes que escuchan un genero en especifico
SELECT  c.email, c.FirstName || " " || c.LastName AS "Nombre",
         c.Country AS "País", 
          c.Phone AS "Teléfono",
           g.Name AS "Genero"
    FROM customers c, genres g
    JOIN invoices i ON ii.InvoiceId = i.InvoiceId
    JOIN invoice_items ii ON ii.TrackId = t.TrackId
    JOIN tracks t ON t.GenreId = g.GenreId
    WHERE g.Name='Jazz'
GROUP BY c.email;


--Mostrar el numero de compras realizadas por los clientes
SELECT i.CustomerId,
        c.FirstName || " " || c.LastName AS "Nombre",
         c.Country AS "País",
          COUNT(i.InvoiceId) AS "Total de compras"
    from invoices i
    INNER JOIN customers c ON c.CustomerId == i.CustomerId
    GROUP BY i.CustomerId
ORDER by COUNT(i.InvoiceId) DESC;

--Mostrar los 5 paises con el promedio mas alto en compras e indicar cual ha sido su mayor y menor compra
SELECT c.Country AS "País",
         AVG(i.Total) AS "Promedio de Compras",
          MAX(i.Total) AS "Compra más alta",
           MIN(i.Total) AS "Compra más baja"
    FROM invoices i
    JOIN customers c ON  c.CustomerId == i.CustomerId
    GROUP BY c.Country	
    ORDER BY AVG(i.Total) DESC
Limit 5;

--Mostrar los 5 clientes que han gastado mas dinero
SELECT c.CustomerId,
        c.FirstName || " " || c.LastName AS "Nombre",
         c.Country AS "País",
          SUM(ii.UnitPrice) AS "Total"
    FROM invoices i
    JOIN customers c ON i.CustomerId = c.CustomerId
    JOIN invoice_items ii ON ii.Invoiceid = i.Invoiceid 
    JOIN tracks t ON ii.TrackId == t.TrackId
    GROUP BY c.CustomerId
    ORDER BY SUM(ii.UnitPrice) desc
limit 5;

--Identificar las compras anuales de un genero en especifico
SELECT STRFTIME('%Y',i.InvoiceDate) AS "Año", count(i.InvoiceId) AS "Compra total"
    FROM invoices i
    JOIN invoice_items ii ON ii.InvoiceId = i.InvoiceId
    JOIN tracks t ON t.TrackId = ii.TrackId
    JOIN genres g ON g.GenreId = t.GenreId
    WHERE g.Name = 'Jazz'
    GROUP BY STRFTIME('%Y',i.InvoiceDate)
    ORDER BY STRFTIME('%Y',i.InvoiceDate) desc;



--Qué agente de ventas obtuvo la mayor cantidad de ventas en 2009
select*, max(total)from
(select e.*,sum(total) as 'total'
From employees as e
join customers as c on e.employeeid = c.supportrepid
join invoices as i on i.customerid = c.customerid
where i.invoicedate between '2009-01-00' and '2009-12-31'
group by e.employeeid)
--Proporcione una consulta que muestre el total de la factura, el nombre del cliente, el país y el nombre del agente de ventas para todas las facturas y clientes.

select c.FirstName||' '||c.LastName as Customer_Name,
e.FirstName||' '||e.LastName as Employee_Name,
i.Total ,c.country ,e.title
from customers as c
left join invoices as i on i.CustomerId = c.CustomerId
left join employees as e on e.EmployeeId = c.supportrepid
--Proporcione una consulta que incluya el nombre de la pista comprada Y el nombre del artista con cada línea de factura
select t.Name as Track_name ,art.Name as artist ,a.Artistid as Artist_id,il.*
from invoice_items as il
left join tracks as t on t.trackid = il.trackid
left join albums as a on a.albumid = t.albumid
left join artists as art on art.Artistid = a.Artistid


---Proporcione una consulta que muestre las 5 pistas más compradas en total.
select t.name as Track_Name ,count(*) as Tack_sales
from invoice_items as il
left join tracks as t on t.trackId = il.trackid
group by t.trackId
order by 2 desc 
----Proporcione una consulta que muestre los 3 artistas más vendidos

select art.Name as Artist_name ,count(*) as Artist_sales
from invoice_items as i
left join tracks as t on i.trackId = i.trackId
left join albums as a on a.albumId = t.albumId
left join artists as art on art.artistId = a.artistId
group by art.artistId
order by 2 desc
limit 3


