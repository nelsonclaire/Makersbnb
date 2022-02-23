def create_test_user
  User.create(
    name: 'Test User',
    username: 'tester',
    email: 'test@gmail.com',
    password: 'password123'
  )
end