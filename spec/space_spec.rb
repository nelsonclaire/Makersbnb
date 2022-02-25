require_relative '../lib/space'

describe Space do
  describe '#list' do
    it 'should add a space to the database' do
      user = create_test_user
      space = Space.list(
        name: "My House",
        description: "Amazing place, sea views",
        price: 100,
        start_date: '2022-01-01',
        end_date: '2022-12-31',
        user_id: user.id
      )

      expect(space).to be_a Space
      expect(space.description).to eq("Amazing place, sea views")
      expect(space.name).to eq("My House")
      expect(space.price).to eq("100")
    end
  end
end
