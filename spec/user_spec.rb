require "user"

describe User do
  describe ".create" do
    it "creates a new user" do
      # Add test data
      User.create(
        name: "Amelia Earhart",
        email: "amelia@gmail.com",
        password: "flying",
        username: "acepilot"
      )
      expect(User.all[0].username).to eq "acepilot"
    end

    it " handles error when duplicate username or email is entered" do
      # Add test data
      User.create(
        name: "Amelia Earhart",
        email: "amelia@gmail.com",
        password: "flying",
        username: "acepilot"
      )
      # Add test data
      User.create(
        name: "David Attenborough",
        email: "david@gmail.com",
        password: "tortoises",
        username: "acepilot"
      )
      expect(User.all.length).to eq 1
    end
  end

  describe ".find" do
    it 'returns the requested user object' do
      user = User.create(
        name: "Jack",
        email: "jack@gmail.com",
        password: "Jack",
        username: "jack"
      )
      result = User.find(id: user.id)
      expect(result).to be_a User
      expect(result.id).to eq(user.id)
      expect(result.name).to eq(user.name)
      expect(result.email).to eq("jack@gmail.com")
    end
  end
end
