require_relative '../lib/space'

describe Space do
  describe '#list' do
    it 'should add a space to the database' do
      space = Space.list(
        name: "Jack's House", 
        description: "Amazing place, sea views", 
        price: 100
      )
      p space
      expect(space.name).to eq("Jack's House")
    end
  end
end