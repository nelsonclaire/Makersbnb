require 'pg'

class DatabaseConnection
  
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

  def self.escape_string(string_to_clean)
    @connection.escape_string(string_to_clean)
  end

end