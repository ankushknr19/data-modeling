CREATE DATABASE ecommerce;

CREATE TYPE role AS ENUM
('admin', 'vendor_staff', 'customer');

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(30) NOT NULL,
    user_role role NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE vendor_staffs
(
    staff_id SERIAL PRIMARY KEY,
    user_id SERIAL NOT NULL,
    staff_username VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)

);

CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    user_id SERIAL NOT NULL,
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    contact VARCHAR(20) UNIQUE,
    address VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TYPE unit AS ENUM
('kg', 'pcs', 'ltrs', 'dozen');

CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    category_id SERIAL NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC NOT NULL,
    count_in_stock INT NOT NULL,
    unit unit NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY
    (category_id) REFERENCES categories(category_id)
);

CREATE TABLE carts
(
    cart_id SERIAL PRIMARY KEY,
    customer_id SERIAL NOT NULL UNIQUE,
    FOREIGN KEY
    (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE cart_items
(
    cart_item_id SERIAL PRIMARY KEY,
    cart_id SERIAL NOT NULL,
    product_id SERIAL NOT NULL,
    qty INT DEFAULT 1,
    FOREIGN KEY
    (cart_id) REFERENCES carts(cart_id),
    FOREIGN KEY
    (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders
(
    order_id SERIAL PRIMARY KEY,
    customer_id SERIAL NOT NULL,
    total_amount NUMERIC NOT NULL,
    is_fulfilled BOOLEAN DEFAULT FALSE,
    is_paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY
    (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details
(
    order_details_id SERIAL PRIMARY KEY,
    order_id SERIAL NOT NULL,
    product_id SERIAL NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC NOT NULL,
    FOREIGN KEY
    (order_id) REFERENCES orders (order_id),
    FOREIGN KEY
    (product_id) REFERENCES products (product_id)
);

CREATE TYPE payment_type AS ENUM
('cash', 'card', 'fonepay');

CREATE TABLE payments
(
    payment_id SERIAL PRIMARY KEY,
    order_id SERIAL NOT NULL,
    payment_type payment_type NOT NULL,
    is_success BOOLEAN DEFAULT FALSE,
    FOREIGN KEY
    (order_id) REFERENCES orders (order_id)
);