def create_test_user
  @user = User.create(
    name: 'Test User',
    username: 'tester',
    email: 'test@gmail.com',
    password: 'password123'
  )
end

def user_login
  fill_in('email', with: 'test@gmail.com')
  fill_in('password', with: 'password123')
  click_button('Log in')
end

def list_test_space
  Space.list(
    name: 'Test Space',
    description: 'A space for testing against',
    price: 90,
    start_date: (Date.today).to_s,
    end_date: (Date.today +1).to_s,
    # user_id: @user.id
  )
end