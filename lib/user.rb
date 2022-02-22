require 'bcrypt'
require_relative './database_connection'
require 'pg'

class User
  
  def self.create(name:, username:, email:, password:)
    return nil if email.empty? || password.empty? || name.empty? || username.empty?
    # cleaned_username = DatabaseConnection.escape_string(username)
    return nil if account_exists?(username, email)
    encrypted_password = BCrypt::Password.create(password)

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params(
      "INSERT INTO users (name, username, email, password) VALUES($1, $2, $3, $4) ON CONFLICT DO NOTHING RETURNING id, name, username, email;", [
        name, username, email, encrypted_password]
    )
    User.new(
      id: result[0]['id'],
      name: result[0]['name'],
      username: result[0]['username'],
      email: result[0]['email'],
    )
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params("SELECT * FROM users")
    result.map do |user|
      User.new(
        id: user['id'],
        name: user['name'],
        email: user['email'],
        username: user['username']
      )
    end
  end

  def self.find(id:)
    return nil unless id
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params(
      "SELECT * FROM users WHERE id = $1", [id]
    )
    User.new(
      id: result[0]['id'],
      name: result[0]['name'],
      username: result[0]['username'],
      email: result[0]['email']
    )
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params(
      "SELECT * FROM users WHERE email = $1", [email]
    )
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], 
    email: result[0]['email'])
  end

  attr_reader :id, :name, :username, :email

  def initialize(id:, name:, username:, email:)
    @id = id
    @name = name
    @username = username
    @email = email
  end

  def self.account_exists?(username, email)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec_params(
      "SELECT * FROM users WHERE username = $1 OR email = $2",[username, email]
    ).any?
  end

end
