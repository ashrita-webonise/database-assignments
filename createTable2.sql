
CREATE TABLE  users(
	id varchar(15) PRIMARY KEY,
	user_name name,
	email varchar(30) UNIQUE,
	pasword varchar(15),
	user_type varchar(20),
	address varchar(120),
	CONSTRAINT strlen CHECK (length(pasword) > 8),
	CONSTRAINT user_name CHECK (user_name NOT LIKE '%[^A-Z]%'),
	CONSTRAINT proper_email CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);

CREATE TABLE products(
	id varchar(15) PRIMARY KEY,
	product_name name
);

CREATE TABLE  product_details(
	product_id varchar(15) REFERENCES products(id) 
	ON DELETE CASCADE ON UPDATE RESTRICT,
	color varchar(30),
	price money,
	available_quantity integer,
	PRIMARY KEY(product_id,color)
);

CREATE TABLE  payment_options(
	id integer PRIMARY KEY,
	method varchar(20)
);

CREATE TABLE  discounts(
	id varchar(15) PRIMARY KEY,
	amount money,
	validity date
);

CREATE TABLE  orders(
	id varchar(15) unique,
	user_id varchar(15) REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	payment_mode integer REFERENCES payment_options(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	order_date date,
	order_cost money,
	coupon_id varchar(15) REFERENCES discounts(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	payment_status boolean default false,
	PRIMARY KEY(id,user_id) 
);

CREATE TABLE  order_details(
	order_id varchar (15) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	product_id varchar(15) REFERENCES products(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	product_quantity integer,
	PRIMARY KEY(order_id,product_id)
);
 

CREATE TABLE  return_product(
	id varchar(15),
	user_id varchar(15) REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	order_id varchar(15) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	product_id varchar(15) REFERENCES products (id) ON DELETE CASCADE ON UPDATE RESTRICT,
	PRIMARY KEY(id,order_id,product_id,user_id)
);

CREATE TABLE refund(
	user_id varchar(15) REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	order_id varchar(15) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	bank_ac_number numeric(20),
	bank_ifsc varchar(10),
	PRIMARY KEY(user_id,bank_ac_number) 
);
