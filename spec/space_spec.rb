require_relative '../lib/space'

describe Space do
  describe '#list' do
    it 'should add a space to the database' do
      space = Space.list(
        name: "Jack's House", 
        description: "Amazing place, sea views", 
        price: 100
      )
      
      expect(space).to be_a Space
      expect(space.description).to eq("Amazing place, sea views")
      expect(space.name).to eq("Jack's House")
      expect(space.price).to eq("100")
    end
  end
end 