
--insert data to table location_dim 

INSERT INTO dw.location_dim
select  postal_code, state, city, country 
  from (select distinct postal_code, state, city, country from dw."______orders_old" ) a;

--insert data to table product_dim 
  
INSERT INTO dw.product_dim 
select  segment, subcategory, product_name, category
from (select distinct segment, subcategory, product_name, category from dw."______orders_old" ) a;


--insert data to table shipping_dim

insert into dw.shipping_dim 
select 100+row_number() over(), ship_mode from (select distinct ship_mode from dw.____orders_old ) a;


--insert data to table returns_dim

insert into dw.returns_dim 
(select distinct oo.order_id, coalesce(rd.returned,'No') as returned 	   
   from returns_dim rd 
  right join "______orders_old" oo on oo.order_id = rd.order_id where rd.order_id isnull)

--insert data to table Sales_fact

insert into dw.sales_fact 
select
	 001+row_number() over() as row_id
	 ,ship_date
	 ,o.region
	 ,o.order_id
	 ,geo_id
	 ,o.customer_id 
	 ,s.ship_mode_id
	 ,p.prod_id
	 ,order_date 
	 ,sales
	 ,quantity
	 ,discount
	 ,profit  	
from dw."______orders_old" o 
inner join dw.shipping_dim s on o.ship_mode = s.ship_mode 
inner join dw.location_dim ld on o.postal_code = ld.postal_code and ld.country =o.country and ld.city = o.city and o.state = ld.state --City Burlington doesn't have postal code
inner join dw.product_dim p on o.product_name = p.product_name and o.segment=p.segment and o.subcategory=p.subcategory and o.category=p.category and o.product_id=p.product_id 
inner join dw.customer_dim cd on cd.customer_id=o.customer_id and cd.customer_name=o.customer_name 

--count rows in sales_fact

select count(*) from dw.sales_fact sf
inner join dw.shipping_dim s on sf.ship_mode_id = s.ship_mode_id 
inner join dw.location_dim ld on sf.geo_id=ld.geo_id
inner join dw.product_dim p on sf.prod_id=p.prod_id
inner join dw.customer_dim cd on sf.customer_id = cd.customer_id 



