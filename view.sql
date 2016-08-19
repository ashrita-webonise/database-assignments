CREATE VIEW product_sold as
	select order_id,order_cost,order_date,discount,method,status
	 from orders o, transaction t,payment_options p where 
	  p.id = t.option_id and
	  t.order_id = o.id ;

	  select * from product_sold;
