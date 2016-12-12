DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;


CREATE TABLE customers (
  id serial8 primary key,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  id serial8 primary key,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE tickets (
  id serial8 primary key,
  customer_id INT4 references customers(id) ON DELETE CASCADE,
  film_id INT4 references films(id) ON DELETE CASCADE
);