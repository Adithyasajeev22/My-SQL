create database online_shopping; 
use online_shopping;

create table produts(product_id int auto_increment primary key,product_name varchar(100) not null,price int not null,stock int not null,category varchar(100));
create table customers(customer_id int auto_increment primary key,customer_name varchar(100) not null,email varchar(100),phone int );
create table orders(order_id int auto_increment primary key,customer_id int,order_date date default(current_date),total_amount int,foreign key (customer_id) references customers(customer_id));
create table orderdetails(orderdetails_id int auto_increment primary key,order_id int,product_id int,quantity int not null,foreign key(order_id) references orders(order_id),foreign key(product_id) references produts(product_id));

insert into produts(product_name,price,stock,category) values ('book',100,10,'information'),('foundation',350,16,'cosmetics'),('laptop',25000,30,'electronics'),('smart phone',40000,20,'electronics'),('shoes',5000,18,'fashion'),('lipstic',1500,30,'cosmetics');
ALTER TABLE customers MODIFY phone varchar(100);
insert into customers(customer_name,email,phone) values ('adithya','adithya@gmail.com','2387952678'),('greeshma','greeshma@gmail.com','9846623857'),('vijay','vijay@gmail.com','5783346519'),('anjana','anjana@gmail.com','9876543231'),('ananya','ananya@gmail.com','2344567259'),('jeethu','jeethu@gmail.com','9078547348');
insert into orders(customer_id,order_date,total_amount) values(1,current_date(),25000),(2,current_date(),700),(3,current_date(),5000),(4,current_date(),1500),(5,current_date(),200),(6,current_date(),40000);
insert into orderdetails(order_id,product_id,quantity) values (1,3,1),(2,2,2),(3,5,1),(4,6,1),(5,1,2),(6,4,1);

-- Find top 5 selling products 
select p.product_id,p.product_name,ore.quantity  ,sum(ore.quantity) as total_sold from orderdetails ore join produts p on ore.orderdetails_id=p.product_id group by p.product_id,p.product_name order by total_sold desc limit 5;

-- Get all orders made in the last 30 days
select*from orders where order_date > current_date-interval 30 day;

-- Calculate total sales revenue
select sum(total_amount) from orders;
