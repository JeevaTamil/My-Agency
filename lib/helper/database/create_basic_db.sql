CREATE TABLE Customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  city VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255),
  gst_number VARCHAR(255)
);

CREATE TABLE Suppliers (
  supplier_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255), 
  city VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255),
  commission_percentage DECIMAL(5,2) CHECK (commission_percentage >= 2 AND commission_percentage <= 5) NOT NULL,
  gst_number VARCHAR(255)
);

create type payment_status as enum (
  'unpaid',
  'paid',
  'part-paid'
);

CREATE TABLE Transactions (
  transaction_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES Customers(customer_id),
  supplier_id INT NOT NULL REFERENCES Suppliers(supplier_id),
  order_date DATE NOT NULL,
  bill_amount DECIMAL(10,2) NOT NULL, 
  discount_amount DECIMAL(10,2) NOT NULL,
  tax_amount DECIMAL(10,2) NOT NULL,
  payment_status payment_status NOT NULL DEFAULT 'unpaid'
);

CREATE TABLE Logistics (
  logistic_id SERIAL PRIMARY KEY,
  transaction_id INT NOT NULL REFERENCES Transactions(transaction_id),
  transport_name VARCHAR(255),
  lr_number VARCHAR(255),
  lr_date DATE,
  number_of_bundles INT
);

-- ALTER TABLE Transactions
-- ADD COLUMN logistic_id INT REFERENCES Logistics(logistic_id);


CREATE TABLE Returns (
  return_id SERIAL PRIMARY KEY,
  transaction_id INT NOT NULL REFERENCES Transactions(transaction_id),
  return_date DATE NOT NULL,
  reason VARCHAR(255),
  total_return_amount DECIMAL(10,2) NOT NULL,
  logistic_id INT REFERENCES Logistics(logistic_id)
);



CREATE TYPE payment_method AS ENUM (
  'cash',
  'check',
  'net_banking',
  'upi',
  'card',
  'other' 
);



CREATE TABLE Payments (
  payment_id SERIAL PRIMARY KEY,
  transaction_id INT NOT NULL REFERENCES Transactions(transaction_id),
  payment_method payment_method NOT NULL DEFAULT 'other',
  payment_amount DECIMAL(10,2) NOT NULL,
  payment_date DATE NOT NULL,
  reference_number VARCHAR(255) NOT NULL, 
  notes VARCHAR(255) 
);


CREATE TABLE Commissions (
  commission_id SERIAL PRIMARY KEY,
  transaction_id INT NOT NULL REFERENCES Transactions(transaction_id),
  commission_amount DECIMAL(10,2) NOT NULL,
  payment_status payment_status NOT NULL DEFAULT 'unpaid', 
  payment_date DATE,
  payment_method payment_method NOT NULL DEFAULT 'other',
  reference_number VARCHAR(255),
  notes VARCHAR(255)
);
