CREATE TABLE CUSTOMERS (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(50)
);

CREATE TABLE ITEMS (
    item_id INTEGER PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    department VARCHAR(50)
);

CREATE TABLE SALES (
    order_id INTEGER PRIMARY KEY,
    date DATE NOT NULL,
    item_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    revenue DECIMAL(12,2) NOT NULL CHECK (revenue >= 0),
    FOREIGN KEY (item_id) REFERENCES ITEMS(item_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);

INSERT INTO CUSTOMERS (customer_id, first_name, last_name, address) 
VALUES 
    (1, 'John', 'Doe', '123 Main St'),
    (2, 'Jane', 'Smith', '456 Oak Ave'),
    (3, 'Robert', 'Johnson', '789 Pine Rd');

INSERT INTO ITEMS (item_id, item_name, price, department) 
VALUES 
    (1, 'Laptop', 999.99, 'Electronics'),
    (2, 'Desk Chair', 199.99, 'Furniture'),
    (3, 'Coffee Maker', 49.99, 'Appliances');

INSERT INTO SALES (order_id, date, item_id, customer_id, quantity, revenue) 
VALUES 
    (1, '2024-01-01', 1, 1, 1, 999.99),
    (2, '2024-01-02', 2, 2, 2, 399.98),
    (3, '2024-01-03', 3, 3, 1, 49.99);

select * from customers;
select * from items;
select * from sales order by order_id asc;

'PULL TOTAL NO. OF ORDERS THATS WERE COMPLETED ON 18TH MARCH 2023'
select count(order_id) as Total_Orders from sales where date = '2024-03-18';

'PULL TOTAL NO. OF ORDERS THATS WERE COMPLETED ON 18TH MARCH 2023 WITH THE FIRST NAME JOHN AND LAST NAME DOE'
select count(s.order_id) as Total_Orders from sales as s left join customers as c ON s.customer_id = c.customer_id where s.date = '2024-03-18' and c.first_name='John' and c.last_name='Doe';

'PULL TOTAL NUMBER OF CUSTOMERS THAT PURCHASED IN JAN 2023  AND THE AVG AMOUNT OF SPEND PER CUSTOMER'
select customer_id, COUNT(order_id) ,avg(revenue) from sales where date between '2023-01-01' and '2023-01-31' group by customer_id;

'PULL THE DEPARTMENTS THAT GENERATED LESS THAN 600 IN 2022'
SELECT i.department, SUM(s.revenue) AS total_revenue
FROM sales s
JOIN items i ON s.item_id = i.item_id
WHERE s.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY i.department
HAVING SUM(s.revenue) < 600; 

'WHAT IS THE MOST AND LEAST REVENUE WE HAVE GENERATED BY AN ORDER'
SELECT MAX(revenue) AS max_revenue, MIN(revenue) AS min_revenue FROM sales;

'WHAT WERE THER ORDERS THAT WERE PURCHSED IN OUR MOST LUCRATIVE ORDER'
SELECT order_id, date, item_id, customer_id, quantity, revenue
FROM sales
WHERE revenue = (select MAX(revenue) from sales);

	