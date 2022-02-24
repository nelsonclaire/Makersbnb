require 'pg'

p "Setting up test database..."

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  # connection.exec("TRUNCATE TABLE users CASCADE;")
  connection.exec("TRUNCATE spaces, users, bookings;")
  # connection.exec("TRUNCATE spaces;")
end
