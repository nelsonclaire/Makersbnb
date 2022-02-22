require 'database_connection'

describe DatabaseConnection do
  it 'sets up a connection to a database through PG' do
    expect(PG).to receive(:connect).with(dbname: 'makersbnb_test')

    DatabaseConnection.setup('makersbnb_test')
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('makersbnb_test')

      expect(connection).to receive(:exec_params).with("SELECT * FROM spaces;", [])

      DatabaseConnection.query("SELECT * FROM spaces;")
    end
  end
end