require 'pg'

class Booking
  attr_reader :id, :date, :space_id, :user_id, :confirmed

  def initialize(id:, date:, space_id:, user_id:, confirmed:)
    @id = id
    @date = date
    @space_id = space_id
    @user_id = user_id
    @confirmed = confirmed
  end

  def self.create(date:, space_id:, user_id:)
    result = DatabaseConnection.query("INSERT INTO bookings(date, space_id, user_id, confirmed)
                                      VALUES($1, $2, $3, $4)
                                      RETURNING id, date, space_id, user_id, confirmed",
                                      [date, space_id, user_id, false])

    Booking.new(id: result[0]['id'], date: result[0]['date'], space_id: result[0]['space_id'],
                user_id: result[0]['user_id'], confirmed: result[0]['confirmed'])
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookings;")
    result.map do |booking|
      Booking.new(
        id: booking['id'],
        date: booking['date'],
        space_id: booking['space_id'],
        user_id: booking['user_id'],
        confirmed: booking['confirmed']
      )
    end
  end

  # def self.checkdates(space_id:, start_date:, end_date:)
  #   result = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and (date between $2 and $3)",
  #                                     [space_id, start_date, end_date])
  #   result.map do |booking|
  #     Booking.new(
  #       id: booking['id'],
  #       date: booking['date'],
  #       space_id: booking['space_id'],
  #       user_id: booking['user_id'],
  #       confirmed: booking['confirmed']
  #     )
  #   end
  # end

  def self.checkdates(space_id:, date: dates[])
    date.map do |date|
    space_booked = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and date = $2",
                                      [space_id, date])

                                      if space_booked.count.zero? 
                                        {date => "Available"}
                                      else  {date => "Unavailable"}
    end
  end
  end

  def self.find(id:)
    return nil unless id

    result = DatabaseConnection.query(
      "SELECT * FROM bookings WHERE id = $1", [id]
    )
    Booking.new(
      id: result[0]['id'],
      date: result[0]['date'],
      space_id: result[0]['space_id'],
      user_id: result[0]['user_id'],
      confirmed: result[0]['confirmed']
    )
  end
end
