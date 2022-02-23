require './lib/database_connection'

# This checks if you are running via rspec (test) or through rackup and sets the database it is pointing at accordingly.
if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('makersbnb_test')
else
  DatabaseConnection.setup('makersbnb')
end
