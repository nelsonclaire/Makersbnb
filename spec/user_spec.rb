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

end
