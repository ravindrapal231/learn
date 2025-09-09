##1. Create a table called employees with the following structure emp_id (integer, should not be NULL and should be a primary key) emp_name (text, should not be NULL) age (integer, should have a check constraint to ensure the age is at least 18) email (text, should be unique for each employee) salary (decimal, with a default value of 30,000). Write the SQL query to create the above table with all constraints.

CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);


## 2.Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints


##🔹 Purpose of Constraints

Prevent invalid data (e.g., negative age, duplicate emails).

Maintain relationships between tables (e.g., employee belongs to a department).

Reduce errors by enforcing business rules automatically.

Ensure uniqueness & consistency in records.

🔹 Common Types of Constraints (with examples)
1. PRIMARY KEY

Ensures each record is unique and identifiable.

Combines NOT NULL + UNIQUE automatically.

emp_id INT PRIMARY KEY


✅ Example: No two employees can have the same emp_id.

2. NOT NULL

Ensures a column cannot have empty (NULL) values.

emp_name TEXT NOT NULL


✅ Example: Every employee must have a name.

3. UNIQUE

Ensures all values in a column are distinct.

email TEXT UNIQUE


✅ Example: No two employees can register with the same email.

4. CHECK

Ensures values meet a specific condition.

age INT CHECK (age >= 18)


✅ Example: Prevents hiring employees younger than 18.

5. DEFAULT

Assigns a default value if no value is provided.

salary DECIMAL(10,2) DEFAULT 30000


✅ Example: If salary is not mentioned, it automatically gets 30000.00.

6. FOREIGN KEY

Creates a relationship between two tables.

dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)


✅ Example: Ensures dept_id in employees table must exist in the departments table.

7. AUTO_INCREMENT / SERIAL (DB-specific)

Automatically generates unique IDs.

emp_id INT PRIMARY KEY AUTO_INCREMENT


✅ Example: Each new employee automatically gets the next available ID.

🔹 Why Constraints Matter?

Imagine a database without constraints:

Two employees could have the same emp_id (confusion in payroll).

age could be negative or NULL (nonsense values).

email could be missing or duplicated (communication issues).

With constraints, the database enforces rules automatically, so even if developers forget checks in application code, the data still remains clean and consistent.
##


##  Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer
Why apply NOT NULL constraint?

The NOT NULL constraint ensures that a column cannot have NULL values.
We apply it when:

The column is mandatory (e.g., emp_name must always be provided).

The column represents a critical identifier (e.g., emp_id or account_number).

To prevent incomplete data entry (e.g., email must not be empty if used for login).

✅ Example:

emp_name TEXT NOT NULL


This ensures every employee must have a name.

🔹 Can a Primary Key contain NULL values?

No. A primary key cannot contain NULL values.

✅ Reasons:

Uniqueness: A primary key must uniquely identify each row in the table.

If NULL were allowed, multiple rows could have NULL in the primary key column, violating uniqueness.

NOT NULL requirement: By definition, a primary key is a combination of UNIQUE + NOT NULL.

That’s why every value in the primary key column must exist and must be unique.

📌 Example:
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name TEXT NOT NULL
);


emp_id is the primary key → cannot be NULL and must be unique.

emp_name is NOT NULL → must always have a value.

✅ In short:

Use NOT NULL when you want to ensure a column always has a value.

A primary key automatically has a NOT NULL constraint, so it can never contain NULL values.


ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);


ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);


ALTER TABLE employees
ADD CONSTRAINT check_age CHECK (age >= 18);

ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

##Removing Constraints

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

ALTER TABLE employees
DROP CONSTRAINT unique_email;

ALTER TABLE employees
DROP CONSTRAINT check_age;

## Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint


What happens if you violate constraints?

When you try to INSERT, UPDATE, or DELETE data in a way that breaks a constraint, the database will reject the operation and return an error message. This prevents invalid, duplicate, or inconsistent data from being stored.

🔹 Consequences by Constraint Type
1. NOT NULL constraint

Consequence: You cannot leave the column empty.

Example:

INSERT INTO employees (emp_id, emp_name, age, email) 
VALUES (1, NULL, 25, 'abc@example.com');


❌ Error (PostgreSQL style):

ERROR:  null value in column "emp_name" violates not-null constraint

2. PRIMARY KEY constraint

Consequence: You cannot insert duplicate or NULL values in the primary key column.

Example:

INSERT INTO employees (emp_id, emp_name, age, email) 
VALUES (1, 'John', 30, 'john@example.com');  

-- Try inserting another row with the same emp_id
INSERT INTO employees (emp_id, emp_name, age, email) 
VALUES (1, 'Mike', 28, 'mike@example.com');


❌ Error (MySQL style):

ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'

3. UNIQUE constraint

Consequence: Duplicate values are not allowed.

Example:

INSERT INTO employees (emp_id, emp_name, age, email) 
VALUES (2, 'Sara', 27, 'john@example.com');


❌ Error:

ERROR: duplicate key value violates unique constraint "unique_email"

4. CHECK constraint

Consequence: The data must meet the condition.

Example:

INSERT INTO employees (emp_id, emp_name, age, email) 
VALUES (3, 'Alex', 15, 'alex@example.com');


❌ Error:

ERROR: new row for relation "employees" violates check constraint "check_age"

5. FOREIGN KEY constraint

Consequence: The value must exist in the referenced table.

Example:

INSERT INTO employees (emp_id, emp_name, age, dept_id) 
VALUES (4, 'Sam', 26, 99);  -- But dept_id 99 doesn’t exist in departments


❌ Error:

ERROR: insert or update on table "employees" violates foreign key constraint "fk_dept"
DETAIL: Key (dept_id)=(99) is not present in table "departments".

🔹 Summary

Constraint violation = Operation blocked.

Protects data integrity by ensuring only valid data is stored.

The error messages are clear and explain which constraint was violated.

##You created a products table without constraints as follows: CREATE TABLE products ( product_id INT, product_name VARCHAR(50), price DECIMAL(10, 2));   Now, you realise that The product_id should be a primary key The price should have a default value of 50.00

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

##Add primary id
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

##Add DEFAULT value for price
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

ALTER TABLE products
ALTER price SET DEFAULT 50.00;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2) DEFAULT 50.00
);

INSERT INTO products (product_id, product_name) 
VALUES (1, 'Pen');


#You have two tables: Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

-- Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT
);

-- Classes table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50)
);

SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c
    ON s.class_id = c.class_id;

# Consider the following three tables: Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order 

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM products p
LEFT JOIN orders o 
    ON p.product_id = o.product_id
LEFT JOIN customers c 
    ON o.customer_id = c.customer_id;

#Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),   -- price per unit at the time of order
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT 
    p.product_name,
    SUM(o.quantity * o.price) AS total_sales
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name;

#. You are given three tables: Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables. Note - The above-mentioned questions don't require any dataset.
-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order_Details table (stores products and quantities for each order)
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_details od
    ON o.order_id = od.order_id;

