CREATE TABLE  users(
	id serial PRIMARY KEY,
	email varchar(30) UNIQUE,
	pasword varchar(15),
	user_type varchar(20),
	user_name name,	
	CONSTRAINT strlen CHECK (length(pasword) > 8),
	CONSTRAINT alpha_name CHECK (user_name NOT LIKE '%[^A-Z]%'),
	CONSTRAINT proper_email CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);

CREATE TABLE address(
	id serial PRIMARY KEY,
	user_id serial REFERENCES users(id) ON DELETE CASCADE,
	city varchar(20),
	state varchar(20),
	pin integer,
	CONSTRAINT strlen CHECK (length(pin) = 6)
);

CREATE TABLE products(
	id serial PRIMARY KEY,
	product_name name
);

CREATE TABLE variants(
	id serial PRIMARY KEY,
	product_id serial REFERENCES products(id) ON DELETE CASCADE,
	color varchar(10),
	price money
);
	
CREATE TABLE  payment_options(
	id serial PRIMARY KEY,
	method varchar(20),
	discount money
);

CREATE TABLE  transaction(
	id serial PRIMARY KEY,
	option_id serial REFERENCES payment_options(id) ON DELETE CASCADE,
	order_id serial REFERENCES orders(id) ON DELETE CASCADE,
	amount money,
	status boolean default false
);

CREATE TABLE  orders(
	id serial PRIMARY KEY,
	user_id serial REFERENCES users(id) ON DELETE CASCADE,
	order_date date,
	order_cost money
);

CREATE TABLE  order_details(
	order_id serial REFERENCES orders(id) ON DELETE CASCADE,
	variant_id serial REFERENCES variants(id) ON DELETE CASCADE	
);

 
