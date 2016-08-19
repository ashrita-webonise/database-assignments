insert into order_details (order_id,variant_id) VALUES ('1','3');

CREATE FUNCTION add_cart() RETURNS trigger AS $$ 
declare
summ money;
    BEGIN

       select sum(price) INTO summ from variants v,order_details od 
       where
		v.id=od.variant_id and
		od.order_id=NEW.order_id;
		
	UPDATE orders set order_cost = summ where id = NEW.order_id; 
        RETURN NEW;

    END;

$$ LANGUAGE plpgsql;


CREATE TRIGGER add_order AFTER INSERT OR UPDATE ON order_details

   FOR EACH ROW EXECUTE PROCEDURE add_cart();
   drop function add_cart() cascade
   drop trigger add_order
  select * from orders;
