require 'pg'

class Space

  attr_reader :id, :name, :description, :price, :start_date, :end_date, :user_id

  def initialize(id:, name:, description:, price:, start_date:, end_date:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @start_date = start_date
    @end_date = end_date
    @user_id = user_id
  end

  def self.list(name:, description:, price:, start_date:, end_date:, user_id:)
    return nil if name.empty? || description.empty?
  
    result = DatabaseConnection.query("INSERT INTO spaces(name, description, price, start_date, end_date, user_id) 
                                      VALUES($1, $2, $3, $4, $5, $6) 
                                      RETURNING id, name, description, price, start_date, end_date, user_id", 
                                      [name, description, price, start_date, end_date, user_id])

    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], 
    start_date: result[0]['start_date'], end_date: result[0]['end_date'], user_id: result[0]['user_id'])

  end
end