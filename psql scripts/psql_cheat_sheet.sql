\l - all databases

CREATE DATABASE db_name; - creating database

\c db_name - connecting to db

\conninfo - info about db

DROP DATABASE db_name; - deleting database

CREATE TABLE table_name (
	column_name + data type + constraints (if 
any)
);

CREATE TABLE employee (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
	birth_date DATE
	
);

\d - get list of all tables

\d table_name - get info about table

DROP TABLE table_name; - deleting table

INSERT INTO table_name(
	column_names
)
VALUES(...);

\dt table_name - only created tables

mockaroo - generating data for db

\i scrpipt_full_path.sql - executing sql script

OFFSET 10 LIMIT 5 - skip 10 rows and get 5 after that

OFFSET 10 FETCH FIRST 5 ROW ONLY - analog

ILIKE (ignores lower / upper cases) / LIKE '%.com'

ALTER TABLE table_name DROP CONSTRAINT table_pkey - dropping primary key

ALTER TABLE table_name ADD PRIMARY KEY(column_name) - dropping primary key

DELETE FROM table_name WHERE column_name =...;

LIMITATIONS (unique, check)

ALTER TABLE table_nam ADD CONSTRAINT constraint_name UNIQUE(column_name);
or 
ALTER TABLE table_name ADD UNIQUE(column_name)

ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK(column_name ='...' Or ...)

UPDATE table_name SET column_name = '...' WHERE ...;

Command ...
ON CONFLICT (column_name) DO NOTHING;

Command...
ON CONFLICT (id) DO UPDATE SET column_name = EXCLUDED.column_name, columns_name_1 =...;

ALTER TABLE table_name ADD column_name BIGINT REFERENCES other_table(other_table_id)

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (id);

\copy (query) TO 'full_path' DELIMITER ',' CSV HEADER;

UUID

SELECT * FROM pg_available_extensions; 
uuid-ossp (name)

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

\df - available functions

uuid_generate_v4 - random generator of id

Select uuid_generate_v4(); - this can be as a key generator

CREATE passports(
	passport_serial UUID NOT NULL PRIMARY KEY
)
->
INSERT INRO passport (passport_serial) VALUES(uuid_generate_v4(), ...); 

 



