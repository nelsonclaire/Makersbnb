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

    cleaned_name = DatabaseConnection.escape_string(name)

    result = DatabaseConnection.query("INSERT INTO spaces(name, description, price, start_date, end_date, user_id)
                                      VALUES($1, $2, $3, $4, $5, $6)
                                      RETURNING id, name, description, price, start_date, end_date, user_id",
                                      [cleaned_name, description, price, start_date, end_date, user_id])

    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'],
              start_date: result[0]['start_date'], end_date: result[0]['end_date'], user_id: result[0]['user_id'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        start_date: space['start_date'],
        end_date: space['end_date'],
        user_id: space['user_id']
      )
    end
  end

  def self.dates(start_date:, end_date:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE start_date <= $1 and end_date >= $2",
                                      [start_date, end_date])
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        start_date: space['start_date'],
        end_date: space['end_date'],
        user_id: space['user_id']
      )
    end
  end

  def self.find(id:)
    return nil unless id

    result = DatabaseConnection.query(
      "SELECT * FROM spaces WHERE id = $1", [id]
    )
    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      price: result[0]['price'],
      start_date: result[0]['start_date'],
      end_date: result[0]['end_date'],
      user_id: result[0]['user_id']
    )
  end


  def self.find_spaces(user_id:)
    return nil unless user_id

    result = DatabaseConnection.query(
      "SELECT * FROM spaces WHERE user_id = $1", [user_id]
    )
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        price: space['price'],
        start_date: space['start_date'],
        end_date: space['end_date'],
        user_id: space['user_id']
      )
    end
  end
end
