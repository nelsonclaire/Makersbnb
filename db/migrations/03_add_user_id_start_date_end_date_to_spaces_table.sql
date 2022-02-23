ALTER TABLE spaces ADD start_date DATE, ADD end_date DATE, ADD user_id INTEGER REFERENCES users (id);

