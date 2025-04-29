CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
select * from Books

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
select * from Customers
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
select * from orders;

--Practical question based on data.
-- 1) Retrieve all books in the "Fiction" genre:

select * from books
where genre = 'Fiction';

-- 2) Find books published after the year 1950:

select * from books
where published_year >1950 ;

-- 3) List all customers from the Canada:

select * from Customers
where country = 'Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM ORDERS
WHERE order_date between '2023-11-01' AND '2023-11-30';  

-- 5) Retrieve the total stock of books available:

SELECT * FROM books;
select sum(stock) as total_stock from books

-- 6) Find the details of the most expensive book:

SELECT * FROM books;
select max(price) as most_expensive  from books

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT customers.name, orders.quantity
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.quantity > 1;

8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM orders
where total_amount > 20;

-- 9) List all genres available in the Books table:

select distinct genre from books;

-- 10) Find the book with the lowest stock:

SELECT * FROM BOOKS ORDER BY STOCK ASC;

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM ORDERS;

--12) Retrieve the total number of books sold for each genre:

select b.genre,SUM(o.quantity) AS Total_number_of_books
from orders o join books b on o.book_id = b.book_id
group by b.genre
ORDER BY Total_number_of_books desc;

--13) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price) AS Average_price
FROM Books
WHERE Genre = 'Fantasy';

-- 14) List customers who have placed at least 2 orders:


select o.customer_id,c.name,count(o.order_id) as order_count
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id,c.name
having count (order_id) >=2;

-- 4) Find the most frequently ordered book:

SELECT o.book_id,b.title,count(o.order_id) as order_count
from orders o
join books b on o.book_id = b.book_id
GROUP BY O.book_id,B.title
order by order_count DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
   
SELECT * from books
WHERE genre = 'Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author,SUM(o.quantity) AS total_book_sold
FROM orders o join books b on  o.book_id = b.book_id
group by b.author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT distinct c.city, total_amount
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
WHERE O. total_amount > 30;

-- 8) Find the customer who spent the most on orders:

SELECT c.customer_id,c.name,sum(o.total_amount) as Total_spent
FROM orders o join customers c on c.customer_id = o.customer_id 
group by c.customer_id,c.name
order by Total_spent DESC LIMIT 3;

--9) Calculate the stock remaining after fulfilling all orders: 

SELECT 
    b.book_id, 
    b.title, 
    b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
order by book_id;











































































































































