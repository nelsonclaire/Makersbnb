CREATE TABLE users(id SERIAL PRIMARY KEY, name VARCHAR(60), username VARCHAR(30) UNIQUE, email VARCHAR(60) UNIQUE, password VARCHAR(140));