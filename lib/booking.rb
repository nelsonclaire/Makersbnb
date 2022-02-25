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
    result = DatabaseConnection.query("INSERT INTO bookings(date, space_id, user_id)
                                      VALUES($1, $2, $3)
                                      RETURNING id, date, space_id, user_id, confirmed",
                                      [date, space_id, user_id])

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

  def self.checkdates(space_id:, date: dates[], user_id:)
    date.map do |date|
    space_booked = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and date = $2 and confirmed = $3",
                                      [space_id, date, true])
    space_booked_for_you = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and date = $2 and confirmed = $3 and user_id = $4" ,
                                        [space_id, date, true, user_id])
    space_pending = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and date = $2 and confirmed is null and user_id = $3" ,
                                          [space_id, date, user_id])
    space_declined = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1 and date = $2 and confirmed = $3 and user_id = $4" ,
                                            [space_id, date, false, user_id])

      if !space_booked.count.zero? 
        if space_booked_for_you.count.zero?
          {date => "Unavailable"}        
        else
          {date => "Approved"} 
        end
      elsif !space_pending.count.zero?
        {date => "Pending"} 
      elsif !space_declined.count.zero?
        {date => "Declined"} 
      else 
        {date => "Available"} 
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

  def self.find_bookings(space_id:)
    return nil unless space_id

    result = DatabaseConnection.query(
      "SELECT * FROM bookings WHERE space_id = $1 and confirmed is null", [space_id]
    )
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

#   def self.find_unconfirmed_bookings(space_id: ids[])
#     space_id.map do |space_id|

#     result = DatabaseConnection.query(
#       "SELECT * FROM bookings where space_id = $1 and confirmed is null order by date asc", [space_id]
#     )
#     result.map do |booking|
#       Booking.new(
#         id: booking['id'],
#         date: booking['date'],
#         space_id: booking['space_id'],
#         user_id: booking['user_id'],
#         confirmed: booking['confirmed']
#         )
#       end
#     end
# end

def self.find_unconfirmed_bookings

  result = DatabaseConnection.query(
    "SELECT * FROM bookings where confirmed is null order by date asc"
  )
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

  def self.find_my_bookings(user_id:)
    return nil unless user_id

    result = DatabaseConnection.query(
      "SELECT * FROM bookings WHERE user_id = $1 order by date asc", [user_id]
    )
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

  def self.approve_booking(id:, date:, space_id:)

    result = DatabaseConnection.query("UPDATE bookings SET confirmed = true WHERE id=$1;", [id])
    result = DatabaseConnection.query("UPDATE bookings SET confirmed = false WHERE space_id=$1 and date=$2 and confirmed is null;", [space_id, date])

  end
  
  def self.decline_booking(id:)

    result = DatabaseConnection.query("UPDATE bookings SET confirmed = false WHERE id=$1;", [id])
  
  end 

end
