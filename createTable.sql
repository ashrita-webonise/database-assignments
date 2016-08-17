CREATE TABLE  users(
user_id varchar(15),user_name varchar(30),user_email varchar(30),
user_password varchar(15),user_type varchar(20),user_address varchar(120),
PRIMARY KEY(user_id), UNIQUE(user_email), CONSTRAINT strlen
CHECK (length(user_email) > 8),CONSTRAINT user_name 
CHECK (user_name NOT LIKE '%[^A-Z]%'));

CREATE TABLE products(
product_id varchar(15),product_name varchar(30),
PRIMARY KEY(product_id));

CREATE TABLE  product_details(
product_id varchar(15)PRIMARY KEY, product_color varchar(30),product_price varchar(10),
product_available_quantity varchar(4),
CONSTRAINT FOREIGN KEY (product_id) REFERENCES products(product_id)
ON DELETE CASCADE ON UPDATE RESTRICT);

CREATE TABLE  orders(
order_id varchar (15),user_id varchar(15),payment_mode varchar(2),
order_date CURRENT_DATE(10),order_cost varchar(20),coupon_id varchar(15),
PRIMARY KEY(order_id,user_id),
CONSTRAINT FOREIGN KEY(user_id) REFERENCES users(user_id),
FOREIGN KEY (payment_mode) REFERENCES payment_options (payment_mode),
FOREIGN KEY (coupon_id) REFERENCES payment_options (coupon_id)
ON DELETE CASCADE ON UPDATE RESTRICT, 
order_cost CHECK (order_cost >= products product_price));

CREATE TABLE  order_details(
order_id varchar (15),product_id varchar(15),product_quantity varchar(4),
PRIMARY KEY(order_id,product_id),
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES product_id (products) 
ON DELETE CASCADE ON UPDATE RESTRICT,product_quantity
CHECK (product_quantity <= product_details product_available_quantity));
 
CREATE TABLE  payment_options(
payment_mode varchar (2)PRIMARY KEY,payment_method varchar(20),payment_status varchar(1),
PRIMARY KEY(payment_mode));

CREATE TABLE  discounts(
coupon_id varchar(15) PRIMARY KEY,
coupon_amount varchar(5),coupon_validity DATE(10));

CREATE TABLE  return_product(
return_order_id varchar(15),user_id varchar(15),order_id varchar(15),
product_id varchar(15),
PRIMARY KEY(return_order_id,order_id,product_id,user_id),
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES product_id (products),
FOREIGN KEY(user_id) REFERENCES users(user_id)
ON DELETE CASCADE ON UPDATE RESTRICT);

CREATE TABLE refund(
user_id varchar(15),order_id varchar(15),bank_ac_number varchar(20),bank_ifsc varchar(10),
PRIMARY KEY(user_id),
CONSTRAINT FOREIGN KEY(user_id) REFERENCES users(user_id),
FOREIGN KEY(order_id) REFERENCES users(order_id));
